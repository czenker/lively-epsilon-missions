My = My or {}
local t = My.Translator.translate

local minCharge = 10
local rateAtCenter = 1
local rateAtEdge = 0.5

local totalShieldLevel = function(ship)
    local total = 0
    for i=0,ship:getShieldCount()-1 do
        total = total + ship:getShieldLevel(i)
    end

    return total
end

My.installShieldEmp = function(player, range)

    local menu
    menu = function()
        local submenu = Menu:new()

        submenu:addItem("upgrade_shieldemp_label", Menu:newItem(t("upgrade_shieldemp_label"), 0))

        submenu:addItem("upgrade_shieldemp_info", Menu:newItem(t("upgrade_shieldemp_info_label"), function()
            local totalShield = totalShieldLevel(player)
            local minDmg = totalShield * rateAtEdge
            local maxDmg = totalShield * rateAtCenter
            return t("upgrade_shieldemp_info", range / 1000, maxDmg, minDmg)
        end, 1))

        submenu:addItem("upgrade_shieldemp_fire", Menu:newItem(t("upgrade_shieldemp_fire_label"), function()
            local totalShield = totalShieldLevel(player)
            if totalShield < minCharge then
                return t("upgrade_shieldemp_error_charge", minCharge)
            elseif not player:getShieldsActive() then
                return t("upgrade_shieldemp_error_shields_down")
            else
                -- make it boooooom
                local minDmg = totalShield * rateAtEdge
                local maxDmg = totalShield * rateAtCenter
                player:setShields(0,0,0,0,0,0,0,0)
                local x, y = player:getPosition()
                for _, thing in pairs(player:getObjectsInRange(range)) do
                    if isFunction(thing.takeDamage) and player ~= thing then
                        local d = distance(x, y, thing)
                        local damage = (d/range) * minDmg + (1 - d/range) * maxDmg
                        thing:takeDamage(damage, "emp", x, y)
                    end
                end
                ElectricExplosionEffect():setPosition(x, y):setSize(radius)
            end
        end, 2))

        return submenu
    end

    player:addWeaponsMenuItem("shieldemp", Menu:newItem(t("upgrade_shieldemp_label"), menu))
end