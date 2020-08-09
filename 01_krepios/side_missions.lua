local f = string.format

My = My or {}
My.SideMissions = My.SideMissions or {}

-- used to have fair payment for all missions that include moving from A to B
My.SideMissions.paymentPerDistance = function(distanceTraveled)
    return (10 + distanceTraveled / 1500) * (math.random() * 0.4 + 0.8)
end
My.SideMissions.paymentPerEnemy = function()
    return math.random(60, 90)
end


My.EventHandler:register("onWorldCreation", function()
    local maxDistance = 60000

    -- lets assign regions to all stations where violent side missions can take place

    local stations = My.World.stations
    for _, station in pairs(stations) do station.battlefields = {} end

    local battlefields = {}

    for _,nebula in pairs(My.World.nebulas) do
        if not nebula:hasUse() then
            table.insert(battlefields, nebula)
        end
    end
    for _, station in pairs(My.World.abandonedStations) do table.insert(battlefields, station) end
    for _, graveyard in pairs(My.World.shipGraveyards) do table.insert(battlefields, graveyard) end

    battlefields = Util.randomSort(battlefields)

    local max = Util.size(battlefields)
    for i=1, max, 1 do
        local station = stations[i%Util.size(stations) + 1]

        local closestBattlefield = nil
        local closestIdx = nil
        local closestDistance = nil
        for idx,bf in pairs(battlefields) do
            local d = distance(bf, station)
            if d < maxDistance and (closestDistance == nil or closestDistance > d) then
                closestDistance = d
                closestIdx = idx
                closestBattlefield = bf
            end
        end

        if closestBattlefield ~= nil then
            local name
            if isFunction(closestBattlefield.getCallSign) then
                name = closestBattlefield:getCallSign()
            elseif isFunction(closestBattlefield.getName) then
                name = closestBattlefield:getName()
            end
            closestBattlefield.isBattlefield = true
            if isFunction(closestBattlefield.setUse) then closestBattlefield:setUse("battlefield", station) end
            logDebug("Add battlefield " .. name .. " for station " .. station:getCallSign())
            table.insert(station.battlefields, closestBattlefield)
            table.remove(battlefields, closestIdx)
        end

    end

end, 900)


-- find a location that is safe to spawn enemies
local findSafeLocation = function(station)
    local minDistanceFromHarm = 10000
    local sx, sy = station:getPosition()

    return My.World.Helper.tryMinDistance(function()
        local dx, dy = vectorFromAngle(math.random(0, 360), math.random(minDistanceFromHarm, 30000))
        return sx + dx, sy + dy
    end, function(thing)
        return isEeMine(thing) or isEeShipTemplateBased(thing) or isEeWormHole(thing) or isEeBlackHole(thing) or isEeStation(thing)
    end, minDistanceFromHarm)
end

local getBattlefieldStationFor = function(station, player)
    local bfs = {}

    for i,bf in pairs(station.battlefields) do
        if isEeStation(bf) then
            bfs[bf] = bf
        end
    end

    for _,mission in pairs(station:getMissions()) do
        if mission.battlefield ~= nil then
            bfs[mission.battlefield] = nil
        end
    end
    for _,mission in pairs(player:getStartedMissions()) do
        if mission.battlefield ~= nil then
            bfs[mission.battlefield] = nil
        end
    end

    return Util.random(bfs)
end

local getBattlefieldNebulaFor = function(station, player)
    local bfs = {}

    for i,bf in pairs(station.battlefields) do
        if isFunction(bf.getRandomPosition) then
            bfs[bf] = bf
        end
    end

    for _,mission in pairs(station:getMissions()) do
        if mission.battlefield ~= nil then
            bfs[mission.battlefield] = nil
        end
    end
    for _,mission in pairs(player:getStartedMissions()) do
        if mission.battlefield ~= nil then
            bfs[mission.battlefield] = nil
        end
    end

    return Util.random(bfs)
end

local getBattlefieldGraveyardFor = function(station, player)
    local bfs = {}

    for i,bf in pairs(station.battlefields) do
        if isFunction(bf.spawnShip) then
            bfs[bf] = bf
        end
    end

    for _,mission in pairs(station:getMissions()) do
        if mission.battlefield ~= nil then
            bfs[mission.battlefield] = nil
        end
    end
    for _,mission in pairs(player:getStartedMissions()) do
        if mission.battlefield ~= nil then
            bfs[mission.battlefield] = nil
        end
    end

    return Util.random(bfs)
end

