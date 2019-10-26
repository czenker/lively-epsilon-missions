local My = My or {}
local t = My.Translator.translate
local f = string.format


local totalPowerCost = 100
local totalBeamHeat = 0.6

local findAsteroidToMine = function(player)
    -- finding the asteroid to mine is rather complex as we need to consider beam reach and angles
    -- the calculation is off, because ships might not have all their beams centered, but it should be good enough for small ships
    local maxRange = 0
    for idx=0,9 do
        if player:getBeamWeaponDamage(idx) > 0 then
            maxRange = math.max(maxRange, player:getBeamWeaponRange(idx))
        end
    end

    for _, thing in pairs(player:getObjectsInRange(maxRange)) do
        if isEeAsteroid(thing) then
            -- so we found an asteroid in laser range. Now check if it is actually targeted by a laser
            for idx=0,9 do
                if player:getBeamWeaponDamage(idx) > 0 then
                    local rot = (player:getRotation() + player:getBeamWeaponDirection(idx)) % 360
                    local pX, pY = player:getPosition()
                    local aX, aY = thing:getPosition()
                    local angle = Util.angleFromVector(aX - pX, aY - pY)

                    if math.abs(Util.angleDiff(rot, angle)) <= player:getBeamWeaponArc(idx) / 2 then
                        return thing
                    end
                end
            end
        end
    end
    return nil
end

My.EventHandler:register("onStart", function()
    if not isFunction(BeamEffect) then
        logWarning("Not allowing to mine asteroids, because version of Empty Epsilon is too old. Please upgrade it.")
        return
    end

    local player = My.World.player

    local isMiningInProgress = false

    player:addWeaponsMenuItem("mining", Menu:newItem(t("player_mining_label"), function()
        if isMiningInProgress then return end

        if player:getSystemHealth("beamweapons") < 1 or player:getSystemHeat("beamweapons") > 0.9 or player:getSystemPower("beamweapons") < 1 then
            return t("player_mining_error_invalid_station")
        end
        if player:getEnergy() < totalPowerCost then
            return t("player_mining_error_not_enough_power", totalPowerCost)
        end
        local asteroid = findAsteroidToMine(player)
        if asteroid == nil then
            return t("player_mining_error_invalid_target")
        end

        isMiningInProgress = true

        -- charge the lasers
        local timeRemaining = 5
        Cron.regular(function(self, delta)
            if not player:isValid() then Cron.abort(self) end
            timeRemaining = timeRemaining - delta
            player:setEnergy(player:getEnergy() - delta * totalPowerCost / 5)

            if timeRemaining <= 0 then Cron.abort(self) end
        end)

        -- make the mining and explosion visually appealing
        playSoundFile("resources/sfx/charge.flac")

        local visualMining = function()
            local heat = totalBeamHeat / 3
            local excessiveHeat = math.max(0 , player:getSystemHeat("beamweapons") + heat - 1)
            if excessiveHeat > 0 then
                -- it damages the station
                player:setSystemHealth("beamweapons", player:getSystemHealth("beamweapons") - excessiveHeat)
            end
            player:setSystemHeat("beamweapons", player:getSystemHeat("beamweapons") + heat - excessiveHeat)

            local aX, aY = asteroid:getPosition()
            local pX, pY = player:getPosition()
            local angle = Util.angleFromVector(pX - aX, pY - aY)

            local x, y = aX, aY
            x, y = Util.addVector(x, y, angle + math.random(-60, 60), 60)

            BeamEffect():setSource(player, 0, 0, 0):setTarget(asteroid, 0, 0)
            ExplosionEffect():setPosition(x, y):setSize(math.random(60, 150))
        end
        Cron.once(visualMining, 5)
        Cron.once(visualMining, 5.5)
        Cron.once(visualMining, 6)

        -- spawn the supply crate
        Cron.once(function()
            local resources = asteroid:mine(player)
            logInfo(f("Mined %d %s and %d %s.", resources[products.ore], t("products_ore_name"), resources[products.plutoniumOre], t("products_plutoniumOre_name")))
        end, 6)
        Cron.once(function() isMiningInProgress = false end, 6)
    end))
end)