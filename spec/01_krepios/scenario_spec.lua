insulate("01 Krepios Scenario", function()

    require "lively_epsilon.spec.mocks"
    require "lively_epsilon.spec.universe"
    require "lively_epsilon.spec.asserts"

    it("Scenario loads up and runs", function()
        withUniverse(function()
            local originalRequire = require
            _G.require = function(modname)
                if type(modname) == "string" then
                    modname = modname:gsub("%.lua$", "")
                    originalRequire(modname)
                end
            end
            require "factionInfo.lua"
            require "scenario_01_krepios.lua"

            init()

            _G.require = originalRequire

            -- it should create a player
            assert.not_nil(My.World.player)

            -- it runs
            for i=1,3000 do
                update(0.1)
            end

            -- the main story can be run
            Tools:endStoryComms()
            My.EventHandler:fire("onFirstMoneyEarned")
            My.EventHandler:fire("onAttackersSpawn")
            My.EventHandler:fire("onAttackersDetection")
            Tools:endStoryComms()
            My.EventHandler:fire("onHQDestroyed")
            My.EventHandler:fire("onAllStationsDestroyed")
            My.EventHandler:fire("onClosingInToFortress")
            Tools:endStoryComms()
            My.EventHandler:fire("onFortressManned")
            My.EventHandler:fire("onDefensePlanned", {
                spawnArtillery = true,
                spawnGunships = true,
            })
            My.EventHandler:fire("onCommanderDead")
            Tools:endStoryComms()
            My.EventHandler:fire("onEvacComplete")
            Tools:endStoryComms()
            My.EventHandler:fire("onEnemiesDestroyed")
            Tools:endStoryComms()
        end)
    end)
end)