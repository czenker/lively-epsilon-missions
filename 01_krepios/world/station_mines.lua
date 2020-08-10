local t = My.Translator.translate

local function StationTemplate()
    return My.SpaceStation("Medium Station", "SMC")
end

local MinerTemplate = function()
    local ship = My.CpuShip("MT52 Hornet")
    ship:addTag("miner")
    ship:addTag("local")

    return ship
end

local function mineAsteroid(asteroid, ship, station)
    local resources = {
        [products.ore] = math.random(0, 10)
    }
    if math.random(1, 5) == 1 then
        resources[products.plutoniumOre] = math.random(1, 2)
    end

    return resources
end

local numberOfMiners = 4

local function makeItAMine(station)
    station:setCallSign(My.miningStationName())
    station:setScannedDescription(t("mines_miner_station_description"))

    if isFunction(station.setRestocksScanProbes) then station:setRestocksScanProbes(false) end

    Station:withStorageRooms(station, {
        [products.ore] = 400,
        [products.plutoniumOre] = 40,
        [products.miningMachinery] = 100,
        [products.hvli] = 8,
        [products.homing] = 8,
        [products.mine] = 4,
        [products.scanProbe] = 10,
    })

    Station:withMerchant(station, {
        [products.ore] = {
            sellingPrice = My.sellingPrice(products.ore),
            sellingLimit = station:getMaxProductStorage(products.ore) * 0.2,
            buyingPrice = My.rebuyingPrice(products.ore),
            buyingLimit = station:getMaxProductStorage(products.ore) * 0.8,
        },
        [products.plutoniumOre] = {
            sellingPrice = My.sellingPrice(products.plutoniumOre),
            buyingPrice = My.rebuyingPrice(products.plutoniumOre),
            buyingLimit = station:getMaxProductStorage(products.plutoniumOre) * 0.8,
        },
        [products.miningMachinery] = { buyingPrice = My.buyingPrice(products.miningMachinery) },
        [products.hvli] = { sellingPrice = My.sellingPrice(products.hvli)},
        [products.homing] = { sellingPrice = My.sellingPrice(products.homing) },
        [products.mine] = { sellingPrice = My.sellingPrice(products.mine) },
        [products.scanProbe] = { sellingPrice = My.sellingPrice(products.scanProbe) },
    })
    Station:withCrew(station, {
        relay = Person:newHuman()
    })
    station:modifyProductStorage(products.ore, math.random(100, 200))
    station:modifyProductStorage(products.plutoniumOre, math.random(10, 20))
    station:modifyProductStorage(products.miningMachinery, math.random(20, 40))
    station:modifyProductStorage(products.hvli, math.random(0, 4))
    station:modifyProductStorage(products.homing, math.random(0, 4))
    station:modifyProductStorage(products.mine, math.random(0, 2))
    station:modifyProductStorage(products.scanProbe, math.random(2, 4))

    Station:withProduction(station, {
        {
            productionTime = math.random(162, 192),
            consumes = {
                { product = products.ore, amount = 6 }
            },
            produces = {
                { product = products.homing, amount = 2 }
            }
        },{
            productionTime = math.random(108, 132),
            consumes = {
                { product = products.ore, amount = 6 }
            },
            produces = {
                { product = products.hvli, amount = 2 }
            }
        },{
            productionTime = math.random(162, 192),
            consumes = {
                { product = products.ore, amount = 6 }
            },
            produces = {
                { product = products.mine, amount = 1 }
            }
        },{
            productionTime = math.random(108, 132),
            consumes = {
                { product = products.ore, amount = 2 }
            },
            produces = {
                { product = products.scanProbe, amount = 1 }
            }
        },{
            productionTime = math.random(81, 99),
            consumes = {
                { product = products.miningMachinery, amount = 1 }
            },
        },
    })

    station:addTag("mining")

    local function spawnMiner()
        local miner = MinerTemplate():setFaction(station:getFaction()):setCallSign(My.minerName())
        miner:setAI("default")
        miner:setScannedDescription(t("mines_miner_description", miner:getCallSign(), miner:getCaptain()))

        miner.whoAreYouResponse = function()
            return t("mines_miner_who_are_you", miner:getCaptain(), station:getCallSign() or "", {products.ore:getName(), products.plutoniumOre:getName()})
        end

        Util.spawnAtStation(station, miner)

        Ship:withStorageRooms(miner, {
            [products.ore] = 60,
            [products.plutoniumOre] = 5,
        })
        Ship:behaveAsMiner(miner, station, mineAsteroid, {
            timeToUnload = math.random(30, 60),
            timeToMine = math.random(15, 30),
            timeToGoHome = math.random(450, 900),
            maxDistanceFromHome = math.random(20000, 30000),
            maxDistanceToNext = math.random(5000, 15000),
        })

        Ship:withEvents(miner, {
            onUndocking = function(ship, theStation)
                if theStation == station then
                    My.Chatter:converse({
                        { ship, t("mines_miner_undocking_chat_1") },
                        { station, t("mines_miner_undocking_chat_2", ship:getCallSign(), Person:newHuman()) },
                    })

                end
            end,
            onDockInitiation = function(ship, theStation)
                if theStation == station then
                    My.Chatter:converse({
                        { ship, t("mines_miner_dock_initiation_chat_request", station:getCallSign(), ship:getCaptain(), station:getCrewAtPosition("relay")) },
                        { station, t("mines_miner_dock_initiation_chat_response", station:getCallSign(), ship:getCaptain(), Person:newHuman()) },
                    })
                end
            end,
        })

        return miner
    end

    local miners = {}

    local cronId = "mine_" .. station:getCallSign()

    My.LocalBuyer(station, products.miningMachinery, false)
    My.FlyingBuyer(station, {products.ore, products.plutoniumOre}, "Goods")
    My.FlyingSeller(station, {products.miningMachinery}, "Equipment")
    My.FlyingBuyer(station, {products.hvli, products.homing, products.mine}, "Equipment")

    Cron.regular(cronId, function()
        if not station:isValid() then
            Cron.abort(cronId)
        else
            for i=1,numberOfMiners do
                if not isEeShip(miners[i]) or not miners[i]:isValid() then
                    miners[i] = spawnMiner()
                end
            end
        end
    end, math.random(55, 64) + math.random(), 0)

    My.EventHandler:register("onAttackersDetection", function()
        station:addTag("mute")
        -- @TODO: stop production
        Cron.abort(cronId)

        for _,miner in pairs(miners) do
            if miner:isValid() then
                My.fleeToFortress(miner)
            end
        end
    end)

    return station
end

My.EventHandler:register("onWorldCreation", function()
    local divAngle = 360 * 40000 / 2 / math.pi / My.Config.avgDistance

    local minAngle = My.Config.avgAngle - divAngle
    local originX, originY = My.World.planet:getPosition()

    local randomPosition = function()
        local angle = math.random() * 2 * divAngle + minAngle
        local distance = My.Config.avgDistance - My.Config.width / 2 + math.random() * My.Config.width

        local x, y = vectorFromAngle(angle, distance)
        return originX + x, originY + y
    end

    for i=1,3 do
        local x, y = My.World.Helper.tryMinDistance(randomPosition, isEeStation, 20000)
        My.World.Helper.eraseAsteroidsAround(x, y, 2000)
        local station = StationTemplate():setPosition(x, y)
        makeItAMine(station)
        table.insert(My.World.stations, station)
        My.Database:addOrUpdateStation(station)
        if My.World.miningStation1 == nil then
            My.World.miningStation1 = station
        elseif My.World.miningStation2 == nil then
            My.World.miningStation2 = station
        elseif My.World.miningStation3 == nil then
            My.World.miningStation3 = station
        end
    end

end, 10)
