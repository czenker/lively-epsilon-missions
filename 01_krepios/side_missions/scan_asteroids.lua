local t = My.Translator.translate

My = My or {}
My.SideMissions = My.SideMissions or {}

local findAsteroid = function(station)
    return Util.random(station:getObjectsInRange(20000), function(_, thing)
        return isEeAsteroid(thing) and isFunction(thing.getName)
    end)
end
local findAsteroidCluster = function(station)
    for _=1,10 do
        local asteroid = findAsteroid(station)
        if not asteroid then return nil end

        local asteroids = {}

        for _, thing in pairs(asteroid:getObjectsInRange(3000)) do
            if isEeAsteroid(thing) and isFunction(thing.getName) then
                table.insert(asteroids, thing)
            end
        end
        if Util.size(asteroids) > 1 then
            return asteroids
        end
    end
    return nil
end

My.SideMissions.ScanAsteroids = function(station)
    if not station:hasTag("mining") then
        logDebug(station:getCallSign() .. " is not a mining station")
        return
    end

    local asteroids = findAsteroidCluster(station)
    if not asteroids then return nil end
    local numberOfAsteroids = Util.size(asteroids)

    local distance = math.max(distance(station, asteroids[1]) - 20000 * 0.8, 0)
    local basePayment = My.SideMissions.paymentPerDistance(distance)
    local paymentPerAsteroid = (math.random() * 4 + 3)

    local payment = basePayment + numberOfAsteroids * paymentPerAsteroid
    local mission

    local updateHint = function(mission)
        local asteroidNames = {}
        local sectorName = ""

        for _, asteroid in pairs(mission:getUnscannedTargets()) do
            table.insert(asteroidNames, asteroid:getName())
            if sectorName == "" then
                sectorName = asteroid:getSectorName()
            end
        end
        mission:setHint(t("side_mission_scan_asteroids_hint", asteroidNames, sectorName))
        if mission:countUnscannedTargets() > 0 then
            mission:getPlayer():addToShipLog(t("side_mission_scan_asteroids_short_hint", mission:countUnscannedTargets()), "255,127,0") -- it would just clutter the ships log
        end
    end

    mission = Missions:scan(asteroids, {
        scan = "simple",
        onAccept = function(self)
            for _, asteroid in pairs(asteroids) do
                asteroid:setScanned(false)
                asteroid:setScanningParameters(1,1)
                asteroid:setCallSign(asteroid:getName()) -- to make them easier to find
            end
        end,
        onStart = updateHint,
        onScan = function(self, asteroid)
            asteroid:setCallSign("")
            updateHint(self)
        end,
        onDestruction = updateHint,

        onSuccess = function(self)
            local payment = basePayment + self:countScannedTargets() * paymentPerAsteroid
            self:getMissionBroker():sendCommsMessage(self:getPlayer(), t("side_mission_scan_asteroids_success", payment))
            self:getPlayer():addReputationPoints(payment)
        end,
        onEnd = function(self)
            for _, asteroid in pairs(asteroids) do
                if asteroid:isValid() then asteroid:setCallSign("") end
            end
        end,
    })

    local asteroidNames = {}
    local sectorName = ""
    for _, asteroid in pairs(asteroids) do
        table.insert(asteroidNames, asteroid:getName())
        if sectorName == "" then
            sectorName = asteroid:getSectorName()
        end
    end

    Mission:withBroker(mission, t("side_mission_scan_asteroids", numberOfAsteroids), {
        description = t("side_mission_scan_asteroids_description", numberOfAsteroids, sectorName, payment),
        acceptMessage = t("side_mission_scan_asteroids_accept", asteroidNames, sectorName),
    })

    return mission
end