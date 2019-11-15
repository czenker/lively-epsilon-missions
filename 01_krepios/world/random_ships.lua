local t = My.Translator.translate

local cronId = "random-ships"

local getFrom = function(filterFunc)
    local potentialStations = {}
    for _, station in pairs(My.World.stations) do
        if station:isValid() and not isFunction(filterFunc) or userCallback(filterFunc, station) == true then
            table.insert(potentialStations, station)
        end
    end
    return Util.random(potentialStations)
end

local getTo = function(from, filterFunc)
    local potentialStations = {}
    for _, station in pairs(My.World.stations) do
        if station:isValid() and station ~= from and not isFunction(filterFunc) or userCallback(filterFunc, station) == true then
            table.insert(potentialStations, station)
        end
    end
    return Util.random(potentialStations)
end

local civilianShips = {
    "MU52 Hornet",
    "MT52 Hornet",
    "Adder MK4",
    "Adder MK5",
    "Adder MK6",
}

local MinerTemplate = function()
    local ship = My.CpuShip("MT52 Hornet")
    ship:addTag("miner")
    ship:addTag("local")

    return ship
end


local narratives = {
    --generic = function()
    --    local from = getFrom()
    --    local to = getTo(from)
    --
    --    if not from or not to then return end
    --
    --    local ship = My.CpuShip(Util.random(civilianShips), "Independent")
    --
    --    ship:addTag("local")
    --    Ship:withOrderQueue(ship)
    --
    --    Util.spawnAtStation(from, ship)
    --
    --    ship:addOrder(Order:dock(to, {
    --        onCompletion = function()
    --            Cron.once(function() ship:destroy() end, 10)
    --        end,
    --    }))
    --
    --    return ship
    --end,

    mine_workers = function()
        local from = getFrom(function(thing) return Generic:hasTags(thing) and thing:hasTag("residual") end)
        local to = getTo(from, function(thing) return Generic:hasTags(thing) and thing:hasTag("mining") end)

        if not from or not to then return end

        local ship = My.CpuShip("Personnel Freighter " .. math.random(1,5), "SMC"):setCallSign(My.civilianShipName())

        local description = t("random_ships_generic_personal_description", ship:getFaction())
        ship:setDescriptionForScanState("notscanned", t("generic_unknown_ship"))
        ship:setDescriptionForScanState("friendorfoeidentified", description)
        ship:setDescriptionForScanState("simple", description)
        ship:setDescriptionForScanState("full", description)

        ship.whoAreYouResponse = t("random_ships_mine_workers_who_are_you", ship:getCaptain(), to:getCallSign() or "")

        ship:addTag("local")
        Ship:withOrderQueue(ship)

        Util.spawnAtStation(from, ship)

        ship:addOrder(Order:dock(to, {
            delayAfter = math.random(60, 90),
        }))

        ship:addOrder(Order:dock(from, {
            onExecution = function()
                ship.whoAreYouResponse = t("random_ships_mine_workers2_who_are_you", ship:getCaptain(), from:getCallSign() or "")
            end,
            onCompletion = function()
                Cron.once(function() ship:destroy() end, 10)
            end,
        }))

        return ship
    end,

    fun_time = function()
        local from = getFrom(function(thing) return Generic:hasTags(thing) and thing:hasTag("mining") end)
        local to = getTo(from, function(thing) return Generic:hasTags(thing) and thing:hasTag("residual") end)

        if not from or not to then return end

        local ship = My.CpuShip(Util.random(civilianShips), "Civilian"):setCallSign(My.civilianShipName())

        local description = t("random_ships_generic_civilian_description", ship:getFaction())
        ship:setDescriptionForScanState("notscanned", t("generic_unknown_ship"))
        ship:setDescriptionForScanState("friendorfoeidentified", description)
        ship:setDescriptionForScanState("simple", description)
        ship:setDescriptionForScanState("full", description)

        ship.whoAreYouResponse = t("random_ships_fun_time_who_are_you", ship:getCaptain(), to:getCallSign() or "")

        ship:addTag("local")
        Ship:withOrderQueue(ship)

        Util.spawnAtStation(from, ship)

        ship:addOrder(Order:dock(to, {
            delayAfter = math.random(60, 90),
        }))

        ship:addOrder(Order:dock(from, {
            onExecution = function()
                ship.whoAreYouResponse = t("random_ships_fun_time2_who_are_you", ship:getCaptain(), from:getCallSign() or "")
            end,
            onCompletion = function()
                Cron.once(function() ship:destroy() end, 10)
            end,
        }))

        return ship
    end,

    leaving = function()
        local station = getFrom(function(thing) return Generic:hasTags(thing) and (thing:hasTag("residual") or thing:hasTag("mining")) end)

        if not station or not My.Wormhole:isValid() then return end

        local ship = My.CpuShip(Util.random(civilianShips), "Civilian"):setCallSign(My.civilianShipName()):setWarpDrive(true)

        local description = t("random_ships_generic_civilian_description", ship:getFaction())
        ship:setDescriptionForScanState("notscanned", t("generic_unknown_ship"))
        ship:setDescriptionForScanState("friendorfoeidentified", description)
        ship:setDescriptionForScanState("simple", description)
        ship:setDescriptionForScanState("full", description)

        ship.whoAreYouResponse = t("random_ships_leaving_who_are_you", ship:getCaptain())

        Ship:withOrderQueue(ship)

        Util.spawnAtStation(station, ship)

        ship:addOrder(Order:use(My.Wormhole, {
            onCompletion = function()
                table.insert(My.World.personsWhoLeftTheSector, ship:getCaptain())
                ship:destroy()
            end
        }))

        return ship
    end,
    nebula_tourism = function()
        local station = getFrom(function(thing) return Generic:hasTags(thing) and thing:hasTag("residual") end)
        local nebula = Util.random(My.World.nebulas, function(_, neb) return not neb:hasUse() end)

        if not station or not nebula then return end

        local ship = My.CpuShip(Util.random(civilianShips), "Civilian"):setCallSign(My.civilianShipName())

        local description = t("random_ships_generic_civilian_description", ship:getFaction())
        ship:setDescriptionForScanState("notscanned", t("generic_unknown_ship"))
        ship:setDescriptionForScanState("friendorfoeidentified", description)
        ship:setDescriptionForScanState("simple", description)
        ship:setDescriptionForScanState("full", description)

        ship.whoAreYouResponse = t("random_ships_nebula_tourism_who_are_you", ship:getCaptain(), nebula:getName())

        Ship:withOrderQueue(ship)

        Util.spawnAtStation(station, ship)

        local x, y = nebula:getRandomPosition()
        ship:addOrder(Order:flyTo(x, y, {
            onExecution = function()
                ship:setWarpDrive(true)
            end,
            onCompletion = function()
                ship:setWarpDrive(false)
            end
        }))
        x, y = nebula:getRandomPosition()
        ship:addOrder(Order:flyTo(x, y, {}))
        x, y = nebula:getRandomPosition()
        ship:addOrder(Order:flyTo(x, y, {}))
        x, y = nebula:getRandomPosition()
        ship:addOrder(Order:flyTo(x, y, {}))
        ship:addOrder(Order:dock(station, {
            onExecution = function()
                ship.whoAreYouResponse = t("random_ships_nebula_tourism2_who_are_you", ship:getCaptain(), nebula:getName(), station:getCallSign() or "")
                ship:setWarpDrive(true)
            end,
            onCompletion = function()
                Cron.once(function() ship:destroy() end, 10)
            end,
        }))

        return ship
    end,
    prospector = function()
        local station = getFrom(function(thing) return Generic:hasTags(thing) and thing:hasTag("mining") end)

        if not station then return end

        local asteroids = {}
        local findAsteroid = function(lastObject, radius)
            local x, y = lastObject:getPosition()
            return Util.random(getObjectsInRadius(x, y, radius), function(_, obj)
                if not isEeAsteroid(obj) then return false end
                for _, other in pairs(asteroids) do
                    if other == obj then return false end
                end
                return true
            end)
        end

        table.insert(asteroids, findAsteroid(station, getLongRangeRadarRange()))

        if Util.size(asteroids) < 1 then return end

        for _=1, math.random(2, 5) do
            local asteroid = findAsteroid(asteroids[#asteroids], 7000)
            if asteroid == nil then break end
            table.insert(asteroids, asteroid)
        end

        if Util.size(asteroids) < 2 then return end

        local ship = MinerTemplate():setFaction(station:getFaction()):setCallSign(My.minerName())
        ship:setAI("default")
        ship:setScannedDescription(t("mines_miner_description", ship:getCallSign(), ship:getCaptain()))

        ship.whoAreYouResponse = t("random_ships_prospector_who_are_you", ship:getCaptain(), station:getCallSign())

        Ship:withOrderQueue(ship)

        Util.spawnAtStation(station, ship)
        for _, asteroid in pairs(asteroids) do
            local x, y = asteroid:getPosition()
            x, y = Util.addVector(x, y, math.random(0, 359), 500)
            ship:addOrder(Order:flyTo(x, y, {
                minDistance = 1500,
                delayAfter = 15,
            }))
        end
        ship:addOrder(Order:dock(station, {
            onCompletion = function()
                Cron.once(function() ship:destroy() end, 10)
            end,
        }))

        return ship
    end,
}

My.EventHandler:register("onStart", function()
    Cron.regular(cronId, function()
        for _, key in pairs(Util.randomSort(Util.keys(narratives))) do
            local narrative = narratives[key]
            local ship = narrative()

            if isEeShip(ship) then
                -- success
                logDebug("Spawned a ship for narrative " .. key)
                return
            end
        end
        logWarning("Could not find a suitable narrative to spawn a random ship. There where " .. #narratives .. " to choose from.")
    end, 90)
end)

My.EventHandler:register("onAttackersDetection", function()
    Cron.abort(cronId)
end)

