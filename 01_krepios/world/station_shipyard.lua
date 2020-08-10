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

    Station:withStorageRooms(station, {
        [products.ore] = 100,
        [products.scanProbe] = 4,
        [products.nanobot] = 4,
    })
    Station:withMerchant(station, {
        [products.ore] = { buyingPrice = My.buyingPrice(products.ore) },
        [products.scanProbe] = { sellingPrice = My.sellingPrice(products.scanProbe) },
        [products.nanobot] = { sellingPrice = My.sellingPrice(products.nanobot) },
    })
    station:modifyProductStorage(products.ore, math.random(10, 20))
    station:modifyProductStorage(products.scanProbe, math.random(0, 1))
    station:modifyProductStorage(products.nanobot, math.random(0, 1))

    Station:withProduction(station, {
        {
            productionTime = math.random(216, 264),
            consumes = {
                { product = products.ore, amount = 2 }
            },
            produces = {
                { product = products.scanProbe, amount = 1 }
            }
        },{
            productionTime = math.random(420, 540),
            consumes = {
                { product = products.ore, amount = 8 }
            },
            produces = {
                { product = products.nanobot, amount = 1 }
            }
        },
    })

    My.LocalBuyer(station, products.ore, true)
    My.FlyingSeller(station, {products.ore}, "Goods")

    My.EventHandler:register("onAttackersDetection", function()
        station:addTag("mute")
    end)

    station:addTag("shipyard")

    nebula:setUse("arena", station)
    My.World.shipyard = station
    station.inNebula = nebula
    table.insert(My.World.stations, station)
    My.Database:addOrUpdateStation(station)
end, 50)

My.EventHandler:register("onAttackersDetection", function()
    My.World.shipyard:addTag("mute")
end)