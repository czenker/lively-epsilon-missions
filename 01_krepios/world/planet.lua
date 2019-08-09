My.EventHandler:register("onWorldCreation", function()
    My.World.planet = Planet():setPosition(9 * 20000, 9 * 20000):setPlanetRadius(20000):setPlanetSurfaceTexture("planets/planet-2.png"):setAxialRotationTime(1000)
end, -9999)