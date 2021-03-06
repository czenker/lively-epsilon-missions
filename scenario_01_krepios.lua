-- Name: Krepios
-- Description: The player crew finds itself in a mining colony far away from any civilization.
--- Recommended to be played with 20u scanner range.
-- Type: Mission
-- Variation[English]: english translation
-- Variation[German]: Deutsche Uebersetzung
-- Variation[English,Sandbox]: Sandbox Mode - the game has no defined end. English Translation
-- Variation[German,Sandbox]: Sandkastenmodus - das Spiel hat kein definiertes Ende. Deutsche Uebersetzung

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

require "names/init.lua"

My.Config = {
    -- the orientation of the asteroid field
    avgAngle = math.random(0,360),
    segment = 60,
    avgDistance = 200000,
    width = 40000,
    avgAsteroidDistance = 1500,

    maximumSideMissions = 3,

    -- the colonel that gave the crew the task to fly to the SMC main station
    colonel = Person:byName("John Doe"),

    -- the name of the commander of the SMC main station
    commander = Person:byName("Wright Hartman"),
    playerShipName = "LC Libell",

    -- there is this one metal band that everyone loves
    metalBandName = My.metalBandName(),

    -- surrounding sectors
    sectorNames = {
        My.sectorName(),
        My.sectorName(),
        My.sectorName(),
    },

    -- if this is a sandboxed game where there is no story twist
    sandbox = false,
}

require "01_krepios/init.lua"

function init()
    local t = My.Translator.translate

    local scenario = getScenarioVariation() or ""
    if scenario:match('Sandbox') ~= nil then
        My.Config.sandbox = true
    end

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
    --
    --My.Simulations.HelmsEvasion:add()
    --My.Simulations.HelmsManeuver:add()
end

function update(delta)
    Cron.tick(delta)
end
