local t = My.Translator.translate

My = My or {}
My.SideMissions = My.SideMissions or {}

local versions = {
    {"MT52 Hornet", "MT52 Hornet", "MT52 Hornet"},
    {"MT52 Hornet", "Adder MK6", "Adder MK6"},
    {"Piranha F12", "Adder MK6", "Adder MK6"},
    {"Piranha F12", "Nirvana R5", "Adder MK6", "Adder MK6"},
    {"Piranha F12", "Nirvana R5", "Nirvana R5", "Adder MK6", "Adder MK6"},
}

local maxDifficulty = 1

Cron.regular("pirate_base_progressive_difficulty", function(self)
    -- progressively make enemies harder
    if maxDifficulty < Util.size(versions) then
        maxDifficulty = maxDifficulty + 1
        logDebug("Increased maximum difficulty of Pirate Base Mission to " .. maxDifficulty)
    else
        logDebug("Pirate Base Mission has reached its maximum difficulty level " .. maxDifficulty)
        Cron.abort(self)
    end
end, 480, 480)

local DefenderTemplate = function(templateName)
    local ship = My.CpuShip(templateName, "Pirate")

    return ship
end

local StationTemplate = function()
    local station = My.SpaceStation("Small Station", "Pirate")
    station:addTag("mute")

    return station
end

local WarpJammerTemplate = function()
    local jammer = My.WarpJammer("Pirate")

    return jammer
end

My.SideMissions.PirateBase = function(station, x, y, player)
    local version = Util.random({
        "station",
        "jammer",
    })
    local playerDps = Util.totalLaserDps(player) * 2 -- account for tubes
    if playerDps < 1 then return nil end

    local difficulty = math.random(1,maxDifficulty)
    local payment = My.SideMissions.paymentPerDistance(distance(station, x, y)) + (Util.size(versions[difficulty]) + 1) * (0.5 + 0.1 * difficulty) * My.SideMissions.paymentPerEnemy()

    local sectorName = Util.sectorName(x, y)

    -- make the station destroyable in reasonable time or it gets boring
    local stationShield = (math.random() * 0.4 + 0.8) * playerDps * 25
    local stationHull = (math.random() * 0.4 + 0.8) * playerDps * 25

    local mission = Missions:destroy(function()
        local target
        if version == "station" then
            target = StationTemplate():
            setCallSign(My.pirateStationName()):
            setHullMax(stationHull):
            setHull(stationHull):
            setShieldsMax(stationShield):
            setShields(stationShield):
            setScannedDescription(t("side_mission_pirate_base_station_description"))
        else
            target = WarpJammerTemplate():
            setRange(20000):
            setScannedDescription(t("side_mission_pirate_base_jammer_description"))
        end
        target:setPosition(x, y)

        local ships = {}
        for _, template in pairs(versions[difficulty]) do
            local ship = DefenderTemplate(template):
            setCallSign(My.pirateShipName())
            ship:setScannedDescription(t("pirate_ship_description"))

            table.insert(ships, ship)

            Util.spawnAtStation(target, ship)
            ship:orderDefendTarget(target)
        end
        table.insert(ships, target)
        return ships
    end, {
        acceptCondition = function(self, error)
            if distance(player, x, y) < 15000 then
                return t("side_mission_pirate_base_comms_too_close")
            end
            return true
        end,
        onStart = function(self)
            local hint = t("side_mission_pirate_base_" .. version .. "_start_hint", sectorName)
            self:setHint(hint)
            self:getPlayer():addToShipLog(hint, "255,127,0")
        end,
        onDestruction = function(self, enemy)
            local numShips, numStations = 0, 0
            for _, thing in pairs(self:getValidEnemies()) do
                if isEeStation(thing) or isEeWarpJammer(thing) then numStations = numStations + 1
                elseif isEeShip(thing) then numShips = numShips + 1
                end
            end
            if isEeShip(enemy) then
                if numShips == 0 then
                    self:getPlayer():addToShipLog(t("side_mission_pirate_base_destruction_last_hint"), "255,127,0")
                else
                    self:getPlayer():addToShipLog(t("side_mission_pirate_base_destruction_ship_hint"), "255,127,0")
                end
            elseif isEeStation(enemy) then
                self:getPlayer():addToShipLog(t("side_mission_pirate_base_destruction_station_hint"), "255,127,0")
            elseif isEeWarpJammer(enemy) then
                self:getPlayer():addToShipLog(t("side_mission_pirate_base_destruction_jammer_hint"), "255,127,0")
            end

            self:setHint(t("side_mission_pirate_base_" .. version .. "_destruction_hint", numShips, numStations > 0))
        end,
        onSuccess = function(self)
            station:sendCommsMessage(self:getPlayer(), t("side_mission_pirate_base_success_comms", payment))
            self:getPlayer():addReputationPoints(payment)
        end,
        onEnd = function(self)
            for _, enemy in pairs(self:getEnemies() or {}) do
                if isEeObject(enemy) and enemy:isValid() then
                    enemy:destroy()
                end
            end
        end,
    })

    Mission:withBroker(mission, t("side_mission_pirate_base_" .. version, sectorName), {
        description = t("side_mission_pirate_base_" .. version .. "_briefing", difficulty, sectorName, payment),
        acceptMessage = nil,
    })

    return mission
end