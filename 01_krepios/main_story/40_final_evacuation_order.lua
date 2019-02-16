local t = My.Translator.translate

My.EventHandler:register("onCommanderDead", function()
    local colonel = My.World.colonel
    local colonelPerson = My.World.colonel:getCrewAtPosition("colonel")
    local commanderPerson = My.Commander:getPerson()
    local player = My.World.player

    local commsHeroic = function()
        local screen = Comms:newScreen(t("story_final_evacuation_order_2_heroic", player:getCallSign(), colonelPerson))

        Tools:endStoryComms()
        return screen
    end
    local commsCoward = function()
        local screen = Comms:newScreen(t("story_final_evacuation_order_2_coward", commanderPerson, colonelPerson))

        Tools:endStoryComms()
        return screen
    end

    local comms1 = Comms:newScreen(t("story_final_evacuation_order_1", player:getCallSign(), commanderPerson))
                        :addReply(Comms:newReply(t("story_final_evacuation_order_1_response_heroic"), commsHeroic))
                        :addReply(Comms:newReply(t("story_final_evacuation_order_1_response_coward"), commsCoward))

    Tools:storyComms(colonel, player, comms1)
end)
