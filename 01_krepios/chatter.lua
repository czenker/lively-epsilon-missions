local My = My or {}
local t = My.Translator.translate

local isMinerShip = function(thing)
    return isEeShip(thing) and Generic:hasTags(thing) and thing:hasTag("miner")
end
local isLocal = function(thing)
    return Generic:hasTags(thing) and thing:hasTag("local")
end
local isMute = function(thing)
    return Generic:hasTags(thing) and thing:hasTag("mute")
end
local isMerchant = function(thing)
    return isEeShip(thing) and Generic:hasTags(thing) and thing:hasTag("merchant")
end
local isPlayersEnemy = function(thing)
    return My.World.player:isEnemy(thing)
end

local relevantProducts = {
    products.ore,
    products.plutoniumOre,
    products.miningMachinery,
}

My.ChatterNoise = Chatter:newNoise(My.Chatter)

-- a ship talking about leaving this awful place
My.ChatterNoise:addChatFactory(Chatter:newFactory(1, function(one)
    return {
        {one, t("chatter_leave")}
    }
end, {
    filters = {
        function(one) return isEeShip(one) and not isMute(one) and isLocal(one) end
    }
}), "leave")

-- a ship having deep thoughts
My.ChatterNoise:addChatFactory(Chatter:newFactory(1, function(one)
    return {
        {one, t("chatter_existentialism")}
    }
end, {
    filters = {
        function(one) return not isMute(one) end
    }
}), "existentialism_one")

-- where I go and how long it takes
My.ChatterNoise:addChatFactory(Chatter:newFactory(1, function(one)
    local target = one:getOrderTarget()
    local d = Util.round(distance(one, target) / 1000, 5)
    return {
        {one, t("chatter_distance_to_dock", target:getCallSign(), d)}
    }
end, {
    filters = {
        function(one) return not isPlayersEnemy(one) and isEeShip(one) and one:getOrder() == "Dock" and distance(one, one:getOrderTarget()) > 5000 end
    }
}), "distance_to_dock")

-- a chat about expensive products
My.ChatterNoise:addChatFactory(Chatter:newFactory(2, function(one, two)
    local possibleProducts = {}
    for _, product in pairs(relevantProducts) do
        if one:canStoreProduct(product) then table.insert(possibleProducts, product) end
    end
    local product = Util.random(possibleProducts)
    local amount = math.random(2, 10) * 10
    local price = product.basePrice * amount * (math.random() * 0.5 + 2)

    return {
        {one, t("chatter_expensive_products_1", product:getName(), amount, price)},
        {two, t("chatter_expensive_products_2")},
        {one, t("chatter_expensive_products_3")},
    }
end, {
    filters = { function(one)
        if not isEeShip(one) or not ShipTemplateBased:hasStorage(one) then
            return false
        end
        for _, product in pairs(relevantProducts) do
            if one:canStoreProduct(product) then return true end
        end
        return false
    end, function(two)
        return ShipTemplateBased:hasStorage(two)
    end }
}), "expensive_products")

-- miner retire
My.ChatterNoise:addChatFactory(Chatter:newFactory(2, function(one, two)
    return {
        {one, t("chatter_miner_retire_1")},
        {two, t("chatter_miner_retire_2", My.Config.metalBandName)},
        {two, t("chatter_miner_retire_3")},
    }
end, {
    filters = {
        function(one) return isMinerShip(one) end,
        function(two, one) return isMinerShip(two) and not one:isEnemy(two) end,
    }
}), "miner_retire")

-- miner ship envy
My.ChatterNoise:addChatFactory(Chatter:newFactory(2, function(one, two)
    return {
        {one, t("chatter_miner_ship_envy_1", two:getCallSign())},
        {two, t("chatter_miner_ship_envy_2")},
    }
end, {
    filters = {
        function(one) return isMinerShip(one) end,
        function(two, one) return isMerchant(two) and not one:isEnemy(two) end,
    }
}), "miner_ship_envy")

-- chatter_existentialism
My.ChatterNoise:addChatFactory(Chatter:newFactory(2, function(one, two)
    return {
        {one, t("chatter_existentialism_1")},
        {two, t("chatter_existentialism_2")},
    }
end, {
    filters = {
        function(one) return not isMute(one) end,
        function(two, one) return not isMute(two) and not one:isEnemy(two) end,
    }
}), "existentialism_two")

-- chatter_abandoned_station
My.ChatterNoise:addChatFactory(Chatter:newFactory(2, function(one, two)
    local station = Util.random(My.World.abandonedStations)
    return {
        {one, t("chatter_abandoned_station_1", station:getCallSign())},
        {two, t("chatter_abandoned_station_2")},
    }
end, {
    filters = {
        function(one) return isEeShip(one) and isLocal(one) and not isMute(one) and Util.size(My.World.abandonedStations) > 0 end,
        function(two, one) return isEeShip(two) and isLocal(two) and not isMute(two) and not one:isEnemy(two) end,
    },
}), "nebula")

