local t = My.Translator.translate

My.EventHandler:register("onHQDestroyed", function()
    if My.Commander:isAlive() then
        local commanderLocation = My.Commander:getLocation()
        local commander = My.Commander:getPerson()
        local player = My.World.player

        Tools:ensureComms(commanderLocation, player, t("story_hq_destroyed", commander))
    end
end)
