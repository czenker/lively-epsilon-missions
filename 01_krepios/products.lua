My = My or {}
local t = My.Translator.translate

local s = 1
local m = 2
local l = 4
local xl = 8
local xxl = 16

products = {
    ore = {
        name = t("products_ore_name"),
        description = t("products_ore_description"),
        size = m,
        basePrice = 1,
    },
    plutoniumOre = {
        name = t("products_plutoniumOre_name"),
        description = t("products_plutoniumOre_description"),
        size = l,
        basePrice = 10,
    },
    miningMachinery = {
        name = t("products_miningMachinery_name"),
        description = t("products_miningMachinery_description"),
        size = xl,
        basePrice = 15,
    },
    power = {
        name = t("products_power_name"),
        description = t("products_power_description"),
        size = s,
        basePrice = 1,
    },

    -- those have special meaning because of their id
    hvli = {
        name = t("products_hvli_name"),
        description = t("products_hvli_description"),
        size = m,
        basePrice = 4,
    },
    homing = {
        name = t("products_homing_name"),
        description = t("products_homing_description"),
        size = m,
        basePrice = 4,
    },
    mine = {
        name = t("products_mine_name"),
        description = t("products_mine_description"),
        size = xl,
        basePrice = 8,
    },
    emp = {
        name = t("products_emp_name"),
        description = t("products_emp_description"),
        size = l,
        basePrice = 10,
    },
    nuke = {
        name = t("products_nuke_name"),
        description = t("products_nuke_description"),
        size = l,
        basePrice = 30,
    },
    scanProbe = {
        name = t("products_scanProbe_name"),
        description = t("products_scanProbe_description"),
        size = m,
        basePrice = 2,
    },
    nanobot = {
        name = t("products_nanobot_name"),
        description = t("products_nanobot_description"),
        size = xl,
        basePrice = 12,
    },
}

-- add id to object
for k, v in pairs(products) do
    products[k] = Product:new(v.name, {
        id = k,
        size = v.size,
    })
    products[k].basePrice = v.basePrice
    products[k].description = v.description
end

-- validate
for k, v in pairs(products) do
    if not Product:isProduct(v) then
        logError ("Product with id " .. k .. " is not valid.")
    end
end

My.buyingPrice = function(product)
    local price = product.basePrice * (math.random() * 0.1 + 1.1)
    return function(station, seller)
        local factor = 1
        if isEeShipTemplateBased(station) and isEeShipTemplateBased(seller) then
            if station:isFriendly(seller) then
                factor = 1.1
            else
                factor = 1
            end
        end
        return price * factor
    end
end

My.sellingPrice = function(product)
    local price = product.basePrice * (math.random() * 0.1 + 0.8)
    return function(station, buyer)
        local factor = 1
        if isEeShipTemplateBased(station) and isEeShipTemplateBased(buyer) then
            if station:isFriendly(buyer) then
                factor = 0.9
            else
                factor = 1
            end
        end
        return price * factor
    end
end

My.rebuyingPrice = function(product)
    local price = product.basePrice * (math.random() * 0.1 + 0.65)
    return function(station, buyer)
        local factor = 1
        if isEeShipTemplateBased(station) and isEeShipTemplateBased(buyer) then
            if station:isFriendly(buyer) then
                factor = 0.9
            else
                factor = 1
            end
        end
        return price * factor
    end
end