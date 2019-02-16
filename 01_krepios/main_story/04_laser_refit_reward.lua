local t = My.Translator.translate

My.EventHandler:register("onLaserRefitReward", function()
    local hq = My.Commander:getLocation()
    local player = My.World.player
    local commanderPerson = My.Commander:getPerson()

    My.Upgrades.laserRefit:install(player)
    Tools:ensureComms(hq, player, t("story_laser_refit_award_comms", commanderPerson))
end)