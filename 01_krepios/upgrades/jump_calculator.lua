local t = My.Translator.translate
local f = string.format
My = My or {}

My.installJumpCalculator = function()
    My.World.player:addScienceMenuItem("jump_calculator", Menu:newItem(t("upgrade_jumpCalculator_label"), function()
        local player = My.World.player
        local submenu = Menu:new()

        submenu:addItem(Menu:newItem(t("upgrade_jumpCalculator_label"), -2))
        submenu:addItem(Menu:newItem(t("upgrade_jumpCalculator_label_info_button"), function()
            return t("upgrade_jumpCalculator_label_info")
        end, -1))

        for i, station in pairs(player:getQuickDials()) do
            if isEeStation(station) and station:isValid() then
                submenu:addItem(Menu:newItem(station:getCallSign(), function()
                    local heading = Util.round(Util.heading(player, station))
                    local d = distance(player, station)
                    return t("upgrade_jumpCalculator_result", station:getCallSign(), heading, d / 1000)
                end, i))
            end
        end

        local offset = Util.size(player:getQuickDials())

        for i=1,player:getWaypointCount() do
            submenu:addItem(Menu:newItem(t("upgrade_jumpCalculator_waypoint_label", i), function()
                local x, y = player:getWaypoint(i)
                local heading = Util.round(Util.heading(player, x, y))
                local d = distance(player, x, y)
                return t("upgrade_jumpCalculator_result", t("upgrade_jumpCalculator_waypoint_label", i), heading, d / 1000)
            end, i + offset))
        end

        return submenu
    end))
end
