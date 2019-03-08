local t = My.Translator.translate

local function ShipTemplate(freighterName)
    local rnd = math.random(1,5)
    return My.CpuShip(freighterName .. " Freighter " .. rnd, "Free Trader"):
    setWarpDrive(true):
    setJumpDrive(false)
end

-- a ship that buys excessive goods
My.FlyingBuyer = function(station, carriedProducts, freighterName)
    if not isEeStation(station) then error("Station needs to be a valid station, but " .. type(station) .. " given.", 2) end
    if not Station:hasStorage(station) then error("Station has to have a storage.", 2) end

    if not isTable(carriedProducts) then error("carriedProducts needs to be a table, but " .. type(carriedProducts) .. " given.", 2) end

    for idx, product in pairs(carriedProducts) do
        if not Product:isProduct(product) then error("All products need to be Products, but " .. type(product) .. " given at index " .. idx .. ".", 3) end
        if not station:canStoreProduct(product) then error("Station " .. station:getCallSign() .. " can not store product " .. product:getName() .. ".", 3)end
    end
    freighterName = freighterName or "Equipment"
    if not isString(freighterName) then error("FreighterName needs to be a valid string, but " .. type(freighterName) .. " given.", 2) end


    local ship
    local cronId = station:getCallSign() .. "_dealer_" .. Util.randomUuid()

    local function createDealer()
        ship = ShipTemplate(freighterName)
        ship:setCallSign(My.civilianShipName())
        ship:addTag("merchant")
        local storage = {}
        for _,product in pairs(carriedProducts) do
            storage[product] = station:getMaxProductStorage(product)
        end

        local description = t("flying_trader_description", ship:getCallSign())
        ship:setDescriptionForScanState("notscanned", t("generic_unknown_ship"))
        ship:setDescriptionForScanState("friendorfoeidentified", description)
        ship:setDescriptionForScanState("simple", description)
        ship:setDescriptionForScanState("full", description)

        ship.whoAreYouResponse = t("flying_trader_buyer_who_are_you", ship:getCaptain(), station:getCallSign() or "", Util.map(carriedProducts, function(product) return product:getName() end))

        Ship:withStorageRooms(ship, storage)

        local wormholeX, wormholeY = My.Wormhole:getPosition()
        local stationX, stationY = station:getPosition()
        local angleDeviation = math.random(-45, 45)
        local waypointStationX, waypointStationY = Util.vectorFromAngle(Util.angleFromVector(wormholeX - stationX, wormholeY - stationY) + angleDeviation, 20000)
        local waypointWormholeX, waypointWormholeY = Util.vectorFromAngle(Util.angleFromVector(stationX - wormholeX, stationY- wormholeY) - angleDeviation, 20000)
        ship:setPosition(wormholeX + waypointWormholeX, wormholeY + waypointWormholeY)

        ship:addOrder(Order:flyTo(stationX + waypointStationX, stationY + waypointStationY, {
            minDistance = 2000,
        }))
        ship:addOrder(Order:dock(station, {
            delayAfter = 15
        }))
        ship:addOrder(Order:flyTo(stationX + waypointStationX, stationY + waypointStationY, {
            minDistance = 2000,
        }))
        ship:addOrder(Order:flyTo(wormholeX + waypointWormholeX, wormholeY + waypointWormholeY, {
            minDistance = 2000,
        }))
        ship:addOrder(Order:flyTo(wormholeX, wormholeY, {
            onExecution = function()
                for _,product in pairs(carriedProducts) do
                    if station:getProductStorage(product) > station:getEmptyProductStorage(product) then
                        local amount = station:getProductStorage(product) - math.floor(station:getMaxProductStorage(product)/2)
                        logDebug(string.format("Flying Trader %s buys %d %s from %s.", ship:getCallSign(), amount, product:getName(), station:getCallSign()))

                        ship:modifyProductStorage(product, amount)
                        station:modifyProductStorage(product, -1 * amount)
                    end
                end
            end,
            onCompletion = function() ship:destroy() end,
        }))
    end

    local function isDealerRequired()
        for _,product in pairs(carriedProducts) do
            if station:getProductStorage(product) > station:getEmptyProductStorage(product) then
                logDebug("Buyer is needed for " .. station:getCallSign() .. " to buy " .. product:getName())
                return true
            end
        end
        return false
    end

    Cron.regular(cronId, function()
        if not station:isValid() then
            logInfo("Aborting " .. cronId .. " because station no loger exists.")
            Cron.abort(cronId)
        elseif (ship == nil or not ship:isValid()) and isDealerRequired() then
            createDealer()
        end
    end, 10)

    My.EventHandler:register("onAttackersDetection", function()
        Cron.abort(cronId)
        local wormholeX, wormholeY = My.Wormhole:getPosition()
        if isEeShip(ship) and ship:isValid() then
            ship:setHailText(t("comms_generic_flight_hail"))
            ship.whoAreYouResponse = t("comms_generic_flight_who_are_you")
            ship:forceOrderNow(Order:flyTo(wormholeX, wormholeY, {
                onCompletion = function() ship:destroy() end,
            }))
        end
    end)
end

