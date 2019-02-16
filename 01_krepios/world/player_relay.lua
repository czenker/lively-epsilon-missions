local t = My.Translator.translate
local f = string.format

-- button to quick dial
My.EventHandler:register("onStart", function()
    local player = My.World.player

    player.quickDials = {}

    player:addRelayMenuItem("quick_dial", Menu:newItem(t("player_relay_quick_dial_button"), function()
        local targets = {}
        for _, target in pairs(player.quickDials) do
            if isEeShipTemplateBased(target) and target:isValid() then
                table.insert(targets, target)
            elseif Fleet:isFleet(target) and target:isValid() then
                table.insert(targets, target:getLeader())
            end
        end

        table.sort(targets, function(a, b)
            if a:isValid() then a = a:getCallSign() else a = "" end
            if b:isValid() then b = b:getCallSign() else b = "" end
            return a < b
        end)

        local menu = Menu:new()
        menu:addItem(Menu:newItem(t("player_relay_quick_dial_button"), 0))
        for i, target in ipairs(targets) do
            menu:addItem("station" .. i, Menu:newItem(target:getCallSign(), function()
                player:commandOpenTextComm(target)
            end, i))
        end

        return menu
    end))
end)

My.EventHandler:register("onFortressManned", function()
    table.insert(My.World.player.quickDials, My.World.fortress)
end)