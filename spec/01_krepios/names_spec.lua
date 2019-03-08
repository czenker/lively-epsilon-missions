insulate("01 Krepios Names", function()

    require "lively_epsilon.init"
    require "lively_epsilon.spec.mocks"
    require "01_krepios.init"
    require "01_krepios.names.init"
    require "lively_epsilon.spec.asserts"

    for thing, func in pairs({
        ["Civilian Ship Names"] = My.civilianShipName,
        ["Civilian Station Names"] = My.civilianStationName,
        ["Asteroid Names"] = My.asteroidName,
        ["Miner Names"] = My.minerName,
        ["Mining Station Names"] = My.miningStationName,
        ["Science Station Names"] = My.scienceStationName,
        ["Metal Band Names"] = My.metalBandName,
        ["Nebula Names"] = My.nebulaName,
        ["Pirate Station Names"] = My.pirateStationName,
        ["Pirate Ship Names"] = My.pirateShipName,
        ["Sector Names"] = My.sectorName,
    }) do
        it("does not generate duplicate " .. thing, function()
            -- the birthday paradox makes collisions more likely than you would think
            local names = {}

            for _=1,500 do
                local name = func()
                names[name] = (names[name] or 0) + 1
            end

            for name, count in pairs(names) do
                assert.is_same(1, count, "the name " .. name .. " should occur at most once")
            end
        end)
    end

    for thing, func in pairs({
        ["Human Names"] = Person.newHuman,
        ["Human Scientist Names"] = Person.newHumanScientist,
    }) do
        it("does not generate duplicate " .. thing, function()
            -- the birthday paradox makes collisions more likely than you would think
            local names = {}

            for _=1,500 do
                local name = func():getFormalName()
                names[name] = (names[name] or 0) + 1
            end

            for name, count in pairs(names) do
                assert.is_same(1, count, "the name " .. name .. " should occur at most once")
            end
        end)
    end
end)