-- a ship that sells needed goods
My.FlyingSeller = function(station, carriedProducts, freighterName)
    if not isEeStation(station) then error("Station needs to be a valid station, but " .. type(station) .. " given.", 2) end
    if not Station:hasStorage(station) then error("Station has to have a storage.", 2) end

    if not isTable(carriedProducts) then error("carriedProducts needs to be a table, but " .. type(carriedProducts) .. " given.", 2) end

    for idx, product in pairs(carriedProducts) do
        if not Product:isProduct(product) then error("All products need to be Products, but " .. type(product) .. " given at index " .. idx .. ".", 3) end
        if not station:canStoreProduct(product) then error("Station " .. station:getCallSign() .. " can not store product " .. product:getName() .. ".", 3)end
    end
    freighterName = freighterName or "Equipment"
    if not isString(freighterName) then error("FreighterName needs to be a valid string, but " .. type(freighterName) .. " given.", 2) end


    local ship
    local cronId = station:getCallSign() .. "_dealer_" .. Util.randomUuid()

    local function createDealer()
        ship = ShipTemplate(freighterName)
        ship:setCallSign(My.civilianShipName())
        ship:addTag("merchant")
        local storage = {}
        for _,product in pairs(carriedProducts) do
            storage[product] = station:getMaxProductStorage(product)
        end

        local description = t("flying_trader_description", ship:getCallSign())
        ship:setDescriptionForScanState("notscanned", t("generic_unknown_ship"))
        ship:setDescriptionForScanState("friendorfoeidentified", description)
        ship:setDescriptionForScanState("simple", description)
        ship:setDescriptionForScanState("full", description)

        ship.whoAreYouResponse = t("flying_trader_seller_who_are_you", ship:getCaptain(), station:getCallSign() or "", Util.map(carriedProducts, function(product) return product:getName() end))

        Ship:withStorageRooms(ship, storage)

        local wormholeX, wormholeY = My.Wormhole:getPosition()
        local stationX, stationY = station:getPosition()
        local angleDeviation = math.random(-45, 45)
        local waypointStationX, waypointStationY = Util.vectorFromAngle(Util.angleFromVector(wormholeX - stationX, wormholeY - stationY) + angleDeviation, 20000)
        local waypointWormholeX, waypointWormholeY = Util.vectorFromAngle(Util.angleFromVector(stationX - wormholeX, stationY- wormholeY) - angleDeviation, 20000)
        ship:setPosition(wormholeX + waypointWormholeX, wormholeY + waypointWormholeY)

        for _,product in pairs(carriedProducts) do
            if station:getProductStorage(product) < station:getMaxProductStorage(product) * 0.1 then
                local amount = Util.round(station:getMaxProductStorage(product) * 0.3, 10)
                logDebug(string.format("Flying Trader %s brings %d %s to %s.", ship:getCallSign(), amount, product:getName(), station:getCallSign()))
                ship:modifyProductStorage(product, amount)
            end
        end

        ship:addOrder(Order:flyTo(stationX + waypointStationX, stationY + waypointStationY, {
            minDistance = 2000,
        }))
        ship:addOrder(Order:dock(station, {
            delayAfter = 15
        }))
        ship:addOrder(Order:flyTo(stationX + waypointStationX, stationY + waypointStationY, {
            minDistance = 2000,
        }))
        ship:addOrder(Order:flyTo(wormholeX + waypointWormholeX, wormholeY + waypointWormholeY, {
            minDistance = 2000,
        }))
        ship:addOrder(Order:flyTo(wormholeX, wormholeY, {
            onExecution = function()
                for _,product in pairs(carriedProducts) do
                    if ship:getProductStorage(product) > 0 then
                        local amount = ship:getProductStorage(product)
                        logDebug(string.format("Flying Trader %s unloads %d %s at %s.", ship:getCallSign(), amount, product:getName(), station:getCallSign()))
                        ship:modifyProductStorage(product, -1 * amount)
                        station:modifyProductStorage(product, amount)
                    end
                end
            end,
            onCompletion = function() ship:destroy() end,
        }))
    end

    local function isDealerRequired()
        for _,product in pairs(carriedProducts) do
            if station:getProductStorage(product) < station:getMaxProductStorage(product) * 0.1 then
                logDebug("Seller is needed for " .. station:getCallSign() .. " to sell " .. product:getName())
                return true
            end
        end
        return false
    end

    Cron.regular(cronId, function()
        if not station:isValid() then
            logInfo("Aborting " .. cronId .. " because station no loger exists.")
            Cron.abort(cronId)
        elseif (ship == nil or not ship:isValid()) and isDealerRequired() then
            createDealer()
        end
    end, 10)

    My.EventHandler:register("onAttackersDetection", function()
        Cron.abort(cronId)

        local wormholeX, wormholeY = My.Wormhole:getPosition()
        if isEeShip(ship) and ship:isValid() then
            ship:setHailText(t("comms_generic_flight_hail"))
            ship.whoAreYouResponse = t("comms_generic_flight_who_are_you")
            ship:forceOrderNow(Order:flyTo(wormholeX, wormholeY, {
                onCompletion = function() ship:destroy() end,
            }))
        end
    end)
end