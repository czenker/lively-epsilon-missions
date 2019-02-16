My = My or {}
My.Simulations = My.Simulations or {}

-- a little necessary helper to display status information for positions, because of:
--
-- * calling player:addCustomInfo() too often in short succession leaves the text unchanged.
--   so we will change the displayId
-- * sending the message all to often might spam the network
--   so only send if there is actually new text
My.Simulations.infoPanel = function(player, position, id)
    if not isEePlayer(player) then error("Expected player to be a PlayerSpaceship, but got " .. typeInspect(player) .. ".", 2) end
    if not isString(position) then error("Expected position to be a string, but got " .. typeInspect(position) .. ".", 2) end
    id = id or Util.randomUuid()
    local flipFlop = 0
    local lastMessage

    local displayId = function()
        return id .. flipFlop
    end

    return {
        write = function(self, message)
            if message ~= lastMessage then
                player:removeCustom(displayId())
                flipFlop = (flipFlop + 1) % 2

                player:addCustomInfo(position, displayId(), message)
                lastMessage = message
            end
        end,
        remove = function()
            player:removeCustom(displayId())
        end
    }
end


-- a watchdog that keeps track that the simulation does not run out of control
--
-- it can abort a mission if
-- * an alert is triggered on the real ship
-- * the ship in the simulation leaves a certain area
-- * a certain time limit is reached
-- * no player on the position
My.Simulations.watchdog = function(player, originalPlayer, position, timelimit, minX, maxX, minY, maxY, onAbort, id)
    if not isEePlayer(player) then error("Expected player to be a PlayerSpaceship, but got " .. typeInspect(player) .. ".", 2) end
    if not isEePlayer(originalPlayer) then error("Expected originalPlayer to be a PlayerSpaceship, but got " .. typeInspect(originalPlayer) .. ".", 2) end
    if not isString(position) then error("Expected position to be a string, but got " .. typeInspect(position) .. ".", 2) end
    if not isNumber(timelimit) then error("Expected timelimit to be a number, but got " .. typeInspect(timelimit) .. ".", 2) end
    if not isNumber(minX) then error("Expected minX to be a number, but got " .. typeInspect(minX) .. ".", 2) end
    if not isNumber(maxX) then error("Expected maxX to be a number, but got " .. typeInspect(maxX) .. ".", 2) end
    if not isNumber(minY) then error("Expected minY to be a number, but got " .. typeInspect(minY) .. ".", 2) end
    if not isNumber(maxY) then error("Expected maxY to be a number, but got " .. typeInspect(maxY) .. ".", 2) end
    if minX > maxX then error("Expected minX to be smaller than maxX, but " .. minX .. " > " .. maxX .. ".", 2) end
    if minY > maxY then error("Expected minY to be smaller than maxY, but " .. minY .. " > " .. maxY .. ".", 2) end
    if not isFunction(onAbort) then error("Expected onAbort to be a function, but got " .. typeInspect(onAbort) .. ".", 2) end

    id = id or Util.randomUuid()
    local cronIdWatchdog = id .. "-watchdog"
    local cronIdTimeout = id .. "-timer"
    local isStarted = false

    local function abort()
        Cron.abort(cronIdWatchdog)
        Cron.abort(cronIdTimeout)

        onAbort()
    end

    return {
        start = function()
            Cron.once(cronIdTimeout, function()
                logWarning(string.format("Aborting simulation because limit of %.1fs for simulation was reached.", timelimit))
                originalPlayer:addCustomMessage(position, Util.randomUuid(), "The simulation was aborted because you exceeded the alloted time.")
                abort()
            end, timelimit)
            Cron.regular(cronIdWatchdog, function()
                local x,y = player:getPosition()
                if x < minX or x > maxX or y < minY or y > maxY then
                    logWarning(string.format(
                        "Aborting simulation because player at position (%d,%d) was out of bounds (%d,%d)-(%d,%d).",
                        x, y, minX, minY, maxX, maxY
                    ))
                    originalPlayer:addCustomMessage(position, Util.randomUuid(), "The simulation was aborted because you left the area of operation.")
                    abort()
                elseif originalPlayer:getAlertLevel() == "YELLOW ALERT" or originalPlayer:getAlertLevel() == "RED ALERT" then
                    originalPlayer:addCustomMessage(position, Util.randomUuid(), "Simulations are not available during alerts.")
                    abort()
                elseif not player:hasPlayerAtPosition(position) then
                    originalPlayer:addCustomMessage(position, Util.randomUuid(), "The simulation ended because no player is currently manning the " .. position .. " position.")
                    abort()
                end
            end, 0.1)
            isStarted = true
        end,
        isStarted = function()
            return isStarted
        end,
        stop = function()
            Cron.abort(cronIdWatchdog)
            Cron.abort(cronIdTimeout)
            isStarted = false
        end
    }
end