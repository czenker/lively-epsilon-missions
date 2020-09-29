local f = string.format

local createMainMenu, createStationMenu, createStorageMenu, createStorageDetailMenu, createMissionMenu, createMissionDetailMenu, createTinkererMenu, createChangeTinkererMenu

local getSortedStations = function()
    local stations = {}

    for _,station in pairs(My.World.stations) do
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

local getSortedProducts = function()
    local prods = {}
    for _, product in pairs(products) do
        table.insert(prods, product)
    end
    table.sort(prods, function(a, b) return a:getName() < b:getName() end)
    return prods
end

local getSortedMissions = function(station)
    local missions = {}
    for _, mission in pairs(station:getMissions()) do
        if Mission:isBrokerMission(mission) then
            table.insert(missions, mission)
        end
    end
    table.sort(missions, function(a, b) return a:getTitle() < b:getTitle() end)

    return missions
end

local function isShipyard(station) return Station:hasCrew(station) and station:hasCrewAtPosition("tinkerer") end

createMainMenu = function()
    return function()
        local menu = Menu:new()

        for i,station in ipairs(getSortedStations()) do
            menu:addItem(Menu:newItem(station:getCallSign(), createStationMenu(station), i))
        end

        return menu
    end
end

createStationMenu = function(station)
    return function()
        local menu = Menu:new()
        menu:addItem(Menu:newItem("Log Info", function()
            local text = ""
            text = text .. f("%s (Sector: %s)", station:getCallSign(), station:getSectorName()) .. "\n\n"
            text = text .. station:getDescription("simple") .. "\n\n"
            if Station:hasStorage(station) then
                text = text .. "Storage:\n"
                for _, product in pairs(getSortedProducts()) do
                    if station:canStoreProduct(product) then
                        text = text .. f("  * %d/%d %s", station:getProductStorage(product), station:getMaxProductStorage(product), product:getName()) .. "\n"
                    end
                end
                text = text .. "\n"
            end
            if Station:hasMissionBroker(station) then
                text = text .. "Missions:\n"
                for _, mission in pairs(getSortedMissions(station)) do
                    text = text .. f(
                        "  * \"%s\" (%s)",
                        mission:getTitle(),
                        Util.mkString(mission:getTags(), ", ")
                    ) .. "\n"
                end
                text = text .. "\n"
            end
            if isFunction(addGMMessage) then
                addGMMessage(text)
            else
                logInfo(text)
            end
        end, 1))

        if Station:hasStorage(station) then
            menu:addItem(Menu:newItem("Storage", createStorageMenu(station), 2))
        end

        if Station:hasMissionBroker(station) then
            menu:addItem(Menu:newItem("Missions", createMissionMenu(station), 3))
        end

        if isShipyard(station) then
            menu:addItem(Menu:newItem("Tinkerer", createTinkererMenu(station), 4))
        end

        menu:addItem(Menu:newItem("Back", createMainMenu(), 999))

        return menu
    end
end

createStorageMenu = function(station)
    if not Station:hasStorage(station) then return createStationMenu(station) end

    return function()
        local menu = Menu:new()
        menu:addItem(Menu:newItem("< " .. station:getCallSign(), createStationMenu(station), 0))
        for i, product in pairs(getSortedProducts()) do
            if station:canStoreProduct(product) then
                menu:addItem(Menu:newItem(f("%d/%d %s", station:getProductStorage(product), station:getMaxProductStorage(product), product:getName()), createStorageDetailMenu(station, product), i))
            end
        end
        return menu
    end
end

createStorageDetailMenu = function(station, product)
    if not Station:hasStorage(station) then return createStationMenu(station) end
    if not station:canStoreProduct(product) then return createStorageMenu(station) end

    return function()
        local menu = Menu:new()
        menu:addItem(Menu:newItem("< " .. station:getCallSign(), createStationMenu(station), 0))
        menu:addItem(Menu:newItem(f("%d/%d %s", station:getProductStorage(product), station:getMaxProductStorage(product), product:getName()), function() end, 1))

        if station:getEmptyProductStorage(product) > 0 then
            menu:addItem(Menu:newItem("full", function()
                station:modifyProductStorage(product, station:getMaxProductStorage(product))
                return createStorageDetailMenu(station, product)()
            end, 10))
        end

        for i, delta in pairs({100, 20, 5, 1}) do
            if station:getEmptyProductStorage(product) >= delta then
                menu:addItem(Menu:newItem(f("+ %d", delta), function()
                    station:modifyProductStorage(product, delta)
                    return createStorageDetailMenu(station, product)()
                end, i + 10))
            end
        end

        for i, delta in pairs({1, 5, 20, 100}) do
            if station:getProductStorage(product) >= delta then
                menu:addItem(Menu:newItem(f("- %d", delta), function()
                    station:modifyProductStorage(product, -1 * delta)
                    return createStorageDetailMenu(station, product)()
                end, i + 20))
            end
        end

        if station:getProductStorage(product) > 0 then
            menu:addItem(Menu:newItem("empty", function()
                station:modifyProductStorage(product, -1 * station:getMaxProductStorage(product))
                return createStorageDetailMenu(station, product)()
            end, 30))
        end
        return menu
    end
