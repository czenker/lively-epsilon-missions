local t = My.Translator.translate

My = My or {}
My.SideMissions = My.SideMissions or {}

My.SideMissions.ScanCrystal = function(station)
    if not station:hasTag("shipyard") then return end
    local nebula = station.inNebula
    if not nebula then return end

    local complexity = math.random(2,4)
    local depth = 6 - complexity
    local payment = (math.random() * 0.4 + 0.8) * 30
    local mission

    local person = station:getCrewAtPosition("tinkerer")

    mission = Missions:scan(function()
        local x,y = nebula:getRandomPosition()
        return My.Artifact("artifact1"):
        setPosition(x, y):
        setCallSign(t("side_mission_scan_crystal_artifact_name")):
        setScannedDescription(t("side_mission_scan_crystal_artifact_description")):
        setScanningParameters(complexity, depth)
    end, {
        scan = "simple",
        onStart = function(self)
            mission:setHint(t("side_mission_scan_crystal_hint", self:getTargets()[1]:getSectorName()))
        end,

        onSuccess = function(self)
            self:getMissionBroker():sendCommsMessage(self:getPlayer(), t("side_mission_scan_crystal_success", person, payment))
            self:getPlayer():addReputationPoints(payment)
            station:addFunding(payment / 2)
        end,
        onEnd = function(self)
            for _, artifact in pairs(self:getTargets()) do
                if artifact:isValid() then artifact:destroy() end
            end
        end,
    })

    Mission:withBroker(mission, t("side_mission_scan_crystal"), {
        description = t("side_mission_scan_crystal_description", person, nebula:getName(), payment),
        acceptMessage = t("side_mission_scan_crystal_accept"),
    })

    return mission
end