-- chatter_nebula
My.ChatterNoise:addChatFactory(Chatter:newFactory(2, function(one, two)
    local nebula = Util.random(My.World.nebulas)
    return {
        {one, t("chatter_nebula_1", nebula:getName())},
        {two, t("chatter_nebula_2")},
    }
end, {
    filters = {
        function(one) return isEeShip(one) and isLocal(one) and not isMute(one) and Util.size(My.World.nebulas) > 0 end,
        function(two, one) return isEeShip(two) and isLocal(two) and not isMute(two) and not one:isEnemy(two) end,
    },
}), "nebula")

local getRandomUpgrade = function()
    for _, station in pairs(Util.randomSort(My.World.stations)) do
        if ShipTemplateBased:hasUpgradeBroker(station) then
            for _,upgrade in pairs(Util.randomSort(station:getUpgrades())) do
                if upgrade:canBeInstalled(My.World.player) then return upgrade, station end
            end
        end
    end

    return nil, nil
end

-- chatter_upgrade
My.ChatterNoise:addChatFactory(Chatter:newFactory(2, function(one, two)
    local upgrade, station = getRandomUpgrade()

    return {
        {one, t("chatter_upgrade_1", upgrade:getName())},
        {two, t("chatter_upgrade_2", station:getCallSign())},
    }
end, {
    filters = {
        function(one)
            return isEeShip(one) and not isMute(one) and isEePlayer(My.World.player) and My.World.player:isValid() and getRandomUpgrade() ~= nil
        end,
        function(two, one)
            return isEeShip(two) and isLocal(two) and not isMute(two) and not one:isEnemy(two)
        end,
    }
}), "upgrade")

-- chatter_waste
My.ChatterNoise:addChatFactory(Chatter:newFactory(1, function(one)
    return {
        {one, t("chatter_waste")}
    }
end, {
    filters = { function(one) return isEeShip(one) and not isMute(one) end}
}), "waste")

-- chatter_betting
My.ChatterNoise:addChatFactory(Chatter:newFactory(2, function(one, two)
    local person = Person.newHuman()
    local amount = Util.round(25 + math.random() * 50, 5)

    return {
        {two, t("chatter_betting_1", person, amount)},
        {one, t("chatter_betting_2")},
    }
end, {
    filters = {
        function(one)
            return isMinerShip(one) and isLocal(one) and not isMute(one)
        end,
        function(two, one)
            return not isMute(two) and isLocal(two) and not one:isEnemy(two)
        end,
    }
}), "betting")

-- chatter_hope_for_peaceful_flight
My.ChatterNoise:addChatFactory(Chatter:newFactory(1, function(one)
    local product
    for _, p in pairs(Util.randomSort(relevantProducts)) do
        if one:canStoreProduct(p) and one:getProductStorage(p) > 0  then product = p break end
    end

    return {
        {one, t("chatter_hope_for_peaceful_flight", product)}
    }
end, {
    filters = { function(one)
        if not isMerchant(one) or isMute(one) or not ShipTemplateBased:hasStorage(one) then return false end

        for _, product in pairs(relevantProducts) do
            if one:canStoreProduct(product) and one:getProductStorage(product) > 0 then return true end
        end

        return false
    end }
}), "hope_for_peaceful_flight")


-- chatter_hartman
My.ChatterNoise:addChatFactory(Chatter:newFactory(2, function(one, two)
    one.hatesHartman = true
    if two.hatesHartman == nil then
        if math.random(0, 1) == 0 then
            two.hatesHartman = true
        else
            two.hatesHartman = false
        end
    end

    local secondId = "chatter_hartman_2_reject"
    if two.hatesHartman then
        secondId = "chatter_hartman_2_accept"
    end

    return {
        {one, t("chatter_hartman_1", My.Config.commander)},
        {two, t(secondId)},
    }
end, {
    filters = {
        function(one)
            return isEeShip(one) and isLocal(one) and not isMute(one) and one.hatesHartman ~= false
        end,
        function(two, one)
            return isEeShip(two) and not isMute(two) and not one:isEnemy(two)
        end,
    }
}), "hartman")

-- chatter_treasure
My.ChatterNoise:addChatFactory(Chatter:newFactory(2, function(one, two)
    local drop = My.World:getDrops()
    return {
        {one, t("chatter_treasure_1", drop:getSectorName())},
        {two, t("chatter_treasure_2")},
    }
end, {
    filters = {
        function(one)
            return isEeShip(one) and isLocal(one) and not isMute(one) and Util.size(My.World:getDrops()) > 0
        end,
        function(two, one)
            return isEeShip(two) and isLocal(two) and not isMute(two) and not two:isEnemy(one)
        end,
    }
}), "treasure")

My.EventHandler:register("onAttackersDetection", function()
    for id, _ in pairs(My.ChatterNoise:getChatFactories()) do
        My.ChatterNoise:removeChatFactory(id)
    end
end)
