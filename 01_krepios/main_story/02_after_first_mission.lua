local t = My.Translator.translate


My.EventHandler:register("onFirstMoneyEarned", function()
    Cron.once(function()
        local hq = My.Commander:getLocation()
        local player = My.World.player
        local commanderPerson = My.Commander:getPerson()

        Tools:ensureComms(hq, player, t("story_after_first_mission", commanderPerson))
    end, 60)
end)
