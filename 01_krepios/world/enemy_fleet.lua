local fleets = {}
local frequency = math.random(2, 18)

My.EnemyFleet = {
    isValid = function()
        if isTable(fleets) then
            for _, fleet in pairs(fleets) do
                if fleet:isValid() then
                    return true
                end
            end
            return false
        else
            return nil
        end
    end,
    getFleets = function() return fleets end,
    getShieldFrequencyBand = function() return frequency end,
}

local callSign = function(fleetNr, shipNr)
    local name = ""
    if fleetNr == 1 then name = name .. "Davar"
    elseif fleetNr == 2 then name = name .. "Myagma"
    elseif fleetNr == 3 then name = name .. "Lkhagua"
    elseif fleetNr == 4 then name = name .. "Turev"
    elseif fleetNr == 5 then name = name .. "Bassan"
    elseif fleetNr == 6 then name = name .. "Byaba"
    elseif fleetNr == 7 then name = name .. "Myan"
    elseif fleetNr == 8 then name = name .. "Gayish"
    end

    name = name .. " "

    if shipNr == 1 then name = name .. "Nek"
    elseif shipNr == 2 then name = name .. "Koher"
    elseif shipNr == 3 then name = name .. "Guraav"
    elseif shipNr == 4 then name = name .. "Durov"
    elseif shipNr == 5 then name = name .. "Dav"
    elseif shipNr == 6 then name = name .. "Urrga"
    elseif shipNr == 7 then name = name .. "Doolo"
    elseif shipNr == 8 then name = name .. "Nayhm"
    elseif shipNr == 9 then name = name .. "Esh"
    elseif shipNr == 10 then name = name .. "Arak"
    end

    return name
end

local ShipTemplate = function(templateName, fleetNr, shipNr)
    local ship = My.CpuShip(templateName, "Legion"):
    setCallSign(callSign(fleetNr, shipNr))

    My.asteroidRadar(ship)

    return ship
end

-- create a fleet that can destroy stations
local createDestroyerFleet = function(fleetNr)
    local mainTemplate, wingTemplate
    local fillTemplate = "Legion Interceptor"
    if math.random(0, 1) == 0 then
        mainTemplate = "Legion Missile"
        if math.random(0, 1) == 0 then
            wingTemplate = "Legion Bomber"
        else
            wingTemplate = "Legion Fighter"
        end
    else
        mainTemplate = "Legion Destroyer"
        wingTemplate = "Legion Fighter"
    end
    local version = math.random(1, 4)
    if version == 1 then
        return Fleet:new({
            ShipTemplate(mainTemplate, fleetNr, 1),
            ShipTemplate(mainTemplate, fleetNr, 2),
            ShipTemplate(mainTemplate, fleetNr, 3),
        })
    elseif version == 2 then
        return Fleet:new({
            ShipTemplate(mainTemplate, fleetNr, 1),
            ShipTemplate(mainTemplate, fleetNr, 2),
            ShipTemplate(fillTemplate, fleetNr, 3),
            ShipTemplate(fillTemplate, fleetNr, 4),
        })
    elseif version == 3 then
        return Fleet:new({
            ShipTemplate(mainTemplate, fleetNr, 1),
            ShipTemplate(wingTemplate, fleetNr, 2),
            ShipTemplate(wingTemplate, fleetNr, 3),
            ShipTemplate(wingTemplate, fleetNr, 4),
        })
    else
        return Fleet:new({
            ShipTemplate(mainTemplate, fleetNr, 1),
            ShipTemplate(wingTemplate, fleetNr, 2),
            ShipTemplate(wingTemplate, fleetNr, 3),
            ShipTemplate(fillTemplate, fleetNr, 4),
            ShipTemplate(fillTemplate, fleetNr, 5),
        })
    end

end

local getSpawnPosition = function(station)
    for _,bf in pairs(station.battlefields) do
        if isFunction(bf.getRandomPosition) then
            return bf:getRandomPosition()
        end
    end

    local sx, sy = station:getPosition()

    return My.World.Helper.tryMinDistance(function()
        local dx, dy = vectorFromAngle(math.random(0, 360), math.random(30000, 50000))
        return sx + dx, sy + dy
    end, function(thing)
        return isEeMine(thing) or isEeShipTemplateBased(thing) or isEeWormHole(thing) or isEeBlackHole(thing) or isEeStation()
    end, 10000)
end

