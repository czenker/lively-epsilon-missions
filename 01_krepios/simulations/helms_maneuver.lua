My = My or {}
My.Simulations = My.Simulations or {}

-- a simulation where Helms needs to fly a parcour quickly
My.Simulations.HelmsManeuver = My.Simulations.HelmsManeuver or {}

local id = "helms-maneuver"
local shieldPanel, hullPanel

-- constants
local P = "Player"
local T = "Target"
local x, y = 600000, 0
local mineRadius = 1200
local grid = {
    {1, 1, 1, 1, 1, 1, 1, 1, 1},
    {1, P, 0, 0, 1, 0, 0, 0, 1},
    {1, 1, 1, 0, 1, 0, 1, 0, 1},
    {1, 0, 0, 0, 1, 0, 1, 0, 1},
    {1, 0, 1, 1, 1, 0, 1, 0, 1},
    {1, 0, 0, 0, 0, 0, 1, T, 1},
    {1, 1, 1, 1, 1, 1, 1, 1, 1},
}

-- variables
local player
local mines = {}
local height, width
local playerX, playerY
local targetX, targetY
local startTick
local watchdog

local createPlayer = function()
    local p = PlayerSpaceship():
    setFactionId(My.World.player:getFactionId()):
    setTemplate("Flavia P.Falcon"):
    setCallSign(id):
    setJumpDrive(false):
    setWarpDrive(false):
    setHullMax(10):
    setImpulseMaxSpeed(80):
    setRotationMaxSpeed(10):
    setCombatManeuver(0, 0):
    setCanBeDestroyed(false):
    setShieldsActive(false):
    setAutoCoolant(true):
    commandSetAutoRepair(true)

    -- disable all weapons
    for i=0,15 do
        p:setBeamWeapon(i, 0, 0, 0, 0, 0)
    end
    for _,weapon in pairs({"hvli", "homing", "mine", "nuke", "emp"}) do
        p:setWeaponStorage(weapon, 0)
        p:setWeaponStorageMax(weapon, 0)
    end
    p:setShieldsMax()
    return p
end

local createMine = function()
    local m = Mine()
    return m
end

local function success()
    local time = Cron.now() - startTick

    My.World.player:addCustomMessage("helms", id .. "result", string.format("You finished the simulation with a score of %.2f.", time))
    My.Simulations.HelmsManeuver.destroy()
end

local function fail()
    My.World.player:addCustomMessage("helms", id .. "result", "You have hit a mine and the simulation was aborted.\n\nBetter luck next time.")
    My.Simulations.HelmsManeuver.destroy()
end

local function step2Maneuver()
    if distance(player, targetX, targetY) < mineRadius then success() end
    for _, mine in pairs(mines) do
        if not mine:isValid() then fail() end
    end
end

local function step1Beginning()
    local x, y

    x, y = player:getPosition()

    if x ~= playerX or y ~= playerY then
        startTick = Cron.now()
        Cron.regular(id, step2Maneuver, 0.1)
    end
end

My.Simulations.HelmsManeuver.create = function()
    mines = {}
    height = 0
    for dy, row in pairs(grid) do

        for dx, item in pairs(row) do
            local posX = x + dx * mineRadius
            local posY = y + dy * mineRadius
            if item == 1 then -- mine
                local mine = createMine():setPosition(posX, posY)
                table.insert(mines, mine)
            elseif item == P then

                playerX, playerY = posX, posY
            elseif item == T then
                targetX, targetY = posX, posY
            end
        end
        height = height + 1
        if width == nil or width < dy then width = dy end
    end

    if playerX == nil or playerY == nil then error("The grid did not set the Players initial position", 2) end
    if targetX == nil or targetY == nil then error("The grid did not set the Target position", 2) end

    player = createPlayer():
    setPosition(playerX, playerY):
    setRotation(0):
    commandTargetRotation(0)

    My.World.player:transferPlayersAtPositionToShip("helms", player)

    Cron.regular(id, step1Beginning, 0.05)
end

My.Simulations.HelmsManeuver.destroy = function()
    Cron.abort(id)
    if watchdog ~= nil and watchdog:isStarted() then
        watchdog:stop()
    end

    if player:hasPlayerAtPosition("helms") and not My.World.player:hasPlayerAtPosition("helms") then
        player:transferPlayersAtPositionToShip("helms", My.World.player)
    end
    player:destroy()
    for _, thing in pairs(mines) do
        if thing:isValid() then thing:destroy() end
    end
    mines = {}
end

My.Simulations.HelmsManeuver.add = function()
    My.World.player:addCustomButton("helms", id, "Simulation: Maneuver", function()
        My.Simulations.HelmsManeuver.create()
        if isEePlayer(player) and player:isValid() then
            if My.World.player:hasPlayerAtPosition("helms") then
                My.World.player:transferPlayersAtPositionToShip("helms", player)
            end

            watchdog = My.Simulations.watchdog(
                player,
                My.World.player,
                "helms",
                600,
                x,
                x + 50000,
                y,
                y + 50000,
                function () My.Simulations.HelmsManeuver.destroy() end,
                id .. "-watchdog"
            )
            watchdog:start()

            player:addCustomButton("helms", id, "Simulation beenden", function()
                My.Simulations.HelmsManeuver.destroy()
            end)
        else
            logError("Creating the simulation " .. id .. " went wrong because it did not produce a player ship.")
            My.Simulations.HelmsManeuver.destroy()
        end
    end)
end
My.Simulations.HelmsManeuver.remove = function()
    My.World.player:removeCustom(id)
end




