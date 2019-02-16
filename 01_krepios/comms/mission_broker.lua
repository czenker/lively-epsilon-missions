local t = My.Translator.translate

My = My or {}
My.Comms = My.Comms or {}

My.Comms.MissionBroker = Comms:missionBrokerFactory({
    -- the label that leads to these commands
    label = t("comms_mission_broker_label"),

    mainScreen = function(screen, comms_target, comms_source, config)
        if Util.size(config.missions) == 0 then
            screen:addText(t("comms_mission_broker_main_no_missions"))
        else
            screen:addText(t("comms_mission_broker_main_missions") .. "\n\n")
            for _, conf in pairs(config.missions) do
                local mission = conf.mission
                local title = mission:getTitle()
                screen:addText(" * " .. title .. "\n")
                screen:addReply(Comms:newReply(title, conf.link))
            end
        end
        screen:addReply(Comms:newReply(t("generic_button_back")))
    end,
    detailScreen = function(screen, comms_target, comms_source, config)
        local mission = config.mission
        screen:addText(mission:getTitle())
        local description = mission:getDescription()
        if isString(description) and description ~= "" then
            screen:addText("\n\n" .. description .. "\n\n")
        end
        if mission:canBeAccepted() then
            screen:addText(t("comms_mission_broker_detail_acceptable"))
            screen:addReply(
                Comms:newReply(t("comms_mission_broker_detail_accept_label"), config.linkAccept)
            )
        elseif isString(config.canBeAcceptedMessage) then
            screen:addText(config.canBeAcceptedMessage)
        end

        screen:addReply(Comms:newReply(t("generic_button_back"), config.linkToMainScreen))
    end,
    acceptScreen = function(screen, comms_target, comms_source, config)
        local mission = config.mission
        screen:addText(mission.getAcceptMessage() or t("comms_mission_broker_accept_confirm"))
        screen:addReply(Comms:newReply(t("generic_button_back")))

        return true
    end,
    displayCondition = function(station, player)
        return not station:hasTag("mute") and not station:isEnemy(player)
    end,
})
