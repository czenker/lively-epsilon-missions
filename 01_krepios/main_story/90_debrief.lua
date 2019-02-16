local t = My.Translator.translate

My.EventHandler:register("onEvacComplete", function()
    local colonel = My.World.colonel
    local commanderPerson = My.Commander:getPerson()
    local player = My.World.player

    local areEnemiesDestroyed = not My.EnemyFleet:isValid()
    local isCommanderDead = not My.Commander:isAlive()

    local text
    if areEnemiesDestroyed then
        if isCommanderDead then
            text = t("story_final_evacuation_debrief_survivors", player:getCallSign(), commanderPerson)
        else
            text = t("story_final_evacuation_debrief_heroic", player:getCallSign(), commanderPerson)
        end
    else
        if isCommanderDead then
            text = t("story_final_evacuation_debrief_lost", player:getCallSign(), commanderPerson)
        else
            text = t("story_final_evacuation_debrief_unclear", player:getCallSign(), commanderPerson)
        end
    end

    local screen = Comms:newScreen(text)
    screen:addReply(Comms:newReply(t("story_final_evacuation_debrief_ok"), function()
        Tools:endStoryComms()
        if areEnemiesDestroyed then
            victory("Human Navy")
        else
            victory("Legion")
        end
        return Comms:newScreen("")
    end))

    Tools:storyComms(colonel, player, screen)
end)
