-- Name: Krepios
-- Description: The player crew finds itself in a mining colony far away from any civilization.
--- Recommended to be played with 20u scanner range.
-- Type: Mission

-- ----------------------------
--
-- GM: Configure your game here
--
-- ----------------------------

_G.LivelyEpsilonConfig = {
    useAnsi = true,
    logLevel = "DEBUG",
    logTime = true,
}

require "lively_epsilon/init.lua"

_G.My = {}

require "01_krepios/names/languages/esperantish.lua"
require "01_krepios/names/languages/english.lua"
require "01_krepios/names/languages/generic.lua"
require "01_krepios/names/languages/greek.lua"
require "01_krepios/names/languages/human.lua"

require "01_krepios/names/band.lua"
require "01_krepios/names/person.lua"
require "01_krepios/names/places.lua"
require "01_krepios/names/ships.lua"


My.Config = {
    -- the orientation of the asteroid field
    avgAngle = math.random(0,360),
    segment = 60,
    avgDistance = 200000,
    width = 40000,
    avgAsteroidDistance = 2000,

    -- the colonel that gave the crew the task to fly to the SMC main station
    colonel = Person:byName("John Doe"),

    -- the name of the commander of the SMC main station
    commander = Person:byName("Wright Hartman"),
    playerShipName = "LC Libell",

    -- there is this one metal band that everyone loves
    metalBandName = My.metalBandName(),
}

require "01_krepios/init.lua"

function init()
    local t = My.Translator.translate


    Translator:printInspection(My.Translator)

    My.EventHandler:fire("onWorldCreation")
    My.EventHandler:fire("onStart")

    -- --------------------------
    --
    -- offer upgrades on stations
    --
    -- --------------------------

    local upgrades = {}
    for id, upgrade in pairs(My.Upgrades) do
        if Generic:hasTags(upgrade) and upgrade:hasTag("freely-sold") then
            upgrades[id] = upgrade
        end
    end
    upgrades = Util.randomSort(upgrades)

    for i, upgrade in pairs(upgrades) do
        if i%4 == 0 then
            My.World.hq:addUpgrade(upgrade)
        elseif i%4 == 1 then
            My.World.miningStation1:addUpgrade(upgrade)
        elseif i%4 == 2 then
            My.World.miningStation2:addUpgrade(upgrade)
        else
            My.World.miningStation3:addUpgrade(upgrade)
        end
    end

    Menu:addGmMenuItem(Menu:newItem("Spawn Attackers", function()
        My.EventHandler:fire("onAttackersSpawn")
    end))
    Menu:addGmMenuItem(Menu:newItem("Reward Laser Refit", function()
        My.EventHandler:fire("onLaserRefitReward")
    end))
    Menu:addGmMenuItem(Menu:newItem("Reward Power Presets", function()
        My.EventHandler:fire("onPowerPresetsReward")
    end))

    Menu:addGmMenuItem(Menu:newItem("Stations", function()
        local menu = Menu:new()

        local stations = {}

        for _,station in pairs(My.World.stations) do
            if station:isValid() then table.insert(stations, station) end
        end
        local fortress = My.World.fortress
        if fortress:isValid() then table.insert(stations, fortress) end

        table.sort(stations, function(a, b)
            if a:isValid() then a = a:getCallSign() else a = "" end
            if b:isValid() then b = b:getCallSign() else b = "" end
            return a < b
        end)

        for i,station in ipairs(stations) do
            menu:addItem(Menu:newItem(station:getCallSign(), function()
                return f(
                        "%s (%s: %s)\n---------------------\n%s",
                        station:getCallSign(),
                        t("player_science_sector"),
                        station:getSectorName(),
                        station:getDescription("simple")
                )
            end, i))
        end

        return menu
    end))
    --
    --My.Simulations.HelmsEvasion:add()
    --My.Simulations.HelmsManeuver:add()
end

function update(delta)
    Cron.tick(delta)
end
