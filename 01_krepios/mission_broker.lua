-- --------------------------
--
-- Offer missions on stations
--
-- --------------------------

local maxMissions = 3

My.EventHandler:register("onStart", function()

    -- the numbers of missions to add to the station in the next tick
    local missionsNextTick = {}

    for _, station in pairs(My.World.stations) do
        Station:withMissionBroker(station)
        missionsNextTick[station] = maxMissions
    end

    Cron.regular("mission_refill", function()
        for station, numberMissions in pairs(missionsNextTick) do
            if station:isValid() and Station:hasMissionBroker(station) then
                if math.random(0,2) == 0 then
                    local mission = Util.random(station:getMissions())
                    if Mission:isMission(mission) then
                        logDebug("Removing random Mission " .. mission:getTitle() .. " from " .. station:getCallSign())
                        station:removeMission(mission)
                        numberMissions = numberMissions + 1
                    end
                end

                if numberMissions > 0 then
                    logDebug(string.format("Refilling %d missions for %s", numberMissions, station:getCallSign()))
                    -- refill new missions
                    local nrFightingMissions = 0
                    local nrTransportMissions = 0
                    for _, mission in pairs(station:getMissions()) do
                        if Generic:hasTags(mission) and mission:hasTag("transport") then
                            nrTransportMissions = nrTransportMissions + 1
                        elseif Generic:hasTags(mission) and mission:hasTag("fighting") then
                            nrFightingMissions = nrFightingMissions + 1
                        end
                    end
                    for i=1,numberMissions do
                        local mission
                        if nrFightingMissions < nrTransportMissions or (nrFightingMissions == nrTransportMissions and math.random(0,1) == 0) then
                            mission = My.MissionGenerator.randomFightingMission(station)
                            if mission ~= nil then
                                nrFightingMissions = nrFightingMissions + 1
                            end
                        end
                        if mission == nil then
                            nrTransportMissions = nrTransportMissions + 1
                            mission = My.MissionGenerator.randomTransportMission(station)
                        end
                        if mission ~= nil then
                            station:addMission(mission)
                        else
                            logWarning("Could not refill a mission for " .. station:getCallSign())
                        end
                    end
                end

                -- count how many missions to add in the next tick
                missionsNextTick[station] = math.max(0, maxMissions - Util.size(station:getMissions()))
            end
        end
    end, 180)

end)