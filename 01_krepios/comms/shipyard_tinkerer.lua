local t = My.Translator.translate

My = My or {}
My.Comms = My.Comms or {}

local steps = {10, 25, 50, 100}
local changePrice = 50

My.Comms.ShipyardTinkerer = (function()
    local menu, investMenu, investSubmitMenu, changeMenu, changeInfoMenu, changeSubmitMenu

    menu = function(station, comms_source, welcomeString)
        welcomeString = welcomeString or t("shipyard_workshop_comms_hail", station:getCrewAtPosition("tinkerer"))
        local screen = Comms:newScreen()
        screen:addText(welcomeString .. "\n\n")
        local upgrade = station:getCurrentUpgrade()
        if upgrade then
            local text
            if station:getCurrentUpgradeProgress() < 0.2 then
                text = t("shipyard_workshop_comms_invest_hail_progress_0", upgrade:getName())
            elseif station:getCurrentUpgradeProgress() < 0.5 then
                text = t("shipyard_workshop_comms_invest_hail_progress_1", upgrade:getName())
            elseif station:getCurrentUpgradeProgress() < 0.8 then
                text = t("shipyard_workshop_comms_invest_hail_progress_2", upgrade:getName())
            else
                text = t("shipyard_workshop_comms_invest_hail_progress_3", upgrade:getName())
            end
            screen:addText(text .. " ")

            if station:getCurrentFunding() <= 0 then
                text = t("shipyard_workshop_comms_invest_hail_funding_0", upgrade:getName())
            elseif station:getCurrentFunding() < 50 then
                text = t("shipyard_workshop_comms_invest_hail_funding_1", upgrade:getName())
            elseif station:getCurrentFunding() < 100 then
                text = t("shipyard_workshop_comms_invest_hail_funding_2", upgrade:getName())
            else
                text = t("shipyard_workshop_comms_invest_hail_funding_3", upgrade:getName())
            end
            screen:addText(text)

            screen:addReply(Comms:newReply(t("shipyard_workshop_comms_invest"), investMenu))
        else
            screen:addText(t("shipyard_workshop_comms_current_research_none"))
        end

        if Util.size(station:getUpgradeOptions()) > 0 then
            screen:addReply(Comms:newReply(t("shipyard_workshop_comms_change"), changeMenu))
        end

        screen:addReply(Comms:newReply(t("generic_button_back")))
        return screen
    end

    investMenu = function(station, comms_source)
        local screen = Comms:newScreen()
        local upgrade = station:getCurrentUpgrade()
        local text
        if station:getCurrentUpgradeProgress() < 0.2 then
            text = t("shipyard_workshop_comms_invest_hail_progress_0", upgrade:getName())
        elseif station:getCurrentUpgradeProgress() < 0.5 then
            text = t("shipyard_workshop_comms_invest_hail_progress_1", upgrade:getName())
        elseif station:getCurrentUpgradeProgress() < 0.8 then
            text = t("shipyard_workshop_comms_invest_hail_progress_2", upgrade:getName())
        else
            text = t("shipyard_workshop_comms_invest_hail_progress_3", upgrade:getName())
        end
        text = text .. " " .. t("shipyard_workshop_comms_invest_hail")
        screen:addText(text .. " ")

        if station:getCurrentFunding() <= 0 then
            text = t("shipyard_workshop_comms_invest_hail_funding_0", upgrade:getName())
        elseif station:getCurrentFunding() < 50 then
            text = t("shipyard_workshop_comms_invest_hail_funding_1", upgrade:getName())
        elseif station:getCurrentFunding() < 100 then
            text = t("shipyard_workshop_comms_invest_hail_funding_2", upgrade:getName())
        else
            text = t("shipyard_workshop_comms_invest_hail_funding_3", upgrade:getName())
        end

        text = text .. "\n\n" .. t("shipyard_workshop_comms_invest_description") .. "\n\n"
        text = text .. upgrade:getDescription(comms_source)

        screen:addText(text)

        local playerRp = comms_source:getReputationPoints()
        if playerRp < steps[1] then
            screen:addReply(Comms:newReply(t("shipyard_workshop_comms_invest_poor"), menu))
        else
            for _, amount in pairs(steps) do
                if playerRp >= amount then
                    screen:addReply(Comms:newReply(string.format(t("shipyard_workshop_comms_invest_amount", amount)), investSubmitMenu(amount)))
                end
            end
            screen:addReply(Comms:newReply(t("generic_button_back"), menu))
        end
        return screen
    end

    investSubmitMenu = function(amount)
        return function(station, comms_source)
            comms_source:takeReputationPoints(amount)
            station:addFunding(amount)
            return menu(station, comms_source, t("shipyard_workshop_comms_invest_thanks"))
        end
    end

    changeMenu = function(station, comms_source)
        local screen = Comms:newScreen()
        local upgrades = station:getUpgradeOptions()

        screen:addText(t("shipyard_workshop_comms_change_hail") .. "\n\n")
        for _, upgrade in pairs(upgrades) do
            screen:addText(string.format("* %s\n", upgrade:getName()))

            screen:addReply(Comms:newReply(t("shipyard_workshop_comms_change_response", upgrade:getName()), changeInfoMenu(upgrade)))
        end
        screen:addReply(Comms:newReply(t("generic_button_back"), menu))

        return screen
    end

    changeInfoMenu = function(upgrade)
        return function(station, comms_source)
            local screen = Comms:newScreen()
            screen:addText(upgrade:getName() .. "\n\n")
            screen:addText(upgrade:getDescription(comms_source) .. "\n\n")
            screen:addText(t("shipyard_workshop_comms_change_price", changePrice))

            if comms_source:getReputationPoints() >= changePrice then
                screen:addReply(Comms:newReply(t("shipyard_workshop_comms_change_confirm", changePrice), changeSubmitMenu(upgrade)))
            end
            screen:addReply(Comms:newReply(t("generic_button_back"), changeMenu))

            return screen
        end
    end

    changeSubmitMenu = function(upgrade)
        return function(station, comms_source)
            station:prioritizeUpgrade(upgrade)
            comms_source:takeReputationPoints(changePrice)
            station:addFunding(changePrice / 2)

            return menu(station, comms_source, t("shipyard_workshop_comms_change_ok", upgrade:getName()))
        end
    end

    return Comms:newReply(function() return My.World.shipyard.getWorkshopName() end, menu)
end)()