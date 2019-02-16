My = My or {}
My.Simulations = My.Simulations or {}

-- a simulation where Helms needs to evade incoming missiles
My.Simulations.HelmsEvasion = My.Simulations.HelmsEvasion or {}

local id = "helms-evasion"
local shieldPanel, hullPanel

-- constants
local x, y = 500000, 0
local maxEnemies = 8
local distanceBetweenEnemies = 1000
local targetX = x + (maxEnemies+3) * distanceBetweenEnemies

-- variables
local player
local enemies = {}
local initialX, initialY, initialRot
local startTick
local watchdog

local createPlayer = function()
    local p = PlayerSpaceship():
    setFactionId(My.World.player:getFactionId()):
    setTemplate("Flavia P.Falcon"):
    setCallSign(id):
    setJumpDrive(false):
    setWarpDrive(false):
    setImpulseMaxSpeed(80):
    setRotationMaxSpeed(10):
    setCombatManeuver(250, 150):
    setCanBeDestroyed(false):
    setShieldsActive(true):
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

    return p
end

local createEnemy = function()
    local e = CpuShip():
    setCallSign(""):
    setTemplate("Adder MK5"):
    setFaction("Outlaw"):
    setImpulseMaxSpeed(0):
    setRotationMaxSpeed(60):
    setJumpDrive(false):
    setWarpDrive(false)

    -- disable all weapons
    for i=0,15 do
        e:setBeamWeapon(i, 0, 0, 0, 0, 0)
    end
    for _,weapon in pairs({"hvli", "homing", "mine", "nuke", "emp"}) do
        e:setWeaponStorage(weapon, 0)
        e:setWeaponStorageMax(weapon, 0)
    end

    return e
end

local function success()
    local time = Cron.now() - startTick

    My.World.player:addCustomMessage("helms", id .. "result", string.format("You finished the simulation with a score of %.2f.", time))
    My.Simulations.HelmsEvasion.destroy()
end

local function fail()
    My.World.player:addCustomMessage("helms", id .. "result", "Your ship was severly damaged and the simulation was aborted.\n\nBetter luck next time.")
    My.Simulations.HelmsEvasion.destroy()
end

local function step2Evasion()
    local lowestShield
    for i=0,player:getShieldCount()-1 do
        local shield = player:getShieldLevel(i) / player:getShieldMax(i)
        if lowestShield == nil or shield < lowestShield then
            lowestShield = shield
        end
    end
    local shieldLevel
    if lowestShield >= 0.7 then
        shieldLevel = "high"
    elseif lowestShield >= 0.3 then
        shieldLevel = "medium"
    elseif lowestShield >= 0.1 then
        shieldLevel = "low"
    else
        shieldLevel = "off"
    end

    shieldPanel:write("Shields: " .. shieldLevel)

    local hull = player:getHull() / player:getHullMax()
    local hullLevel
    if hull >= 1 then
        hullLevel = "intact"
    elseif hull >= 0.7 then
        hullLevel = "lightly damaged"
    elseif hull >= 0.4 then
        hullLevel = "heavily damaged"
    else
        hullLevel = "critical"
    end
    hullPanel:write("Hull: " .. hullLevel)

    local currentX, currentY = player:getPosition()
    if player:getHull() <= 2 then
        fail()
    elseif currentX > targetX then
        success()
    end
end

local function step1Beginning()
    local x, y, rot

    x, y = player:getPosition()
    rot = player:getRotation()

    if x ~= initialX or y ~= initialY or rot ~= initialRot then
        startTick = Cron.now()
        for _, enemy in pairs(enemies) do
            enemy:orderAttack(player)
        end
        Cron.regular(id, step2Evasion, 0.1)
    end
end

My.Simulations.HelmsEvasion.create = function()
    player = createPlayer():
    setPosition(x, y):
    setRotation(0):
    commandTargetRotation(0)

    enemies = {}
    for i=1,maxEnemies do
        enemies[i] = createEnemy()
        if i%2 == 1 then
            enemies[i]:
            setPosition(x + distanceBetweenEnemies * (i+1), y + 2000):
            setRotation(270)
        else
            enemies[i]:setPosition(x + distanceBetweenEnemies * (i+1), y - 2000):
            setRotation(90)
        end

        local weapon
        if i%4 == 2 or i%4 == 3 then
            weapon = "hvli"
        else
            weapon = "homing"
        end
        enemies[i]:setWeaponStorage(weapon, 99)
        enemies[i]:setWeaponStorageMax(weapon, 99)
    end

    My.World.player:transferPlayersAtPositionToShip("helms", player)

    shieldPanel = My.Simulations.infoPanel(player, "helms", id .. "-shields")
    hullPanel = My.Simulations.infoPanel(player, "helms", id .. "-hulls")

    initialX, initialY = player:getPosition()
    initialRot = player:getRotation()
    Cron.regular(id, step1Beginning, 0.05)

end

My.Simulations.HelmsEvasion.destroy = function()
    Cron.abort(id)
    if watchdog ~= nil and watchdog:isStarted() then
        watchdog:stop()
    end

    if player:hasPlayerAtPosition("helms") and not My.World.player:hasPlayerAtPosition("helms") then
        player:transferPlayersAtPositionToShip("helms", My.World.player)
    end
    player:destroy()
    for _, ship in pairs(enemies) do
        if ship:isValid() then ship:destroy() end
    end
end

My.Simulations.HelmsEvasion.add = function()
    My.World.player:addCustomButton("helms", id, "Simulation: Evasion", function()
        My.Simulations.HelmsEvasion.create()
        if isEePlayer(player) and player:isValid() then
            if My.World.player:hasPlayerAtPosition("helms") then
                My.World.player:transferPlayersAtPositionToShip("helms", player)
            end

            watchdog = My.Simulations.watchdog(
                player,
                My.World.player,
                "helms",
                300,
                x - 1000,
                targetX + 1000,
                y - 1000,
                y + 1000,
                function () My.Simulations.HelmsEvasion.destroy() end,
                id .. "-watchdog"
            )
            watchdog:start()

            player:addCustomButton("helms", id, "Simulation beenden", function()
                My.Simulations.HelmsEvasion.destroy()
            end)
        else
            logError("Creating the simulation " .. id .. " went wrong because it did not produce a player ship.")
            My.Simulations.HelmsEvasion.destroy()
        end
    end)
end
My.Simulations.HelmsEvasion.remove = function()
    My.World.player:removeCustom(id)
end




