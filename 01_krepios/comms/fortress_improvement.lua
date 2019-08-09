local t = My.Translator.translate

My = My or {}
My.Comms = My.Comms or {}

My.Comms.FortressImprovement = (function()
    local menu, confirm

    menu = function(comms_target, comms_source)
        local screen = Comms:newScreen(t("fortress_improvement_what_next"))

        local improvements = {}
        for _,improvement in pairs(My.World.fortress:getImprovements()) do
            if not isFunction(improvement.canBeChosen) or improvement.canBeChosen(comms_target) == true then
                table.insert(improvements, improvement)
            end
        end

        for _,improvement in pairs(improvements) do
            screen:addReply(Comms:newReply(improvement.name, confirm(improvement)))
        end

        screen:addReply(Comms:newReply(t("generic_button_back")))

        return screen
    end

    confirm = function(improvement)
        return function(comms_target, comms_source)
            local screen = Comms:newScreen()
            My.World.fortress:improve(improvement)

            local msg = t("fortress_improvement_confirmation")
            if isFunction(improvement.confirmationMessage) then
                msg = improvement.confirmationMessage()
            elseif isString(improvement.confirmationMessage) then
                msg = improvement.confirmationMessage
            end

            screen:addText(msg)
            screen:addReply(Comms:newReply(t("generic_button_back")))

            return screen
        end
    end

    return Comms:newReply(t("fortress_improvement_label"), menu, function() return not My.World.fortress:isImproving() end)
end)()