local t = My.Translator.translate

My.EventHandler:register("onAttackersDetection", function()
    local hq = My.Commander:getLocation()
    local fortress = My.World.fortress
    local player = My.World.player
    local commander = My.Commander:getPerson()

    local d = math.floor(distance(hq, fortress) / 1000 / 5) * 5

    local comms = Comms:newScreen(t("story_attack_detected_1", commander, player:getCallSign()))
    :addReply(Comms:newReply(t("story_attack_detected_1_response"), function()
        return Comms:newScreen(t("story_attack_detected_2"))
        :addReply(Comms:newReply(t("story_attack_detected_2_response"), function()
            return Comms:newScreen(t("story_attack_detected_3", d))
            :addReply(Comms:newReply(t("story_attack_detected_3_response"), function()
                return Comms:newScreen(t("story_attack_detected_4", fortress:getCallSign(), fortress:getSectorName()))
                :addReply(Comms:newReply(t("story_attack_detected_4_response"), function()
                    Tools:endStoryComms()
                    return Comms:newScreen(t("story_attack_detected_5"))
                end))
            end))
        end))
    end))

    Tools:storyComms(hq, player, comms)
end)