-- assign the next target to the enemies
local getNextTarget
getNextTarget = function(fleet)
    local validStations = {}
    for _, station in pairs(My.World.stations) do
        if station:isValid() then table.insert(validStations, station) end
    end

    table.sort(validStations, function(a, b)
        return distance(a, fleet:getLeader()) < distance(b, fleet:getLeader())
    end)
    local target
    if validStations[1] ~= nil then
        target = validStations[1]
    elseif My.World.fortress ~= nil and My.World.fortress:isValid() then
        target = My.World.fortress
    end

    if target ~= nil then
        return Order:attack(target, {
            ignoreEnemies = false,
            onCompletion = function(_, fleet)
                fleet:addOrder(getNextTarget(fleet))
            end,
            onAbort = function(_, fleet)
                fleet:addOrder(getNextTarget(fleet))
            end,
        })
    else
        return Order:roaming()
    end

end

My.EventHandler:register("onAttackersSpawn", function()
    local player = My.World.player

    for i, station in ipairs(My.World.stations) do
        local x, y = getSpawnPosition(station)

        local fleet = createDestroyerFleet(i)

        for _, ship in pairs(fleet:getShips()) do
            ship:setShieldsFrequency(frequency + math.random(-2, 2))
            ship:setPosition(x + math.random(-1000, 1000), y + math.random(-1000, 1000))
        end

        Fleet:withOrderQueue(fleet)
        fleet:addOrder(Order:attack(station, {
            ignoreEnemies = false,
            onCompletion = function(_, fleet)
                fleet:addOrder(getNextTarget(fleet))
            end,
            onAbort = function(_, fleet)
                fleet:addOrder(getNextTarget(fleet))
            end,
        }))

        table.insert(fleets, fleet)
    end

    local attackersAreIdentfied = function()
        for _, fleet in pairs(fleets) do
            for _, ship in pairs(fleet:getShips()) do
                if ship:isFriendOrFoeIdentifiedBy(player) or distance(player, ship) < 5000 then
                    return true
                end
            end
            if fleet:getLeader() ~= nil and fleet:getLeader():isValid() then
                for _, station in pairs(My.World.stations) do

                    if station:isValid() and distance(station, fleet:getLeader()) < 5000 then
                        return true
                    end
                end
            end
        end
        return false
    end

    -- check if fleet is detected
    Cron.regular(function(cronId)
        if attackersAreIdentfied() then
            Cron.abort(cronId)
            My.EventHandler:fire("onAttackersDetection")
        end
    end, 1)
end, -99)

My.EventHandler:register("onAttackersSpawn", function()
    Cron.regular(function(self)
        for _, fleet in pairs(fleets) do
            if fleet:isValid() then return end
        end

        Cron.abort(self)
        My.EventHandler:fire("onEnemiesDestroyed")
    end, 1, 10)
end)

local imbaCron

My.EventHandler:register("onAttackersSpawn", function()
    Cron.regular(function(self)
        if My.World.allStationsDestroyed() then
            Cron.abort(self)
            My.EventHandler:fire("onAllStationsDestroyed")
        end
    end, 1)

    -- I want it to be impossible to defeat the armada at this point. So they should be fully stocked on weapons.
    imbaCron = Cron.regular(function()
        for _, fleet in pairs(fleets) do
            for _, ship in pairs(fleet:getShips()) do
                if ship:isValid() then
                    if ship:getWeaponStorage("emp") < ship:getWeaponStorageMax("emp") then
                        ship:setWeaponStorage("emp", ship:getWeaponStorage("emp") + 1)
                    elseif ship:getWeaponStorage("homing") < ship:getWeaponStorageMax("homing") then
                        ship:setWeaponStorage("homing", ship:getWeaponStorage("homing") + 1)
                    elseif ship:getWeaponStorage("hvli") < ship:getWeaponStorageMax("hvli") then
                        ship:setWeaponStorage("hvli", ship:getWeaponStorage("hvli") + 1)
                    end
                    if ship:getHull() < ship:getHullMax() then
                        ship:setHull(math.min(
                            ship:getHullMax(),
                            ship:getHull() + 5
                        ))
                    end
                end
            end
        end
    end, 10)
end)

My.EventHandler:register("onAllStationsDestroyed", function()
    Cron.regular(function(self)
        for _, fleet in pairs(fleets) do
            local leader = fleet:getLeader()
            if leader ~= nil and leader:isValid() and distance(My.World.fortress, leader) < 50000 then
                Cron.abort(self)
                My.EventHandler:fire("onClosingInToFortress")
            end
        end
    end, 5)
end)
My.EventHandler:register("onAllStationsDestroyed", function()
    Cron.abort(imbaCron)
end)

My.EventHandler:register("onClosingInToFortress", function()
    Cron.abort(imbaCron)
end)
