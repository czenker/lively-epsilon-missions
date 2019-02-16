local t = My.Translator.translate
local f = string.format

local allStations = function()
    local stations = {}

    for _,station in pairs(My.World.stations) do
        if station:isValid() then table.insert(stations, station) end
    end
    for _,station in pairs(My.World.abandonedStations) do
        if station:isValid() then table.insert(stations, station) end
    end
    local fortress = My.World.fortress
    if fortress:isValid() then table.insert(stations, fortress) end

    table.sort(stations, function(a, b)
        if a:isValid() then a = a:getCallSign() else a = "" end
        if b:isValid() then b = b:getCallSign() else b = "" end
        return a < b
    end)

    return stations
end

-- button to show stations
My.EventHandler:register("onStart", function()
    local player = My.World.player

    player:addScienceMenuItem("station", Menu:newItem(t("player_science_info_station_button"), function()
        local stations = allStations()

        local menu = Menu:new()
        for i,station in ipairs(stations) do
            menu:addItem("station" .. i, Menu:newItem(station:getCallSign(), function()
                return f(
                    "%s (%s: %s)\n---------------------\n%s",
                    station:getCallSign(),
                    t("player_science_sector"),
                    station:getSectorName(),
                    station:getDescription("simple")
                )
            end, i))
        end

        return menu
    end))
end)

-- button to show nebulas
My.EventHandler:register("onStart", function()
    local player = My.World.player

    player:addScienceMenuItem("nebula", Menu:newItem(t("player_science_info_nebula_button"), function()
        local nebulas = {}

        for _, nebula in pairs(My.World.nebulas) do
            if nebula:getArtifact():isValid() then table.insert(nebulas, nebula:getArtifact()) end
        end

        table.sort(nebulas, function(a, b)
            if a:isValid() then a = a:getCallSign() else a = "" end
            if b:isValid() then b = b:getCallSign() else b = "" end
            return a < b
        end)

        local menu = Menu:new()
        for i, nebula in ipairs(nebulas) do
            menu:addItem("nebula" .. i, Menu:newItem(nebula:getCallSign(), function()
                return f(
                    "%s (%s: %s)\n---------------------\n%s",
                    nebula:getCallSign(),
                    t("player_science_sector"),
                    nebula:getSectorName(),
                    nebula:getDescription("simple")
                )
            end, i))
        end

        return menu
    end))
end)

-- button to show products
My.EventHandler:register("onStart", function()
    local player = My.World.player

    player:addScienceMenuItem("product", Menu:newItem(t("player_science_info_product_button"), function()
        local prods = {}

        for _, product in pairs(products) do
            if Product:isProduct(product) then table.insert(prods, product) end
        end

        table.sort(prods, function(a, b)
            return a:getName() < b:getName()
        end)

        local menu = Menu:new()
        for i, product in ipairs(prods) do

            menu:addItem("product" .. i, Menu:newItem(product:getName(), function()
                local boughtAt = {}
                local soldAt = {}

                local stations = allStations()
                for _,station in pairs(stations) do
                    if Station:hasMerchant(station) and station:isBuyingProduct(product, player) then
                        table.insert(boughtAt, station:getCallSign())
                    end
                    if Station:hasMerchant(station) and station:isSellingProduct(product, player) then
                        table.insert(soldAt, station:getCallSign())
                    end
                end

                local text = f(
                    "%s\n---------------------\n%s\n\n%s: %0.2fRP\n%s: %d\n",
                    product:getName(),
                    product.description,
                    t("player_science_info_product_base_price"),
                    product.basePrice,
                    t("player_science_info_product_size"),
                    product:getSize()
                )

                if Util.size(soldAt) > 0 then
                    text = text .. f("%s: %s\n", t("player_science_info_product_sold_at"), Util.mkString(soldAt, ", ", " " .. t("generic_and") .. " "))
                end
                if Util.size(boughtAt) > 0 then
                    text = text .. f("%s: %s\n", t("player_science_info_product_bought_at"), Util.mkString(boughtAt, ", ", " " .. t("generic_and") .. " "))
                end

                return text
            end, i))
        end

        return menu
    end))
end)

-- button to show upgrades
My.EventHandler:register("onStart", function()
    local player = My.World.player

    player:addScienceMenuItem("upgrade", Menu:newItem(t("player_science_info_upgrade_button"), function()
        local upgrades = {}

        for _, upgrade in pairs(My.Upgrades) do
            if BrokerUpgrade:isUpgrade(upgrade) then table.insert(upgrades, upgrade) end
        end

        table.sort(upgrades, function(a, b)
            return a:getName() < b:getName()
        end)

        local menu = Menu:new()
        for i, upgrade in ipairs(upgrades) do

            menu:addItem("upgrade" .. i, Menu:newItem(upgrade:getName(), function()
                local text = f(
                    "%s\n---------------------\n%s\n\n",
                    upgrade:getName(),
                    upgrade:getDescription(player)
                )
                if upgrade:getPrice(player) > 0 then
                    text = text .. f("%s: %0.2fRP\n",
                        t("player_science_info_upgrade_base_price"),
                        upgrade:getPrice()
                    )
                end
                if upgrade:getRequiredUpgradeString() ~= nil and My.Upgrades[upgrade:getRequiredUpgradeString()] ~= nil then
                    text = text .. "\n" .. t("player_science_info_upgrade_required_ugprade", My.Upgrades[upgrade:getRequiredUpgradeString()]:getName()) .. "\n"
                end

                return text
            end, i))
        end

        return menu
    end))
end)
