local t = My.Translator.translate

local shuffleReplies = function(screen, replies)
    for _, reply in pairs(Util.randomSort(replies)) do
        screen:addReply(reply)
    end
end

My.EventHandler:register("onStart", function()
    local hq = My.Commander:getLocation()
    local player = My.World.player
    local commanderPerson = My.Commander:getPerson()
    local colonelPerson = My.Config.colonel

    local startReputation = 100
    local reputationPenalty = 20

    local helloWorldComms5 = function(badAnswer)
        return function()
            local screen = Comms:newScreen()
            if badAnswer then
                startReputation = startReputation - reputationPenalty
                screen:addText(t("story_welcome_5_bad"))
            else
                screen:addText(t("story_welcome_5_good"))
            end

            screen:addText("\n\n")
            screen:addText(t("story_welcome_5"))

            player:setReputationPoints(startReputation)
            Tools:endStoryComms()

            return screen
        end
    end
    local helloWorldComms4 = function(badAnswer)
        return function()
            local screen = Comms:newScreen()
            if badAnswer then
                startReputation = startReputation - reputationPenalty
                screen:addText(t("story_welcome_4_bad"))
            else
                screen:addText(t("story_welcome_4_good"))
            end

            screen:addText("\n\n")
            screen:addText(t("story_welcome_4"))
            shuffleReplies(screen, {
                Comms:newReply(t("story_welcome_4_response_good"), helloWorldComms5(false)),
                Comms:newReply(t("story_welcome_4_response_bad"), helloWorldComms5(true))
            })
            return screen
        end
    end
    local helloWorldComms3 = function(badAnswer)
        return function()
            local screen = Comms:newScreen()
            if badAnswer then
                startReputation = startReputation - reputationPenalty
                screen:addText(t("story_welcome_3_bad"))
            else
                screen:addText(t("story_welcome_3_good"))
            end

            screen:addText("\n\n")
            screen:addText(t("story_welcome_3"))
            shuffleReplies(screen, {
                Comms:newReply(t("story_welcome_3_response_good"), helloWorldComms4(false)),
                Comms:newReply(t("story_welcome_3_response_bad"), helloWorldComms4(true)),
            })
            return screen
        end
    end
    local helloWorldComms2 = function(badAnswer)
        return function()
            local screen = Comms:newScreen()
            if badAnswer then
                startReputation = startReputation - reputationPenalty
                screen:addText(t("story_welcome_2_bad", colonelPerson))
            else
                screen:addText(t("story_welcome_2_good"))
            end

            screen:addText("\n\n")
            screen:addText(t("story_welcome_2", colonelPerson))
            shuffleReplies(screen, {
                Comms:newReply(t("story_welcome_2_response_good"), helloWorldComms3(false)),
                Comms:newReply(t("story_welcome_2_response_bad", colonelPerson), helloWorldComms3(true)),
            })
            return screen
        end
    end
    local helloWorldComms1 = function()
        local screen = Comms:newScreen(t("story_welcome_1", commanderPerson, colonelPerson))
        shuffleReplies(screen, {
            Comms:newReply(t("story_welcome_1_response_good"), helloWorldComms2(false)),
            Comms:newReply(t("story_welcome_1_response_bad"), helloWorldComms2(true)),
        })
        return screen
    end

    Tools:storyComms(hq, player, helloWorldComms1())

end, 99)
