local t = My.Translator.translate

My = My or {}
My.SideMissions = My.SideMissions or {}

My.SideMissions.TransportHuman = function(from, to)
    local person = Person:newHuman()
    local payment = My.SideMissions.paymentPerDistance(distance(from, to))

    local stories = {}

    if to:hasTag("mining") then
        table.insert(stories, t("side_mission_transport_human_description_technician", person, to:getCallSign(), payment))
        table.insert(stories, t("side_mission_transport_human_description_chemist", person, to:getCallSign(), payment))
        table.insert(stories, t("side_mission_transport_human_description_physician", person, to:getCallSign(), payment))
    end

    if to:hasTag("science") then
        table.insert(stories, t("side_mission_transport_human_description_scientist", person, to:getCallSign(), payment))
    end

    table.insert(stories, t("side_mission_transport_human_description_ceo", person, to:getCallSign(), payment))
    table.insert(stories, t("side_mission_transport_human_description", person, to:getCallSign(), payment))

    local description = Util.random(stories)

    local mission = Missions:transportToken(from, to, {
        onAccept = function(self)
            local hint = t("side_mission_transport_human_accept_hint", from:getCallSign(), person)
            self:setHint(hint)
            self:getPlayer():addToShipLog(hint, "255,127,0")
        end,
        onLoad = function(self)
            local hint = t("side_mission_transport_human_load_hint", to:getCallSign(), person)
            self:setHint(hint)
            self:getPlayer():addToShipLog(hint, "255,127,0")
        end,
        onSuccess = function(self)
            logInfo("Mission " .. self:getTitle() .. " successful.")
            self:getPlayer():addToShipLog(t("generic_mission_successful", self:getTitle()), "255,127,0")
            self:getMissionBroker():sendCommsMessage(self:getPlayer(), t("side_mission_transport_human_success", to:getCallSign(), payment))
            self:getPlayer():addReputationPoints(payment)
        end,
        onFailure = function(self)
            logInfo("Mission " .. self:getTitle() .. " failed.")
            if self:getPlayer():isValid() then
                self:getPlayer():addToShipLog(t("generic_mission_failed", self:getTitle()), "255,127,0")
            end
        end,
    })
    Mission:withBroker(mission,
        t("side_mission_transport_human", to:getCallSign()), {
        description = description,
        acceptMessage = t("side_mission_transport_human_accept"),
    })

    return mission
end