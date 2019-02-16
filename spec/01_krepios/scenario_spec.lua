insulate("01 Krepios", function()

    require "lively_epsilon.spec.mocks"
    require "lively_epsilon.spec.universe"
    require "lively_epsilon.spec.asserts"

    insulate("Scenario", function()
        withUniverse(function()
            it("the scenario loads up", function()
                local originalRequire = require
                _G.require = function(modname)
                    if type(modname) == "string" then
                        modname = modname:gsub("%.lua$", "")
                        originalRequire(modname)
                    end
                end
                require "scenario_01_krepios.lua"
                init()
            end)

            it("starts running", function()
                for i=1,3000 do
                    update(0.1)
                end
            end)

            it(function()
                Tools:endStoryComms()
                My.EventHandler:fire("onFirstMoneyEarned")
                My.EventHandler:fire("onLaserRefitReward")
                My.EventHandler:fire("onPowerPresetsReward")
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
end)