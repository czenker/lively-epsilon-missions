local t = My.Translator.translate

local function StationTemplate()
    return My.SpaceStation("Large Station", "SMC")
end

local arenaRadius = 5000
local arenaPoints = 40

local createArena = function(nebula)
    local arenaX, arenaY = nebula:getRandomCloud():getPosition()

    local points = {}

    for i=1,arenaPoints do
        local x, y = Util.addVector(arenaX, arenaY, 360/arenaPoints * i, arenaRadius)
        table.insert(points, x)
        table.insert(points, y)
    end

    local zone = Zone():setFaction("Player"):setPoints(table.unpack(points)):setColor(255, 0, 0):setLabel("Arena")

    My.World.Helper.eraseAsteroidsAround(arenaX, arenaY, 5500)

    return arenaX, arenaY, zone
end

My.EventHandler:register("onWorldCreation", function()
    local nebula = Util.random(My.World.nebulas)

    if nebula == nil then
        logWarning("Not creating a shipyard station, because there are no free nebulas. Consider creating more of them.")
        return
    end

    -- it should be close to a nebula
    local randomPosition = function()
        local x, y = nebula:getRandomPosition()
        x, y = Util.addVector(x, y, math.random(0, 360), math.random(5000, 10000))
        return x, y
    end
    local x, y = My.World.Helper.tryMinDistance(randomPosition, function(thing, distance)
        return ((isEeNebula(thing) or isEeMine(thing)) and distance < 6000)  or isEeStation(thing)
    end, 25000)

    My.World.Helper.eraseAsteroidsAround(x, y, 2000)
    local station = StationTemplate():setPosition(x, y)

    station:setCallSign(My.wharfStationName())
    station:setScannedDescription(t("shipyard_station_description", nebula:getName()))

    local arenaX, arenaY, arenaZone = createArena(nebula)

    station.isInArena = function(thing)
        return distance(thing, arenaX, arenaY) < arenaRadius
    end

    station.getArenaLocation = function()
        return arenaX, arenaY
    end

    station.getArenaSectorName = function()
        return Util.sectorName(arenaX, arenaY)
    end

    station.getArenaZone = function()
        return arenaZone
    end

    Station:withCrew(station, {
        relay = Person:newHumanScientist(),
    })

    My.EventHandler:register("onAttackersDetection", function()
        station:addTag("mute")
    end)

    station:addTag("shipyard")

    nebula:setUse("arena", station)
    My.World.shipyard = station
    station.inNebula = nebula
    table.insert(My.World.stations, station)
end, 50)
