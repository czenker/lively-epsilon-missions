My.EventHandler:register("onStart", function()
    Cron.regular(function(self)
        if not My.World.player:isValid() then
            Cron.abort(self)
        elseif My.World.player:getReputationPoints() > 150 then
            Cron.abort(self)
            My.EventHandler:fire("onFirstMoneyEarned")
        end
    end, 1)

    Cron.once(function()
        My.EventHandler:fire("onDrivesAvailable")
    end)
end)

My.EventHandler:register("onFirstMoneyEarned", function()

    Cron.once(function()
        My.EventHandler:fire("onLaserRefitReward")
    end, 60 * 30)

    Cron.once(function()
        My.EventHandler:fire("onPowerPresetsReward")
    end, 60 * 45)

    Cron.once(function()
        My.EventHandler:fire("onAttackersSpawn")
    end, 60 * 60)
end)


