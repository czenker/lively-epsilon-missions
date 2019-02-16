-- the station where colonel lives.
-- not necessary for story, but as Comms Source

My.World.colonel = nil

local StationTemplate = function()
    local station = My.SpaceStation("Huge Station", "Human Navy"):
    setCanBeDestroyed(false)

    return station
end

My.EventHandler:register("onWorldCreation", function()
    My.World.colonel = StationTemplate():setPosition(-500000, 0):setCallSign(My.Config.colonel:getFormalName())
    Station:withCrew(My.World.colonel, { colonel = My.Config.colonel})
end)

My.EventHandler:register("onAttackersDetection", function()
    Cron.regular(function(self)
        if distance(My.World.player, My.World.colonel) < 10000 then
            Cron.abort(self)
            My.EventHandler:fire("onEvacComplete")
        end
    end, 1)
end)