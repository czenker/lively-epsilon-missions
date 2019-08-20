local t = My.Translator.translate

My = My or {}
My.SideMissions = My.SideMissions or {}

local PickUp = function()
    local model
    local rnd = math.random(1,3)
    if rnd == 1 then model = "artifact1"
    elseif rnd == 2 then model = "artifact3"
    else model = "artifact5"
    end

    return My.Artifact(model):
    setCallSign(t("side_mission_gather_crystals_artifact_name")):
    setScannedDescription(t("side_mission_gather_crystals_artifact_description"))
end

My.SideMissions.GatherCrystals = function(station)
    if station.inNebula == nil then return end

    local nebula = station.inNebula
    local amount = math.random(3,7)

    local payment = My.SideMissions.paymentPerDistance((amount + 1) * 10000)

    local person = station:getCrewAtPosition("crystallographer")
    local mission
    local hint = function()
        local count = mission:countPickUps() or 0
        if count > 0 then
            return t("side_mission_gather_crystals_hint_gather", mission:countPickUps(), station:getCallSign())
        else
            return t("side_mission_gather_crystals_hint_return", station:getCallSign())
        end
    end

    mission = Missions:pickUp(
        function()
            local pickUps = {}
            for i=1,amount do
                local x,y = My.World.Helper.tryMinDistance(nebula.getRandomPosition, function(thing)
                    return isEeStation(thing) or isEeArtifact(thing)
                end, 3000)

                table.insert(pickUps, PickUp():setPosition(x,y))
            end
            return pickUps
        end,
        station, {
        onStart = function(self)
            local msg = hint()
            self:setHint(msg)
            self:getPlayer():addToShipLog(msg, "255,127,0")
        end,
        onPickUp = function(self)
            self:setHint(hint())
            self:getPlayer():addToShipLog(t("side_mission_gather_crystals_hint_ok"), "255,127,0")
        end,
        onSuccess = function(self)
            logInfo("Mission " .. self:getTitle() .. " successful.")
            self:getPlayer():addToShipLog(t("generic_mission_successful", self:getTitle()), "255,127,0")
            self:getPlayer():addReputationPoints(payment)
            station:sendCommsMessage(self:getPlayer(), t("side_mission_gather_crystals_success_comms", payment))
        end,
        onFailure = function(self)
            logInfo("Mission " .. self:getTitle() .. " failed.")
            if self:getPlayer():isValid() then
                self:getPlayer():addToShipLog(t("generic_mission_failed", self:getTitle()), "255,127,0")
            end
        end,
        onEnd = function(self)
            if isTable(self:getPickUps()) then
                for _,artifact in pairs(self:getPickUps()) do
                    if isEeObject(artifact) and artifact:isValid() then
                        artifact:destroy()
                    end
                end
            end
        end,
    })

    Mission:withBroker(mission, t("side_mission_gather_crystals", nebula:getName()), {
        description = t("side_mission_gather_crystals_description", person, amount, payment),
        acceptMessage = t("side_mission_gather_crystals_accept"),
    })

    return mission
end