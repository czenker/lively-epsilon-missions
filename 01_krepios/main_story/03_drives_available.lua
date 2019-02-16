local t = My.Translator.translate

My.EventHandler:register("onDrivesAvailable", function()
    local hq = My.World.hq

    hq:addUpgrade(My.Upgrades.warpDrive)
    hq:addUpgrade(My.Upgrades.jumpDrive)
end)

My.EventHandler:register("onDrivesAvailable", function()

    local hq = My.World.hq
    local player = My.World.player
    local colonelPerson = My.Config.colonel
    local colonel = My.World.colonel
    local commanderPerson = My.Commander:getPerson()

    Tools:ensureComms(colonel, player, t("story_drives_available", colonelPerson, commanderPerson, hq:getCallSign()))
end)
