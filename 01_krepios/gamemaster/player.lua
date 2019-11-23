local f = string.format

local createMainMenu, createReputationMenu, createCrewMenu, createUpgradeMenu, createStorageMenu, createStorageDetailMenu, createMissionMenu, createMissionDetailMenu

local getSortedProducts = function()
    local prods = {}
    for _, product in pairs(products) do
        table.insert(prods, product)
    end
    table.sort(prods, function(a, b) return a:getName() < b:getName() end)
    return prods
end

local getSortedUpgrades = function()
    local upgrades = {}
    for _, upgrade in pairs(My.Upgrades) do
        table.insert(upgrades, upgrade)
    end
    table.sort(upgrades, function(a, b) return a:getName() < b:getName() end)
    return upgrades
end

local getSortedMissions = function(player)
    local missions = {}
    for _, mission in pairs(player:getStartedMissions()) do
        if Generic:hasTags(mission) and mission:hasTag("side_mission") then
            table.insert(missions, mission)
        end
    end
    table.sort(missions, function(a, b) return a:getTitle() < b:getTitle() end)
    return missions
end


createMainMenu = function()
    local menu = Menu:new()

    menu:addItem(Menu:newItem("Reputation", createReputationMenu, 1))
    menu:addItem(Menu:newItem("Crew", createCrewMenu, 2))
    menu:addItem(Menu:newItem("Upgrades", createUpgradeMenu, 3))
    menu:addItem(Menu:newItem("Storage", createStorageMenu, 4))
    menu:addItem(Menu:newItem("Missions", createMissionMenu, 5))
    menu:addItem(Menu:newItem("Reset Menus", function()
        local player = My.World.player
        player:drawHelmsMenu()
        player:drawRelayMenu()
        player:drawScienceMenu()
        player:drawWeaponsMenu()
        player:drawEngineeringMenu()
    end, 5))

    return menu
end

createReputationMenu = function()
    local player = My.World.player

    local menu = Menu:new()

    menu:addItem(Menu:newItem(f("< %0.2fRP", player:getReputationPoints()), createMainMenu, 1))

    for i, delta in pairs({100, 20, 5, 1}) do
        menu:addItem(Menu:newItem(f("+ %d", delta), function()
            player:addReputationPoints(delta)
            logInfo(f("%dRP added by GM", delta))
            return createReputationMenu()
        end, 10 + i))
    end

    for i, delta in pairs({1, 5, 20, 100}) do
        if player:getReputationPoints() >= delta then
            menu:addItem(Menu:newItem(f("- %d", delta), function()
                player:takeReputationPoints(delta)
                logInfo(f("%dRP removed by GM", delta))
                return createReputationMenu()
            end, 20 + i))
        end
    end

    if player:getReputationPoints() > 0 then
        menu:addItem(Menu:newItem("Empty", function()
            logInfo(f("Reputation reduced by %0.2fRP by GM", player:getReputationPoints()))
            player:takeReputationPoints(player:getReputationPoints())
            return createReputationMenu()
        end, 30))
    end
    return menu
end

createCrewMenu = function()
    local player = My.World.player

    local menu = Menu:new()

    menu:addItem(Menu:newItem(f("< %d Crew", player:getRepairCrewCount()), createMainMenu, 1))

    if player:getRepairCrewCount() < 8 then
        menu:addItem(Menu:newItem("+1 Crew", function()
            player:setRepairCrewCount(player:getRepairCrewCount() + 1)
            logInfo("1 Crew Member added by GM")
            return createCrewMenu()
        end, 2))
    end
    if player:getRepairCrewCount() > 0 then
        menu:addItem(Menu:newItem("-1 Crew", function()
            player:setRepairCrewCount(math.max(0, player:getRepairCrewCount() - 1))
            logInfo("1 Crew Member removed by GM")
            return createCrewMenu()
        end, 3))
        menu:addItem(Menu:newItem("No Crew", function()
            logInfo(f("GM removed %d Crew Members", player:getRepairCrewCount()))
            player:setRepairCrewCount(0)
            return createCrewMenu()
        end, 4))
    end

    return menu
end

