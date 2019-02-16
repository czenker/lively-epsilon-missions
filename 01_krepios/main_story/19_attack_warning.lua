local t = My.Translator.translate

local detected = false

My.EventHandler:register("onAttackersDetection", function()
    detected = true
end)

My.EventHandler:register("onAttackersSpawn", function()
    Cron.once(function()
        if not detected then
            local colonel = My.World.colonel
            local colonelPerson = My.World.colonel:getCrewAtPosition("colonel")
            local player = My.World.player

            Tools:ensureComms(colonel, player, t("story_attack_warning", colonelPerson))
        end
    end, 60)
end)