end

createMissionMenu = function(station)
    if not Station:hasMissionBroker(station) then return createStationMenu(station) end

    return function()
        local menu = Menu:new()
        menu:addItem(Menu:newItem("< " .. station:getCallSign(), createStationMenu(station), 0))

        for i, mission in ipairs(getSortedMissions(station)) do
            menu:addItem(Menu:newItem(mission:getTitle(), createMissionDetailMenu(station, mission), i))
        end

        return menu
    end
end

createMissionDetailMenu = function(station, mission)
    if not Station:hasMissionBroker(station) then return createStationMenu(station) end

    return function()
        local menu = Menu:new()
        menu:addItem(Menu:newItem("< " .. station:getCallSign(), createStationMenu(station), 0))
        menu:addItem(Menu:newItem("< Missions", createMissionMenu(station), 1))
        menu:addItem(Menu:newItem(mission:getTitle(), function() end, 2))

        menu:addItem(Menu:newItem("Log Info", function()
            local text = mission:getTitle() .. "\n\n" .. mission:getDescription()

            if isFunction(addGMMessage) then
                addGMMessage(text)
            else
                logInfo(text)
            end
        end, 3))

        menu:addItem(Menu:newItem("replace", function()
            station:removeMission(mission)
            local newMission
            if mission:hasTag("transport") then
                newMission = My.MissionGenerator.randomTransportMission(station)
            else
                newMission = My.MissionGenerator.randomFightingMission(station)
            end
            station:addMission(newMission)
            return createMissionMenu(station)()
        end, 4))

        return menu
    end
end

createTinkererMenu = function(station)
    if not isShipyard(station) then return createStationMenu(station) end

    return function()
        local menu = Menu:new()
        local upgrade = station:getCurrentUpgrade()
        menu:addItem(Menu:newItem("< " .. station:getCallSign(), createStationMenu(station), 0))

        if upgrade then
            local progress = station:getCurrentUpgradeProgress()

            menu:addItem(Menu:newItem(f("%s (%.0f%%)", upgrade:getName(), progress * 100), createChangeTinkererMenu(station), 1))

            menu:addItem(Menu:newItem("Reset research", function()
                station:addUpgradeProgress(-1 * progress)

                return createTinkererMenu(station)()
            end, 10))

            for i, delta in pairs({-75, -50, -25, -10, 5, 10, 25, 50, 75}) do
                local display = false
                if delta > 0 and progress < 1 - delta / 100 then display = true end
                if delta < 0 and progress > -1 * delta / 100 then display = true end

                if display then
                    menu:addItem(Menu:newItem(f("+ %d%%", delta), function()
                        station:addUpgradeProgress(delta / 100)

                        return createTinkererMenu(station)()
                    end, i + 10))
                end
            end

            menu:addItem(Menu:newItem("Finish now", function()
                station:addUpgradeProgress(1)

                return createTinkererMenu(station)()
            end, 29))
        end

        return menu
    end
end

createChangeTinkererMenu = function(station)
    if not isShipyard(station) then return createStationMenu(station) end
    return function()
        local menu = Menu:new()
        local upgrade = station:getCurrentUpgrade()
        menu:addItem(Menu:newItem("< " .. station:getCallSign(), createTinkererMenu(station), 0))

        for i, theUpgrade in ipairs(station:getResearchableUpgrades()) do
            local label = theUpgrade:getName()
            if theUpgrade:getId() == upgrade:getId() then label = "> " .. label .. " <" end
            menu:addItem(Menu:newItem(label, function()
                station:prioritizeUpgrade(theUpgrade)

                return createTinkererMenu(station)()
            end, i + 10))
        end

        return menu
    end
end

My.EventHandler:register("onWorldCreation", function()
    Menu:addGmMenuItem(Menu:newItem("Stations", createMainMenu()))
end)