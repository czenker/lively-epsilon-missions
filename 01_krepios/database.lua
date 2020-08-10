local My = My or {}
local t = My.Translator.translate
local f = string.format

local stationDatabase
local nebulaDatabase
local productDatabase
local upgradeDatabase

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

local removeKeyValues = function(entry)
    for k, _ in pairs(entry:getKeyValues()) do
        entry:removeKey(k)
    end
end

local trackedEntities = {}

My.Database = {
    updateAll = function(self)
        for _, entity in pairs(trackedEntities) do
            if isEeStation(entity) then
                self:addOrUpdateStation(entity)
            elseif isFunction(entity.getRandomCloud) then
                self:addOrUpdateNebula(entity)
            elseif Product:isProduct(entity) then
                self:addOrUpdateProduct(entity)
            elseif BrokerUpgrade:isUpgrade(entity) then
                self:addOrUpdateUpgrade(entity)
            else
                error("Can not update entity " .. typeInspect(entity), 3)
            end
        end
    end,
    createStationDatabase = function(self)
        if stationDatabase == nil then
            stationDatabase = ScienceDatabase():setName(t("database_station_button"))
        end
        return stationDatabase
    end,
    addOrUpdateStation = function(self, station)
        if not station:isValid() then return end
        local db = self:createStationDatabase()
        local entry
        if station.dbEntry then
            entry = station.dbEntry
        else
            entry = db:addEntry(station:getCallSign())
            table.insert(trackedEntities, station)
            station.dbEntry = entry
        end

        -- describe station
        entry:setName(station:getCallSign())
        entry:setLongDescription(station:getDescription("simple") or "")

        removeKeyValues(entry)
        local x, y = station:getPosition()
        entry:addKeyValue("Faction", station:getFaction())
        entry:addKeyValue("Location", f("%0.0f, %0.0f", x, y))
        entry:addKeyValue("Sector", station:getSectorName())
    end,
    createNebulaDatabase = function(self)
        if nebulaDatabase == nil then
            nebulaDatabase = ScienceDatabase():setName(t("database_nebula_button"))
        end
        return nebulaDatabase
    end,
    addOrUpdateNebula = function(self, nebula)
        if not nebula:isValid() then return end
        local db = self:createNebulaDatabase()
        local entry
        if nebula.dbEntry then
            entry = nebula.dbEntry
        else
            entry = db:addEntry(nebula:getName())
            table.insert(trackedEntities, nebula)
            nebula.dbEntry = entry
        end

        -- describe nebula
        entry:setName(nebula:getName())
        entry:setLongDescription(nebula:getDescription("simple") or "")

        removeKeyValues(entry)
        entry:addKeyValue("Sector", nebula:getSectorName())
        entry:addKeyValue("Clouds", nebula:countClouds())
    end,
    createProductDatabase = function(self)
        if productDatabase == nil then
            productDatabase = ScienceDatabase():setName(t("database_product_button"))
        end
        return productDatabase
    end,
    addOrUpdateProduct = function(self, product)
        local db = self:createProductDatabase()
        local entry
        if product.dbEntry then
            entry = product.dbEntry
        else
            entry = db:addEntry(product:getName())
            table.insert(trackedEntities, product)
            product.dbEntry = entry
        end

        -- describe product
        entry:setName(product:getName())
        entry:setLongDescription(product.description or "")

        removeKeyValues(entry)
        entry:addKeyValue(t("database_product_base_price"), f("%0.2fRP", product.basePrice))
        entry:addKeyValue(t("database_product_size"), f("%d units", product:getSize()))

        for _, station in pairs(allStations()) do
            if Station:hasMerchant(station) and station:isBuyingProduct(product) then
                entry:addKeyValue(t("database_product_bought_at"), station:getCallSign())
            end
        end
        for _, station in pairs(allStations()) do
            if Station:hasMerchant(station) and station:isSellingProduct(product) then
                entry:addKeyValue(t("database_product_sold_at"), station:getCallSign())
            end
        end
    end,
    createUpgradeDatabase = function(self)
        if upgradeDatabase == nil then
            upgradeDatabase = ScienceDatabase():setName(t("database_upgrade_button"))
        end
        return upgradeDatabase
    end,
    addOrUpdateUpgrade = function(self, upgrade)
        local db = self:createUpgradeDatabase()
        local entry
        if upgrade.dbEntry then
            entry = upgrade.dbEntry
        else
            entry = db:addEntry(upgrade:getName())
            table.insert(trackedEntities, upgrade)
            upgrade.dbEntry = entry
        end

        -- describe upgrade
        entry:setName(upgrade:getName())
        -- @TODO: not nice to have the player hardcoded here
        entry:setLongDescription(upgrade:getDescription(My.World.player) or "")

        removeKeyValues(entry)
        if upgrade:getPrice() > 0 then
            entry:addKeyValue(t("database_upgrade_base_price"), f("%0.2fRP", upgrade:getPrice()))
        end
        if upgrade:getRequiredUpgradeString() ~= nil and My.Upgrades[upgrade:getRequiredUpgradeString()] ~= nil then
            entry:addKeyValue(t("database_upgrade_required_upgrade"), My.Upgrades[upgrade:getRequiredUpgradeString()]:getName())
        end
        for _, station in pairs(allStations()) do
            if Station:hasUpgradeBroker(station) and station:hasUpgrade(upgrade) then
                entry:addKeyValue(t("database_upgrade_sold_at"), station:getCallSign())
            end
        end
    end,
}

My.EventHandler:register("onStart", function()
    for _, product in pairs(products) do
        if Product:isProduct(product) then
            My.Database:addOrUpdateProduct(product)
        end
    end

    -- make sure all records are up to date
    My.Database:updateAll()
end, 999)