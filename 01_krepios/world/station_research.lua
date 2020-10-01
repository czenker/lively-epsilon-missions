local t = My.Translator.translate

local function StationTemplate()
    return My.SpaceStation("Medium Station", "SMC")
end

My.EventHandler:register("onWorldCreation", function()
    local nebula = Util.random(My.World.nebulas, function(_, nebula)
        return not nebula.hasUse()
    end)

    if nebula == nil then
        logWarning("Not creating a science station, because there are no free nebulas. Consider creating more of them.")
        return
    end

    local x,y = nebula:getRandomPosition()
    My.World.Helper.eraseAsteroidsAround(x, y, 2000)
    local station = StationTemplate():setPosition(x, y)
    station:setCallSign(My.scienceStationName())
    station:setScannedDescription(t("research_station_description", nebula:getName()))

    if isFunction(station.setRestocksScanProbes) then station:setRestocksScanProbes(false) end

    Station:withCrew(station, {
        relay = Person:newHumanScientist(),
        crystallographer = Person.newHumanScientist(),
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

    station:addTag("science")

    nebula:setUse("science", station)
    station.inNebula = nebula
    table.insert(My.World.stations, station)
    My.Database:addOrUpdateStation(station)
end, 50)
