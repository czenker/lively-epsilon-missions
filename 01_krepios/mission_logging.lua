local f = string.format
local t = My.Translator.translate

Mission:registerMissionStartListener(function(self, mission)
    if Mission:isBrokerMission(mission) then
        logInfo(f("Mission \"%s\" started", mission:getTitle()))
    end
end)
Mission:registerMissionSuccessListener(function(self, mission)
    if Mission:isBrokerMission(mission) then
        logInfo(f("Mission \"%s\" successful", mission:getTitle()))
        if Mission:isPlayerMission(mission) then
            if Mission:isPlayerMission(mission) and mission:getPlayer():isValid() then
                mission:getPlayer():addToShipLog(t("generic_mission_successful", mission:getTitle()), "255,127,0")
            end
        end
    end
end)
Mission:registerMissionFailureListener(function(self, mission)
    if Mission:isBrokerMission(mission) then
        logInfo(f("Mission \"%s\" failed", mission:getTitle()))
        if Mission:isPlayerMission(mission) then
            if Mission:isPlayerMission(mission) and mission:getPlayer():isValid() then
                mission:getPlayer():addToShipLog(t("generic_mission_failed", mission:getTitle()), "255,127,0")
            end
        end
    end
end)
