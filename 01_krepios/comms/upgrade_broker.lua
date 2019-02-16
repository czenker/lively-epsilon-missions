local t = My.Translator.translate

My = My or {}
My.Comms = My.Comms or {}


My.Comms.UpgradeBroker = Comms:upgradeBrokerFactory({
    -- the label that leads to these commands
    label = t("comms_upgrade_broker_label"),

    mainScreen = function(screen, comms_target, comms_source, info)
        if Util.size(info.upgrades) == 0 then
            screen:addText(t("comms_upgrade_broker_main_no_upgrades"))
        else
            screen:addText(t("comms_upgrade_broker_main_upgrades") .. "\n\n")
            for _, conf in pairs(info.upgrades) do
                local upgrade = conf.upgrade
                local name = upgrade:getName()
                screen:addText(" * " .. name .. "\n")
                screen:addReply(Comms:newReply(name, conf.link))
            end
        end
        screen:addReply(Comms:newReply(t("generic_button_back")))
    end,
    detailScreen = function(screen, comms_target, comms_source, info)
        local upgrade = info.upgrade
        screen:addText(upgrade:getName() .. "\n\n")
        local description = upgrade:getDescription(comms_source)
        if isString(description) and description ~= "" then
            screen:addText(description .. "\n\n")
        end
        if not info.isAffordable then
            screen:addText(t("comms_upgrade_broker_detail_not_affordable", info.price))
        elseif not comms_source:isDocked(comms_target) then
            if info.price > 0 then
                screen:addText(t("comms_upgrade_broker_detail_not_docked", info.price))
            else
                screen:addText(t("comms_upgrade_broker_detail_not_docked_free"))
            end
        else
            if info.price > 0 then
                screen:addText(t("comms_upgrade_broker_detail_installable", info.price))
            else
                screen:addText(t("comms_upgrade_broker_detail_installable_free"))
            end
            screen:addReply(
                Comms:newReply(t("comms_upgrade_broker_detail_install_label"), info.linkInstall)
            )
        end

        screen:addReply(Comms:newReply(t("generic_button_back"), info.linkToMainScreen))
    end,
    installScreen = function(screen, comms_target, comms_source, info)
        local upgrade = info.upgrade
        screen:addText(upgrade:getInstallMessage(comms_source) or (t("comms_upgrade_broker_install_confirm", upgrade:getName())))
        screen:addReply(Comms:newReply(t("generic_button_back")))

        return true
    end,
    displayCondition = function(station, player)
        return not station:hasTag("mute") and not station:isEnemy(player)
    end,
})
