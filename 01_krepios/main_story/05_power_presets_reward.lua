local t = My.Translator.translate

My.EventHandler:register("onPowerPresetsReward", function()
    local hq = My.Commander:getLocation()
    local player = My.World.player
    local commanderPerson = My.Commander:getPerson()

    My.Upgrades.powerPresets:install(player)
    Tools:ensureComms(hq, player, t("story_power_presets_award_comms", commanderPerson))
end)