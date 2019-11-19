My = My or {}
My.World = My.World or {}

-- all inhabitant stations
My.World.stations = {}

-- all stations that are not inhibited and basically serve as battlefields
My.World.abandonedStations = {}

-- all nebulas in the world
My.World.nebulas = {}

My.World.planet = nil

My.World.drops = {}
My.World.getDrops = function(self)
    local drops = {}
    for _, drop in pairs(My.World.drops) do
        if drop:isValid() then
            table.insert(drops, drop)
        end
    end
    return drops
end

My.World.shipGraveyards = {}

-- the player :)
My.World.player = nil

-- the fortress that serves as last stand against the enemy
My.World.fortress = nil

-- the headquarter of the sector
My.World.hq = nil

-- TODO
My.Wormhole = nil

-- TODO
My.World.colonel = nil

My.World.allStationsDestroyed = function()
    for _, station in pairs(My.World.stations) do
        if station:isValid() then return false end
    end
    return true
end

My.World.personsWhoLeftTheSector = {}