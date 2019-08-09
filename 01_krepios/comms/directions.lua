Comms = Comms or {}

local t = My.Translator.translate

local mainMenu, detail

local isStationValid = function(station, ship, player)
    return station:isValid() and not station:isEnemy(ship) and not station:isEnemy(player)
end

local fuzzDistance = function(distance) return Util.round(distance, 2) end
local fuzzHeading = function(heading) return Util.round(heading, 20) end

mainMenu = function(ship, player)
    local screen = Comms:newScreen(t("comms_directions_main"))

    local targets = {}
    for _, station in pairs(My.World.stations) do
        if station:isValid() then
            table.insert(targets, station)
        end
    end

    table.sort(targets, function(a, b)
        if a:isValid() then a = a:getCallSign() else a = "" end
        if b:isValid() then b = b:getCallSign() else b = "" end
        return a < b
    end)

    for _,station in pairs(targets) do
        if isStationValid(station, ship, player) then
            screen:addReply(Comms:newReply(station:getCallSign(), detail(station)))
        end
    end

    screen:addReply(Comms:newReply(t("generic_button_back")))

    return screen
end

detail = function(station)
    return function(ship, player)
        local screen = Comms:newScreen()

        if isStationValid(station, ship, player) then
            local distance = distance(station, ship) / 1000
            if distance < 5 then
                screen:addText(t("comms_directions_detail_close"))
            else
                local heading = Util.heading(ship, station)
                screen:addText(t("comms_directions_detail", station:getCallSign(), station:getSectorName()))
                if ship:isFriendly(player) then
                    screen:addText("\n\n" .. t("comms_directions_detail_friendly", fuzzDistance(distance), fuzzHeading(heading)))
                end
            end
        else
            screen:addText(t("comms_directions_detail_error"))
        end
        screen:addReply(Comms:newReply(t("generic_button_back")))

        return screen
    end
end

Comms.directions = Comms:newReply(t("comms_directions_label"), mainMenu, function(comms_target, comms_source)
    return not comms_target:hasTag("mute") and not comms_target:isEnemy(comms_source)
end)