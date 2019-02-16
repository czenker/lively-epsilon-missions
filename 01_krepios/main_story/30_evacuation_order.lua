local t = My.Translator.translate


My.EventHandler:register("onClosingInToFortress", function()
    local colonel = My.World.colonel
    local colonelPerson = My.World.colonel:getCrewAtPosition("colonel")
    local fortress = My.World.fortress
    local wormhole = My.Wormhole
    local player = My.World.player

    local comms2 = function(answer)
        return function()

            local screen = Comms:newScreen()
            if answer == 1 then
                screen:addText(t("story_evacuation_order_2_heroic", player:getCallSign()))
            elseif answer == 2 then
                screen:addText(t("story_evacuation_order_2_neutral", player:getCallSign()))
            else
                screen:addText(t("story_evacuation_order_2_coward"))
            end
            screen:addText(" ")
            screen:addText(t("story_evacuation_order_2"))

            Tools:endStoryComms()
            return screen
        end
    end

    local comms1 = Comms:newScreen(t("story_evacuation_order_1", colonelPerson, player:getCallSign(), fortress:getCallSign(), wormhole:getSectorName()))
                        :addReply(Comms:newReply(t("story_evacuation_order_1_response_heroic"), comms2(1)))
                        :addReply(Comms:newReply(t("story_evacuation_order_1_response_neutral"), comms2(2)))
                        :addReply(Comms:newReply(t("story_evacuation_order_1_response_coward"), comms2(3)))

    Tools:storyComms(colonel, player, comms1)

end)