createUpgradeMenu = function()
    local player = My.World.player

    local menu = Menu:new()

    menu:addItem(Menu:newItem("< Upgrades", createMainMenu, 1))
    menu:addItem(Menu:newItem("Log info", function()
        local sortedUpgrades = getSortedUpgrades()
        local text = ""
        if Player:hasUpgradeTracker(player) then
            text = text .. "Installed Upgrades:\n"
            for _, upgrade in pairs(sortedUpgrades) do
                if player:hasUpgrade(upgrade) then
                    text = text .. f("  * %s", upgrade:getName()) .. "\n"
                end
            end
            text = text .. "\n"
        end

        text = text .. "Installable Upgrades:\n"
        for _, upgrade in pairs(sortedUpgrades) do
            if upgrade:canBeInstalled(player) then
                text = text .. f("  * %s (%0.2fRP)", upgrade:getName(), upgrade:getPrice()) .. "\n"
            end
        end
        text = text .. "\n"

        text = text .. "Other Upgrades:\n"
        for _, upgrade in pairs(sortedUpgrades) do
            if (not Player:hasUpgradeTracker(player) or not player:hasUpgrade(upgrade)) and not upgrade:canBeInstalled(player) then
                text = text .. f("  * %s (%0.2fRP)", upgrade:getName(), upgrade:getPrice()) .. "\n"
            end
        end
        text = text .. "\n"

        if isFunction(addGMMessage) then
            addGMMessage(text)
        else
            logInfo(text)
        end
    end, 2))

    for i, upgrade in ipairs(getSortedUpgrades()) do
        if Player:hasUpgradeTracker(player) and player:hasUpgrade(upgrade) then
            menu:addItem(Menu:newItem(f("[%s]", upgrade:getName()), function() end, i + 2))
        elseif upgrade:canBeInstalled(player) then
            menu:addItem(Menu:newItem(f("%s >", upgrade:getName()), function()
                upgrade:install(player)
                logInfo(upgrade:getName() .. " installed by GM")
                return createUpgradeMenu()
            end, i + 2))
        else
            menu:addItem(Menu:newItem(upgrade:getName(), function() end, i + 2))
        end
    end

    return menu
end

createStorageMenu = function()
    local player = My.World.player
    local menu = Menu:new()
    menu:addItem(Menu:newItem("< Storage", createMainMenu, 0))
    for i, product in pairs(getSortedProducts()) do
        menu:addItem(Menu:newItem(f("%d/%d %s", player:getProductStorage(product), player:getMaxProductStorage(product), product:getName()), createStorageDetailMenu(product), i))
    end
    return menu
end

createStorageDetailMenu = function(product)
    local player = My.World.player

    return function()
        local menu = Menu:new()
        menu:addItem(Menu:newItem("< Storage", createStorageMenu, 0))
        menu:addItem(Menu:newItem(f("%d/%d %s", player:getProductStorage(product), player:getMaxProductStorage(product), product:getName()), function() end, 1))

        if player:getEmptyProductStorage(product) > 0 then
            menu:addItem(Menu:newItem("full", function()
                player:modifyProductStorage(product, player:getMaxProductStorage(product))
                return createStorageDetailMenu(product)()
            end, 10))
        end

        for i, delta in pairs({100, 20, 5, 1}) do
            if player:getEmptyProductStorage(product) >= delta then
                menu:addItem(Menu:newItem(f("+ %d", delta), function()
                    player:modifyProductStorage(product, delta)
                    return createStorageDetailMenu(product)()
                end, i + 10))
            end
        end

        for i, delta in pairs({1, 5, 20, 100}) do
            if player:getProductStorage(product) >= delta then
                menu:addItem(Menu:newItem(f("- %d", delta), function()
                    player:modifyProductStorage(product, -1 * delta)
                    return createStorageDetailMenu(product)()
                end, i + 20))
            end
        end

        if player:getProductStorage(product) > 0 then
            menu:addItem(Menu:newItem("empty", function()
                player:modifyProductStorage(product, -1 * player:getMaxProductStorage(product))
                return createStorageDetailMenu(product)()
            end, 30))
        end
        return menu
    end
end

createMissionMenu = function()
    local player = My.World.player
    local menu = Menu:new()
    menu:addItem(Menu:newItem("< Missions", createMainMenu, 0))
    for i, mission in pairs(getSortedMissions(player)) do
        menu:addItem(Menu:newItem(mission:getTitle(), createMissionDetailMenu(mission), i))
    end
    return menu
end

createMissionDetailMenu = function(mission)
    return function()
        local menu = Menu:new()
        menu:addItem(Menu:newItem(f("< %s", mission:getTitle()), createMissionMenu, 0))
        menu:addItem(Menu:newItem("Abort", function()
            if mission:getState() == "started" then
                logInfo(f("Mission \"%s\" aborted by GM", mission:getTitle()))
                mission:fail()
            end
        end, 1))

        return menu
    end
end

My.EventHandler:register("onWorldCreation", function()
    Menu:addGmMenuItem(Menu:newItem("Player", createMainMenu))
end)