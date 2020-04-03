My = My or {}
local t = My.Translator.translate

local minSpawnDistance = 7500
local maxSpawnDistance = 15000
local numSpawnTries = 12

local ratingVeryBad = -999
local ratingBad = -99
local ratingNotGood = -9
local ratingGood = 9
local ratingVeryGood = 99
local ratingDistance = -2 -- malus per 1000u distance

local factionName = "Outlaw"

local shipTemplates = {
    "ZX-Lindworm",
    "MU52 Hornet",
    "MT52 Hornet",
    "Adder MK5",
    "Adder MK6"
}

-- find a position to spawn the raid.
-- * nebulas are preferred
-- * spawning inside a planet or a blackhole is discouraged
-- * spawning very close to a player is not preferred
local findSpawnPosition = function(centerX, centerY)

    local closePlayers = {}
    local closeNebulas = {}
    local closeMines = {}
    local closeAsteroids = {}
    local closeBlackHoles = {}
    local closePlanets = {}
    local closeScanProbes = {}
    local closeShipsOrStations = {}

    for _, obj in pairs(getObjectsInRadius(centerX, centerY, maxSpawnDistance + 10000)) do
        if isEePlayer(obj) then
            table.insert(closePlayers, obj)
        elseif isEeNebula(obj) then
            table.insert(closeNebulas, obj)
        elseif isEeMine(obj) then
            table.insert(closeMines, obj)
        elseif isEeAsteroid(obj) then
            table.insert(closeAsteroids, obj)
        elseif isEeBlackHole(obj) then
            table.insert(closeBlackHoles, obj)
        elseif isEePlanet(obj) then
            table.insert(closePlanets, obj)
        elseif isEeScanProbe(obj) then
            table.insert(closeScanProbes, obj)
        elseif isEeShipTemplateBased(obj) then
            table.insert(closeShipsOrStations, obj)
        end
    end

    local initialAngle = math.random(0, 359)

    local bestX, bestY
    local bestRating = -9999999

    -- TODO: dummy used to check faction relations. This is ugly.
    local dummy = CpuShip("Decoy"):setFaction(factionName)

    -- now try a number of possible spawn locations around
    for i=0,numSpawnTries-1 do
        local angle = initialAngle + (360 / numSpawnTries) * i
        local dist = math.random(minSpawnDistance, maxSpawnDistance)

        local x, y = Util.addVector(centerX, centerY, angle, dist)
        local rating = 0
        local isInNebula = false
        for _, nebula in pairs(closeNebulas) do
            -- does not matter if we spawn in nebula or behind it: no one will see us
            if Util.distanceToLineSegment(centerX, centerY, x, y, nebula) < 5000 then
                isInNebula = true
                rating = rating + ratingVeryGood
            end
        end
        for _, player in pairs(closePlayers) do
            -- try to spawn far from the player
            local d = distance(player, x, y)
            if d <= player:getShortRangeRadarRange() then
                rating = rating + ratingVeryBad
            elseif not isInNebula then
                if d <= player:getLongRangeRadarRange() then
                    rating = rating - ratingBad
                elseif d <= player:getLongRangeRadarRange() then
                    rating = rating - ratingNotGood
                end
            end
        end
        for _, mine in pairs(closeMines) do
            if distance(mine, x, y) < 1600 then rating = rating + ratingVeryBad end
            if Util.distanceToLineSegment(centerX, centerY, x, y, mine) < 1000 then rating = rating + ratingNotGood end
        end
        for _, asteroid in pairs(closeAsteroids) do
            if distance(asteroid, x, y) < 500 then rating = rating + ratingVeryBad end
        end
        for _, blackhole in pairs(closeBlackHoles) do
            -- spawning in a black hole? Very BAAAAD.
            if distance(blackhole, x, y) < 6000 then rating = rating + ratingVeryBad end
            -- spawning on the other side of a black hole? Bad for chasing
            if Util.distanceToLineSegment(centerX, centerY, x, y, blackhole) < 6000 then rating = rating + ratingBad end
        end
        for _, planet in pairs(closePlanets) do
            -- flying around a planet to get to your target? Bad.
            if Util.distanceToLineSegment(centerX, centerY, x, y, planet) < 6000 then rating = rating + ratingBad end
        end
        for _, scanProbe in pairs(closeScanProbes) do
            -- try not to spawn in close to a players scan probe
            if distance(scanProbe, x, y) < 5000 then rating = rating + ratingBad end
        end
        for _, shipOrStation in pairs(closeShipsOrStations) do
            if shipOrStation:isEnemy(dummy) then
                -- try not to spawn in close to an enemy
                if distance(shipOrStation, x, y) < 5000 then rating = rating + ratingBad end
                -- try not to have too many enemies between you and your target
                if Util.distanceToLineSegment(centerX, centerY, x, y, shipOrStation) < 5000 then rating = rating + ratingBad end
            elseif shipOrStation:isFriendly(dummy) then
                -- spawning close to friends is awesome
                if distance(shipOrStation, x, y) < 5000 then rating = rating + ratingGood end
                if Util.distanceToLineSegment(centerX, centerY, x, y, shipOrStation) < 5000 then rating = rating + ratingGood end
            end
        end

        -- spawning closer to your target is better
        rating = rating + ratingDistance * dist / 1000

        if rating > bestRating then
            bestX, bestY, bestRating = x, y, rating
        end
    end

    dummy:destroy()

    return bestX, bestY
end

-- start a raid with pirates.
-- They will spawn preferably in a nearby nebula and attack a target.
My.pirateRaid = function(target, numberOfShips)
    numberOfShips = numberOfShips or 2
    local ships = {}

    local targetX, targetY = target:getPosition()
    local x, y = findSpawnPosition(targetX, targetY)

    for i=1,numberOfShips do
        local shipX, shipY = Util.addVector(x, y, math.random(0,359), math.random(100, 300))
        local rotation = Util.angleFromVector(targetX - shipX, targetY - shipY)
        local ship = My.CpuShip(Util.random(shipTemplates), factionName):
        setCallSign(My.pirateShipName()):
        setPosition(shipX, shipY):
        setRotation(rotation):
        setScannedDescription(t("pirate_ship_description"))

        table.insert(ships, ship)
    end
    table.sort(ships, function(a, b) return a:getImpulseMaxSpeed() < b:getImpulseMaxSpeed() end)

    local fleet = Fleet:new(ships)

    fleet:orderAttack(target)

    return fleet
end