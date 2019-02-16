local t = My.Translator.translate

local commanderLocation
local commander

My.Commander = {
    getLocation = function() return commanderLocation end,
    getPerson = function() return commander end,
    isAlive = function() return My.Commander:getLocation() ~= nil and My.Commander:getLocation():isValid() end
}

local CommanderShipTemplate = function()
    local ship = My.CpuShip("Stalker Q7", "Human Navy"):
    setBeamWeapon(0, 0, 0, 0, 9999, 0):
    setBeamWeapon(1, 0, 0, 0, 9999, 0):
    setWeaponTubeCount(0):
    setImpulseMaxSpeed(140)

    return ship
end

My.EventHandler:register("onStart", function()
    commanderLocation = My.World.hq
    commander = My.Config.commander

    Cron.regular(function(self)
        if not My.Commander:isAlive() then
            Cron.abort(self)
            My.EventHandler:fire("onCommanderDead")
        end
    end, 1)
end)

My.EventHandler:register("onAttackersDetection", function()
    local ship = CommanderShipTemplate()
    Ship:withCaptain(ship, My.Commander:getPerson())
    ship:setCallSign(My.Commander:getPerson():getFormalName())
    ship:setCanBeDestroyed(false)
    Util.spawnAtStation(commanderLocation, ship)
    commanderLocation = ship

    ship:setHailText(t("comms_generic_flight_hail"))
    ship:setScannedDescription(t("mines_miner_description", ship:getCallSign(), ship:getCaptain()))

    Cron.regular(function(self)
        if not ship:isValid() then
            Cron.abort(self)
        else
            -- make sure the ship does not get stuck
            ship:setSystemHealth("maneuver", 1)
            ship:setSystemHealth("impulse", 1)
            ship:setSystemHealth("warp", 1)
        end
    end, 1)

    ship:addOrder(Order:dock(My.World.fortress, {
        onCompletion = function(_, ship)
            My.World.player:addToShipLog(t("story_mission_plan_defense_arrival", My.Commander:getPerson(), My.World.fortress:getCallSign()), "255,127,0")

            My.EventHandler:fire("onFortressManned")
            if ship:isValid() then ship:destroy() end
        end
    }))
end)

My.EventHandler:register("onFortressManned", function()
    commanderLocation = My.World.fortress
end, 10)

My.EventHandler:register("onCommanderDead", function()
    commanderLocation = nil
end)