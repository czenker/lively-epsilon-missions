local t = My.Translator.translate

local function StationTemplate()
    local station = My.SpaceStation("Medium Station", "Abandoned")
    station:addTag("mute")

    return station
end

local onSearch = function(station, player)
    if station.wasSearched == true then return end

    station.wasSearched = true

    local version = math.random(1, 4)

    if version == 1 then
        -- good: share energy
        station:setSharesEnergyWithDocked(true)
        station:setRadarSignatureInfo(station:getRadarSignatureGravity(), station:getRadarSignatureElectrical() + 0.1, station:getRadarSignatureBiological())

        station:setHailText(function(self, player)
            if player:isDocked(self) then
                return t("station_abandoned_good_power_hail")
            else
                return t("generic_comms_station_static")
            end
        end)

        return Comms:newScreen(t("station_abandoned_good_power"))
    elseif version == 2 then
        -- good: repair
        station:setRepairDocked(true)

        station:setHailText(function(self, player)
            if player:isDocked(self) then
                return t("station_abandoned_good_repair_hail")
            else
                return t("generic_comms_station_static")
            end
        end)

        return Comms:newScreen(t("station_abandoned_good_repair"))
    elseif version == 3 then
        -- bad: energy spike
        for i=0,3 do
            local x, y = Util.onVector(station, player, math.random())
            Cron.once(function()
                local x, y = Util.onVector(station, player, math.random())
                local system = Util.random({"reactor", "beamweapons", "missilesystem", "maneuver", "impulse", "warp", "jumpdrive", "frontshield", "rearshield"})
                ElectricExplosionEffect():setPosition(x, y):setSize(60 * math.random() + 60)
                player:takeDamage(20, "emp", x, y)
                player:setEnergyLevel(player:getEnergyLevel() / 2 - 50)

                player:setSystemHealth(system, player:getSystemHealth(system) - 0.4)
            end, i * 0.1)
            return Comms:newScreen(t("station_abandoned_bad_power"))
        end
    else
        return Comms:newScreen(t("station_abandoned_enter_empty"))
    end
end

My.EventHandler:register("onWorldCreation", function()
    local divAngle = 360 * 60000 / 2 / math.pi / My.Config.avgDistance

    local minAngle = My.Config.avgAngle - divAngle

    local randomPosition = function()
        local angle = math.random() * 2 * divAngle + minAngle
        local distance = My.Config.avgDistance - My.Config.width * 0.75 + math.random() * My.Config.width * 1.5

        return vectorFromAngle(angle, distance)
    end

    My.World.abandonedStations = {}

    for i=1,3 do
        local x, y = My.World.Helper.tryMinDistance(randomPosition, function(thing)
            return isEeStation(thing) or isEeArtifact(thing)
        end, 20000)
        My.World.Helper.eraseAsteroidsAround(x, y, 5000)
        local station = StationTemplate():setPosition(x, y)
        station:setCallSign(My.miningStationName())

        station:
        setRadarSignatureInfo(station:getRadarSignatureGravity(), 0, 0):
        setShields(0):
        setShieldsMax(0):
        setRepairDocked(false):
        setSharesEnergyWithDocked(false)
        
        station:setScannedDescription(t("station_abandoned_description"))

        station:setHailText(function(self, player)
            if player:isDocked(self) then
                if self.wasSearched == true then
                    return t("station_abandoned_hail_docked_searched")
                else
                    return t("station_abandoned_hail_docked")
                end
            else
                return t("generic_comms_station_static")
            end
        end)
        station:addComms(Comms:newReply(t("station_abandoned_enter"), onSearch , function(self, player) return station.wasSearched ~= true and player:isDocked(self) end))
        station:addComms(Comms:newReply(t("station_abandoned_leave"), function() return Comms:newScreen(t("station_abandoned_leave")) end, function(self, player) return station.wasSearched ~= true and player:isDocked(self) end))

        table.insert(My.World.abandonedStations, station)
    end
end, 50)
