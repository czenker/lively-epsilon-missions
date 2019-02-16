local t = My.Translator.translate

local cronId = "financial_support"


My.EventHandler:register("onDefensePlanned", function()
    Cron.regular(cronId, function()
        local player = My.World.player
        local colonel = My.World.colonel
        local colonelPerson = colonel:getCrewAtPosition("colonel")

        if player:isValid() and colonel ~= nil and colonel:isValid() then
            local amount = Util.round(math.random(200, 400), 5)

            Tools:ensureComms(colonel, player, t("story_mission_financial_support_comms", colonelPerson, amount))
            player:addToShipLog(t("story_mission_financial_support_hint", amount), "255,127,0")
            player:addReputationPoints(amount)
        else
            Cron.abort(cronId)
        end

    end, 600, math.random(580, 620))
end)

My.EventHandler:register("onCommanderDead", function()
    Cron.abort(cronId)
end)

My.EventHandler:register("onEnemiesDestroyed", function()
    Cron.abort(cronId)
end)
