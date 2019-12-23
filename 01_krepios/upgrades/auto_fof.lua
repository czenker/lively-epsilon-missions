My = My or {}
local t = My.Translator.translate

local pingSeconds = 2

My.EventHandler:register("onStart", function()
    local ship = CpuShip()
    local isFeatureAvailable = isFunction(ship.setScanStateByFaction)
    ship:destroy()

    if not isFeatureAvailable then
        logWarning("Not activating the Auto-Friend-or-Foe update, because version of Empty Epsilon is too old. Please upgrade it.")
        return
    end

    My.installAutoFriendOrFoe = function(player)
        Cron.regular(function(self)
            if not player:isValid() then
                Cron.abort(self)
                return
            end

            local things = player:getObjectsInRange(getLongRangeRadarRange())
            local closestUnscannedThing, closestDistance = nil, 999999

            for _, thing in pairs(things) do
                if isEeObject(thing) and isFunction(thing.setScanStateByFaction) and not thing:isFriendOrFoeIdentifiedBy(player) then
                    local d = distance(player, thing)
                    if d < closestDistance then
                        closestUnscannedThing = thing
                        closestDistance = d
                    end
                end
            end

            if closestUnscannedThing ~= nil then
                logInfo("Scanning " .. closestUnscannedThing:getCallSign() .. " for " .. player:getCallSign())
                closestUnscannedThing:setScanStateByFaction(player:getFaction(), "friendorfoeidentified")
            end
        end, pingSeconds, pingSeconds)
    end
end)
