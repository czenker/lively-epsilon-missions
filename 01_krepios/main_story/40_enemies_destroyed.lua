local t = My.Translator.translate

My.EventHandler:register("onEnemiesDestroyed", function()
    local colonel = My.World.colonel
    local colonelPerson = My.World.colonel:getCrewAtPosition("colonel")
    local player = My.World.player
    Tools:ensureComms(colonel, player, t("story_mission_debrief_1", colonelPerson))
end)
