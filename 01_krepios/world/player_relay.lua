local t = My.Translator.translate
local f = string.format

-- button to quick dial
My.EventHandler:register("onStart", function()
    local player = My.World.player
    Player:withQuickDial(player, {
        label = t("player_relay_quick_dial_button")
    })
end)

My.EventHandler:register("onFortressManned", function()
    My.World.player:addQuickDial(My.World.fortress)
end)