-- include original ships
require("shiptemplates/stations.lua")
require("shiptemplates/starFighters.lua")
require("shiptemplates/frigates.lua")
require("shiptemplates/corvette.lua")
require("shiptemplates/dreadnaught.lua")
require("shiptemplates/OLD.lua")

-- player ship

template = ShipTemplate():setName("Ranger TX5"):setClass("Frigate", "Cruiser"):setModel("AtlasHeavyFighterGrey"):setType("playership")
template:setDescription([[TODO]])
template:setHull(100)
template:setShields(70, 70)
template:setSpeed(60, 10, 10)
template:setWarpSpeed(500)
template:setCombatManeuver(250, 150)
template:setBeamWeapon(0, 40, -15, 1200.0, 6.0, 6)
template:setBeamWeapon(1, 40,  15, 1200.0, 6.0, 6)
template:setTubes(3, 30.0)
template:setWeaponStorage("HVLI", 2)
template:setWeaponStorage("Homing", 2)
template:setTubeDirection(0, -90)
template:weaponTubeDisallowMissle(0, "Mine")
template:setTubeDirection(1,  90)
template:weaponTubeDisallowMissle(1, "Mine")
template:setTubeDirection(2, 180)
template:setWeaponTubeExclusiveFor(2, "Mine")
template:setTubeLoadTime(2, 60.0)

template:addRoomSystem(1, 0, 2, 1, "Maneuver");
template:addRoomSystem(1, 1, 2, 1, "BeamWeapons");
template:addRoom(2, 2, 2, 1);

template:addRoomSystem(0, 3, 1, 2, "RearShield");
template:addRoomSystem(1, 3, 2, 2, "Reactor");
template:addRoomSystem(3, 3, 2, 2, "Warp");
template:addRoomSystem(5, 3, 1, 2, "JumpDrive");
template:addRoom(6, 3, 2, 1);
template:addRoom(6, 4, 2, 1);
template:addRoomSystem(8, 3, 1, 2, "FrontShield");

template:addRoom(2, 5, 2, 1);
template:addRoomSystem(1, 6, 2, 1, "MissileSystem");
template:addRoomSystem(1, 7, 2, 1, "Impulse");

template:addDoor(1, 1, true);
template:addDoor(2, 2, true);
template:addDoor(3, 3, true);
template:addDoor(1, 3, false);
template:addDoor(3, 4, false);
template:addDoor(3, 5, true);
template:addDoor(2, 6, true);
template:addDoor(1, 7, true);
template:addDoor(5, 3, false);
template:addDoor(6, 3, false);
template:addDoor(6, 4, false);
template:addDoor(8, 3, false);
template:addDoor(8, 4, false);

template = ShipTemplate():setName("Guard Station"):setClass("Corvette", "Support"):setModel("space_station_4")
template:setDescription([[TODO]])
template:setRadarTrace("radartrace_smallstation.png")
template:setHull(200)
template:setShields(500)
template:setSpeed(0, 0, 0)
template:setDockClasses("Starfighter", "Frigate")
--                        Arc, Dir, Range, CycleTime, Dmg
template:setBeamWeapon(0, 30, 0, 2500, 6.0, 6)
template:setBeamWeaponTurret(0, 300, 0, 2)
template:setBeamWeapon(1, 30, 180, 2500, 6.0, 6)
template:setBeamWeaponTurret(1, 300, 180, 2)

template:setTubes(4, 30.0)
template:setWeaponStorage("Homing", 20)
template:setTubeDirection(0, 0)
template:weaponTubeAllowMissle(1, "Homing")
template:setTubeDirection(1, 90)
template:weaponTubeAllowMissle(2, "Homing")
template:setTubeDirection(2, 180)
template:weaponTubeAllowMissle(0, "Homing")
template:setTubeDirection(3, 270)
template:weaponTubeAllowMissle(3, "Homing")

