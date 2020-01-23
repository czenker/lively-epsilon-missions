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
        screen:addText(welcomeString .. "\n")
        local upgrade = station:getCurrentUpgrade()
        if upgrade then
            screen:addText(t("shipyard_workshop_comms_current_research", upgrade:getName()))
            screen:addText(string.format("\n\nCurrently researching: %s (%0.1f%%)", upgrade:getName(), station:getCurrentUpgradeProgress() * 100))
            screen:addText(string.format("\nPrice: %0.2fRP", upgrade:getPrice()))
            screen:addText(string.format("\nFunding: %0.2fRP", station:getCurrentFunding()))

            screen:addReply(Comms:newReply("Invest", investMenu))
        else
            screen:addText(t("shipyard_workshop_comms_current_research_none"))
        end

        if Util.size(station:getUpgradeOptions()) > 0 then
            screen:addReply(Comms:newReply("Change", changeMenu))
        end

        screen:addReply(Comms:newReply(t("generic_button_back")))
        return screen
    end

    investMenu = function(station, comms_source)
        local screen = Comms:newScreen()
        local upgrade = station:getCurrentUpgrade()
        screen:addText(string.format("TODO: Currently researching: %s (%0.1f%%)", upgrade:getName(), station:getCurrentUpgradeProgress() * 100))

        local playerRp = comms_source:getReputationPoints()
        if playerRp < steps[1] then
            screen:addReply(Comms:newReply("We are too poor", menu))
        else
            for _, amount in pairs(steps) do
                if playerRp >= amount then
                    screen:addReply(Comms:newReply(string.format("Invest %0.0fRP", amount), investSubmitMenu(amount)))
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
            return menu(station, comms_source, "Thank you")
        end
    end

    changeMenu = function(station, comms_source)
        local screen = Comms:newScreen()
        local upgrades = station:getUpgradeOptions()

        screen:addText("I also could work on\n")
        for _, upgrade in pairs(upgrades) do
            screen:addText(string.format("* %s\n", upgrade:getName()))

            screen:addReply(Comms:newReply("Tell me about " .. upgrade:getName(), changeInfoMenu(upgrade)))
        end
        screen:addReply(Comms:newReply(t("generic_button_back"), menu))

        return screen
    end

    changeInfoMenu = function(upgrade)
        return function(station, comms_source)
            local screen = Comms:newScreen()
            screen:addText(upgrade:getName() .. "\n")
            screen:addText(upgrade:getDescription(comms_source) .. "\n\n")

            if comms_source:getReputationPoints() >= changePrice then
                screen:addReply(Comms:newReply(string.format("Change for %0.0fRP", changePrice), changeSubmitMenu(upgrade)))
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

            return menu(station, comms_source, "OK")
        end
    end

    return Comms:newReply(function() return My.World.shipyard.getWorkshopName() end, menu)
end)()