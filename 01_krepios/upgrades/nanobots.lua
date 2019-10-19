My = My or {}
local t = My.Translator.translate

My.installNanobots = function(player, repairAmount, repairTime)
    local nanobotsActive = false

    local menu
    menu = function()
        local submenu = Menu:new()

        submenu:addItem("upgrade_nanobots_label", Menu:newItem(t("upgrade_nanobots_label"), 0))

        submenu:addItem("upgrade_nanobots_info", Menu:newItem(t("upgrade_nanobots_info_label"), function()
            return t("upgrade_nanobots_info", repairAmount / player:getHullMax() * 100, repairTime)
        end, 1))

        if nanobotsActive then
            submenu:addItem("upgrade_nanobots_currently_active", Menu:newItem(t("upgrade_nanobots_currently_active"), 2))
        elseif player:getProductStorage(products.nanobot) > 0 then
            submenu:addItem("upgrade_nanobots_go", Menu:newItem(t("upgrade_nanobots_go_label"), function()
                if player:getShieldsActive() then
                    return t("upgrade_nanobots_no_shields")
                elseif player:getProductStorage(products.nanobot) > 0 then
                    player:modifyProductStorage(products.nanobot, -1)
                    nanobotsActive = true

                    local remainingTime = repairTime
                    Cron.regular(function(self, delta)
                        if player:getShieldsActive() then
                            player:addCustomMessage("engineering", "upgrade_nanobots_no_shields_alert", t("upgrade_nanobots_no_shields_alert"))
                            nanobotsActive = false
                            Cron.abort(self)
                        else
                            player:setHull(math.min(player:getHull() + delta * repairAmount / repairTime, player:getHullMax()))
                            remainingTime = remainingTime - delta
                            if remainingTime <= 0 then
                                nanobotsActive = false
                                Cron.abort(self)
                            end
                        end
                    end)
                end
                return menu()
            end, 2))
        else
            submenu:addItem("upgrade_nanobots_no_charges", Menu:newItem(t("upgrade_nanobots_no_charges"), 2))
        end

        return submenu
    end

    player:addEngineeringMenuItem("nanobots", Menu:newItem(t("upgrade_nanobots_label"), menu))
end