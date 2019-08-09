Comms = Comms or {}

local t = My.Translator.translate

local mainMenu = function(ship, player)
    local msg
    if isFunction(ship.whoAreYouResponse) then
        msg = ship:whoAreYouResponse()
    else
        msg = ship.whoAreYouResponse
    end

    local screen = Comms:newScreen(msg)

    screen:addReply(Comms:newReply(t("generic_button_back")))

    return screen
end

Comms.whoAreYou = Comms:newReply(t("comms_who_are_you_label"), mainMenu, function(comms_target, comms_source)
    return not comms_target:hasTag("mute") and not comms_target:isEnemy(comms_source) and comms_target.whoAreYouResponse ~= nil
end)