local t = My.Translator.translate

local function StationTemplate()
    return My.SpaceStation("Medium Station", "SMC")
end

My.EventHandler:register("onWorldCreation", function()
    local nebula = Util.random(My.World.nebulas)

    if nebula == nil then
        logWarning("Not creating a science station, because there are no free nebulas. Consider creating more of them.")
        return
    end

    local x,y = nebula:getRandomPosition()
    My.World.Helper.eraseAsteroidsAround(x, y, 2000)
    local station = StationTemplate():setPosition(x, y)
    station:setCallSign(My.scienceStationName())
    station:setScannedDescription(t("research_station_description", station:getCallSign(), nebula:getName()))
    Station:withCrew(station, {
        relay = Person:newHumanScientist(),
        crystallographer = Person.newHumanScientist(),
    })
    Station:withStorageRooms(station, {
        [products.ore] = 100,
    })
    Station:withMerchant(station, {
        [products.ore] = { buyingPrice = My.buyingPrice(products.ore) },
    })
    station:modifyProductStorage(products.ore, math.random(10, 20))

    Station:withProduction(station, {
        {
            productionTime = math.random(81, 99),
            consumes = {
                { product = products.ore, amount = 1 }
            },
            produces = {}
        },
    })

    station:addTag("science")

    nebula:setUse("science", station)
    station.inNebula = nebula
    table.insert(My.World.stations, station)
end, 50)