local numberOfCreatedTransportMissionsByIndex = {}
local numberOfCreatedFightingMissionsByIndex = {}

My = My or {}
My.MissionGenerator = {
    randomTransportMission = function(from)
        local possibleDestinations = {}
        for _, station in pairs(My.World.stations) do
            if station:isValid() and from ~= station then possibleDestinations[station] = station end
        end

        local to = Util.random(possibleDestinations)
        if to == nil then return nil end

        local missionFactories = {
            function()
                return My.SideMissions.TransportProduct(from, to, My.World.player)
            end,
            function()
                return My.SideMissions.TransportHuman(from, to)
            end,
            function()
                return My.SideMissions.TransportThing(from, to, My.World.player)
            end,
            function()
                return My.SideMissions.Repair(from, to, My.World.player)
            end,
            function()
                if Station:hasMerchant(from) then
                    local product = Util.random(from:getProductsBought())
                    return My.SideMissions.Buyer(from, product)
                else
                    return nil
                end
            end,
            function()
                return My.SideMissions.SecretCode(from, to)
            end,
            function()
                return My.SideMissions.GatherCrystals(from)
            end,
            function()
                return My.SideMissions.ScanAsteroids(from)
            end,
            function()
                return My.SideMissions.ScanCrystal(from)
            end,
            function()
                return My.SideMissions.DriveTest(from)
            end,
        }

        for i, missionFactory in ipairs(missionFactories) do
            missionFactories[i] = {
                idx = i,
                factory = missionFactory
            }
        end
        table.sort(missionFactories, function(a,b)
            return (numberOfCreatedTransportMissionsByIndex[a.idx] or 0) < (numberOfCreatedTransportMissionsByIndex[b.idx] or 0)
        end)

        for _,missionFactory in pairs(missionFactories) do
            local mission = missionFactory.factory()
            if mission ~= nil then
                numberOfCreatedTransportMissionsByIndex[missionFactory.idx] = (numberOfCreatedTransportMissionsByIndex[missionFactory.idx] or 0) + 1

                Mission:withTags(mission, "transport", "side_mission")
                return mission
            end
        end

        return nil
    end,
    randomFightingMission = function(from)
        local missionFactories = {
            function()
                local nebula = getBattlefieldNebulaFor(from, My.World.player)
                if nebula == nil then return nil end

                local x,y = nebula:getRandomPosition()
                local mission = My.SideMissions.PirateBase(from, x, y, My.World.player)
                mission.battlefield = nebula
                return mission
            end,
            function()
                local station = getBattlefieldStationFor(from, My.World.player)
                if station == nil then return nil end

                local x,y = station:getPosition()
                local mission = My.SideMissions.Capture(from, x, y, My.World.player)
                mission.battlefield = station
                return mission
            end,
            function()
                if not from:hasTag("mining") then return nil end

                local x, y = findSafeLocation(from)
                return My.SideMissions.RagingMiner(from, x, y, My.World.player)
            end,
            function()
                local x, y
                local nebula
                if math.random(0, 1) == 0 then
                    nebula = getBattlefieldNebulaFor(from, My.World.player)
                end
                if nebula == nil then
                    x, y = findSafeLocation(from)
                else
                    x,y = nebula:getRandomPosition()
                end

                local mission = My.SideMissions.DisableShip(from, x, y, My.World.player)
                if nebula ~= nil then
                    mission.battlefield = nebula
                end
                return mission
            end,
            function()
                local graveyard = getBattlefieldGraveyardFor(from, My.World.player)
                if graveyard == nil then return nil end

                local mission = My.SideMissions.DestroyGraveyard(from, graveyard, My.World.player)
                mission.battlefield = graveyard
                return mission
            end,
            function()
                if not from:hasTag("shipyard") then return nil end

                return My.SideMissions.ArenaFight(from)
            end,
        }

        for i, missionFactory in ipairs(missionFactories) do
            missionFactories[i] = {
                idx = i,
                factory = missionFactory
            }
        end
        table.sort(missionFactories, function(a,b)
            return (numberOfCreatedFightingMissionsByIndex[a.idx] or 0) < (numberOfCreatedFightingMissionsByIndex[b.idx] or 0)
        end)

        for _,missionFactory in pairs(missionFactories) do
            local mission = missionFactory.factory()
            if mission ~= nil then
                numberOfCreatedFightingMissionsByIndex[missionFactory.idx] = (numberOfCreatedFightingMissionsByIndex[missionFactory.idx] or 0) + 1

                Mission:withTags(mission, "fighting", "side_mission")
                return mission
            end
        end
    end,
}