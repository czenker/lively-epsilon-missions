require "lively_epsilon/init"
require "01_krepios/names/init"

math.randomseed(os.time())

local examples = function(title, func)
    print(title)
    print(string.rep("=", title:len()))
    for i=1,20 do
        print("  * " .. func())
    end
    print("")
end

examples("Example Human Names", function() return Person:newHuman():getFormalName() end)
examples("Example Human Scientist Names", function() return Person:newHumanScientist():getFormalName() end)
examples("Example Civilian Ship Names", My.civilianShipName)
examples("Example Civilian Station Names", My.civilianStationName)
examples("Example Asteroid Names", My.asteroidName)
examples("Example Miner Names", My.minerName)
examples("Example Mining Station Names", My.miningStationName)
examples("Example Science Station Names", My.scienceStationName)
examples("Example Metal Band Names", My.metalBandName)
examples("Example Nebula Names", My.nebulaName)
examples("Example Pirate Station Names", My.pirateStationName)
examples("Example Pirate Ship Names", My.pirateShipName)
examples("Example Sector Names", My.sectorName)
