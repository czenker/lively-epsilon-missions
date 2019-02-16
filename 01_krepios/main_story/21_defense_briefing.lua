local t = My.Translator.translate

local completed = false

My.EventHandler:register("onFortressManned", function()
    local fortress = My.World.fortress
    local player = My.World.player
    local commanderPerson = My.Commander:getPerson()
    local colonel = My.Config.colonel

    local dialog3Screen = function(initialText)
        local screen = Comms:newScreen(initialText .. "\n\n" .. t("story_defense_briefing_3", player:getCallSign()))

        screen:addReply(Comms:newReply(t("generic_button_back")))
        return screen
    end

    local dialog3Artillery = function()
        completed = true
        My.EventHandler:fire("onDefensePlanned", {
            spawnArtillery = true,
            spawnGunships = false,
        })
        return dialog3Screen(t("story_defense_briefing_3_artillery"))
    end

    local dialog3Gunship = function()
        completed = true
        My.EventHandler:fire("onDefensePlanned", {
            spawnArtillery = false,
            spawnGunships = true,
        })
        return dialog3Screen(t("story_defense_briefing_3_gunships"))
    end

    local dialog2 = function()
        local screen = Comms:newScreen(t("story_defense_briefing_2", colonel))
        screen:addReply(Comms:newReply(t("story_defense_briefing_2_response_artillery"), dialog3Artillery))
        screen:addReply(Comms:newReply(t("story_defense_briefing_2_response_gunship"), dialog3Gunship))

        return screen
    end

    local dialog1 = function()
        local screen = Comms:newScreen(t("story_defense_briefing_1", player:getCallSign()))
        screen:addReply(Comms:newReply(t("story_defense_briefing_1_response"), dialog2))

        return screen
    end

    local notDocked = function()
        local screen = Comms:newScreen(t("story_defense_briefing_not_docked", commanderPerson, fortress:getCallSign()))

        return screen
    end

    fortress:addComms(Comms:newReply(t("story_defense_briefing_label", commanderPerson), function()
        if player:isDocked(fortress) then
            return dialog1()
        else
            return notDocked()
        end
    end, function() return completed == false end))
end)

My.EventHandler:register("onDefensePlanned", function()
    local player = My.World.player
    -- the player could have lost crew members in a crew4rent mission
    if player:getRepairCrewCount() < 4 then
        player:setRepairCrewCount(4)
    end
end)