-- TODO: fix the rooms to be more realistic
template:addRoomSystem(0, 0, 3, 3, "FrontShield");
template:addRoomSystem(0, 3, 3, 3, "Reactor");
template:addRoomSystem(0, 6, 3, 3, "RearShield");
template:addRoomSystem(3, 0, 3, 3, "BeamWeapons");
template:addRoomSystem(3, 3, 3, 3, "Warp");
template:addRoomSystem(3, 6, 3, 3, "MissileSystem");
template:addRoomSystem(6, 0, 3, 3, "Maneuver");
template:addRoomSystem(6, 3, 3, 3, "JumpDrive");
template:addRoomSystem(6, 6, 3, 3, "Impulse");

template:addDoor(4, 3, true)
template:addDoor(1, 6, true)
template:addDoor(4, 6, true)
template:addDoor(7, 6, true)
template:addDoor(3, 1, false)
template:addDoor(3, 4, false)
template:addDoor(6, 1, false)
template:addDoor(6, 4, false)

-- enemy ship

-- legion1: fighter
-- legion2: missile
-- legion3: interceptor
-- legion4: laser
-- legion5: bomber

template = ShipTemplate():setName("Legion Fighter"):setClass("Starfighter", "Gunship"):setModel("small_frigate_1")
template:setRadarTrace("radar_cruiser.png")
template:setDescription([[]])
template:setHull(50)
template:setShields(30)
template:setSpeed(120, 28, 25)
template:setBeam(0, 90, 0, 600, 4.0, 4.0)
template:setBeam(1, 30, 0, 1500, 10.0, 4.0)
template:setTubes(1, 30)
template:setWeaponStorage("Homing", 4)
template:setWeaponStorage("HVLI", 4)

template = ShipTemplate():setName("Legion Missile"):setClass("Frigate", "Cruiser: Heavy Artillery"):setModel("small_frigate_2")
template:setRadarTrace("radar_missile_cruiser.png")
template:setDescription([[]])
template:setBeamWeapon(0, 60, 0, 1200, 3, 2)
template:setHull(80)
template:setShields(120, 80)
template:setSpeed(80, 6, 8)
template:setTubes(5, 15)
template:setWeaponStorage("Homing", 30)
template:setTubeDirection(0,  0)
template:setTubeDirection(1, -40)
template:setTubeDirection(2,  40)
template:setTubeDirection(3, -80)
template:setTubeDirection(4,  80)

template = ShipTemplate():setName("Legion Interceptor"):setClass("Starfighter", "Interceptor"):setModel("small_frigate_3")
template:setRadarTrace("radar_fighter.png")
template:setDescription([[]])
template:setHull(30)
template:setShields(20)
template:setSpeed(210, 30, 25)
template:setBeam(0, 60, 0, 1000, 10, 10)
template:setDefaultAI("fighter")

template = ShipTemplate():setName("Legion Destroyer"):setClass("Corvette", "Destroyer"):setModel("small_frigate_4")
template:setDescription([[]])
template:setRadarTrace("radar_dread.png")
template:setHull(100)
template:setShields(200, 120)
template:setSpeed(80, 3.5, 5)
template:setBeam(0, 100, -20, 1500, 10, 8)
template:setBeam(1, 100,  20, 1500, 10, 8)
template:setBeam(2,  30,   0, 2000, 10, 8)
template:setTubes(1, 30)
template:setTubeDirection(0, -180)
template:setWeaponStorage("Homing", 8)

template = ShipTemplate():setName("Legion Bomber"):setClass("Starfighter", "Bomber"):setModel("small_frigate_5")
template:setRadarTrace("radar_blockade.png")
template:setDescription([[]])
template:setBeamWeapon(0, 60, 0, 800, 3, 1)
template:setHull(50)
template:setShields(30, 10)
template:setSpeed(90, 6, 8)
template:setTubes(2, 20)
template:setWeaponStorage("HVLI", 15)
template:setWeaponStorage("Homing", 15)
template:setWeaponStorage("Emp", 2)
template:setTubeDirection(0, -20)
template:setTubeDirection(1,  20)
template:setDefaultAI('missilevolley')
