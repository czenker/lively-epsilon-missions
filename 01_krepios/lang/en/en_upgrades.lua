local f = string.format

My.Translator:register("en", {
    upgrade_speed1_name = "Impulse Drive MkI",
    upgrade_speed1_description = function(speedUPerMin)
        return f("Thee Impulse Drive MkI is a basic drive for small and medium-sized freighters. Speeds higher than %0.1fu/min are only feasible for experienced engineers. The drive is valued everywhere for its reliability.", speedUPerMin)
    end,

    upgrade_speed2_name = "Impulse Drive MkII",
    upgrade_speed2_description = function(speedUPerMin)
        return f("The Impulse Drive MkII is an improved version on the basic drive that is equipped as default on most light ships. During normal usage speeds up to %0.1fu/min are possible - but good engineers are able to tease out more.", speedUPerMin)
    end,

    upgrade_speed3_name = "Impulse Drive MkIII",
    upgrade_speed3_description = function(speedUPerMin)
        return f("Outstanding Terran engineering allowed to improve the Impulse Drive for small and medium-sized freighters even further. The result was the Impulse Drive MkIII convincing with a maximum speed of %0.1fu/min and more.", speedUPerMin)
    end,

    upgrade_speed4_name = "Impulse Drive MkIV",
    upgrade_speed4_description = function(speedUPerMin)
        return f("Smaller improvements in the matter injector and optimizing the effectiveness of the drive made Impulse Drive MkIV into one of the best options for small and medium-sized freighters. Its maximum speed is %0.1fu/min without overclocking of using the afterburners.", speedUPerMin)
    end,

    upgrade_rotation1_name = "Thruster MkI",
    upgrade_rotation1_description = function(secondsPer180)
        return f("The MkI is one of the simplest thrusters on the market. A 180 degree turn is possible in %0.1f seconds.", secondsPer180)
    end,

    upgrade_rotation2_name = "Thruster MkII",
    upgrade_rotation2_description = function(secondsPer180)
        return f("A targeted control system on the thrusters increases the agility of the ship significantly and allows for 180 degree turns in %0.1f seconds or less.", secondsPer180)
    end,

    upgrade_rotation3_name = "Thruster MkIII",
    upgrade_rotation3_description = function(secondsPer180)
        return f("This upgrade distributes energy dynamically between the thrusters and the impulse driver and makes turns even faster. A 180 degree turn takes less than %0.1f seconds.", secondsPer180)
    end,

    upgrade_storage1_name = "Storage S",
    upgrade_storage1_description = function(storageSize)
        return f("A Storage for freighters with a capacity of %d units.", storageSize)
    end,

    upgrade_storage2_name = "Storage M",
    upgrade_storage2_description = function(storageSize)
        return f("Increasing the storage space of small and medium-sized freighters allows storing %d units more.", storageSize)
    end,

    upgrade_storage3_name = "Storage L",
    upgrade_storage3_description = function(storageSize)
        return f("The usage of storage space can be optimized by removing unnecessary separating walls and installing an intelligent storage system. This allows storing %d more units.", storageSize)
    end,

    upgrade_combatManeuver_name = "Combat Maneuver BST200",
    upgrade_combatManeuver_description = "Combat Maneuver thrusters allow for quick and short evasion maneuvers. It can be used to avoid objects in space or evade enemy missiles.",

    upgrade_warpDrive_name = "Warp Drive X8",
    upgrade_warpDrive_description = "Ships are fitted with Warp Drives to allow for interstellar travel at super-light speeds.\n\nA ship can either be fitted with a Jump Drive or Warp Drive.",

    upgrade_jumpDrive_name = function(range)
        return f("Jump Drive %dU", range)
    end,
    upgrade_jumpDrive_description = function(range)
        return f("Jump Drives are usually employed by military and paramilitary groups to stage surprise attacks. But they are also regularly used for long distance travel. This drive is capable of jumps for up to %dU.\n\nA ship can either be fitted with a Jump Drive or Warp Drive.", range)
    end,

    upgrade_hvli1_name = "HVLI Storage S",
    upgrade_hvli1_description = function(storageSize)
        return f("%d HVLI missiles can be stored in even the smallest ships. Same here: A small storage close to the torpedo bays is sufficient.", storageSize)
    end,

    upgrade_hvli2_name = "HVLI Storage M",
    upgrade_hvli2_description = function(storageSize, storageMalusSize)
        return f("Reconstructing the storage are creates more space for %d HVLI missiles. But the general storage are has to be reduced by %d units.", storageSize, storageMalusSize)
    end,

    upgrade_hvli3_name = "HVLI Storage L",
    upgrade_hvli3_description = function(storageSize, storageMalusSize)
        return f("A further reduction of storage space by %d units allows installing a suspension system storing a total of %d HVLI missiles.", storageMalusSize, storageSize)
    end,

    upgrade_homing1_name = "Homing Storage S",
    upgrade_homing1_description = function(storageSize)
        return f("A small area in the ship's storage is used to keep %d homing missiles. It is reinforced to prevent detonations inside the ships hull.", storageSize)
    end,

    upgrade_homing2_name = "Homing Storage M",
    upgrade_homing2_description = function(storageSize, storageMalusSize)
        return f("Through reconstruction a total of %d homing missiles can be stored. But it comes by the price of a reduction of general storage space by %d units.", storageSize, storageMalusSize)
    end,

    upgrade_homing3_name = "Homing Storage L",
    upgrade_homing3_description = function(storageSize, storageMalusSize)
        return f("A further reduction of general storage by %d units creates room for a suspension system that allows for a total of %d stored homing missiles.", storageMalusSize, storageSize)
    end,

    upgrade_mine1_name = "Mine Storage S",
    upgrade_mine1_description = function(storageMalusSize)
        return f("By creating a stasis field in the storage area allows to safely store a Mine. This retrofitting reduces the general storage by %d units.", storageMalusSize)
    end,

    upgrade_mine2_name = "Mine Storage M",
    upgrade_mine2_description = function(storageSize, storageMalusSize)
        return f("Increasing the size of the stasis field to create room for a total of %d Mines. The general storage space has to be reduced by a further %d units.", storageSize, storageMalusSize)
    end,

    upgrade_mine3_name = "Mine Storage L",
    upgrade_mine3_description = function(storageSize, storageMalusSize)
        return f("This upgrade basically converts a transport ship into a support mine layer. A storage capacity of %d mines allows creating smaller mine belts in space. The upgrade requires further %d units of general storage space that can not be used.", storageSize, storageMalusSize)
    end,

    upgrade_emp1_name = "EMP Storage S",
    upgrade_emp1_description = function(storageMalusSize)
        return f("EMP weapons allow to disable a ship's shield without damaging its hull. By reducing the general storage area by %d units enough space is created to store an EMP missile.", storageMalusSize)
    end,

    upgrade_emp2_name = "EMP Storage M",
    upgrade_emp2_description = function(storageSize, storageMalusSize)
        return f("Reducing the general storage by a further %d units makes room to store a total of %d EMP missiles.", storageMalusSize, storageSize)
    end,

    upgrade_emp3_name = "EMP Storage L",
    upgrade_emp3_description = function(storageSize, storageMalusSize)
        return f("An increase of EMP storage capacity to %d missiles is especially popular with pirates and law enforcement as it does not create any permanent damage. To allow for the storage the general storage area has to be reduced by %d units.", storageSize, storageMalusSize)
    end,

    upgrade_nuke1_name = "Nuke Storage S",
    upgrade_nuke1_description = function(storageMalusSize)
        return f("General storage areas have to undergo a major refit to be usable as Nuke storage. The main problem is to guarantee safety from radiation to the crew and the ship's instruments. The storage will be reduced by %d units.", storageMalusSize)
    end,

    upgrade_nuke2_name = "Nuke Storage M",
    upgrade_nuke2_description = function(storageMalusSize)
        return f("This is a bigger storage for an additional Nuke missile at the cost of %d units of general storage. But it significantly increases the military value of the ship.", storageMalusSize)
    end,

    upgrade_energy1_name = "Power MkI",
    upgrade_energy1_description = function(energyUnits)
        return f("A simple energy storage for transport vessels that can store %d units of energy.", energyUnits)
    end,

    upgrade_energy2_name = "Power MkII",
    upgrade_energy2_description = function(energyUnits)
        return f("Developments in energy storage technology during the last years allows increasing the energy density of the ships batteries. This upgrade installs the latest micropore storage technology to store an additional %d units of energy.", energyUnits)
    end,

    upgrade_energy3_name = "Power MkIII",
    upgrade_energy3_description = function(energyUnits)
        return f("Distributed batteries create redundancy and limit the damage done by malfunctioning parts. Adding smaller batteries close to their point of use increases the energy storage by %d and greatly improves the resilience of the components.", energyUnits)
    end,

    upgrade_energy4_name = "Power MkIV",
    upgrade_energy4_description = function(energyUnits, storageMalusSize)
        return f("Additional batteries are fitted into the general storage to store an additional %d units. However, it means that %d units of general storage area are no longer available for other use.", energyUnits, storageMalusSize)
    end,

    upgrade_powerPresets_name = "Power Magician",
    upgrade_powerPresets_description = function(slots)
        return f("This software Update for the engineering station allows storing and recalling settings for energy and coolant distribution on the ship. Many engineers on bigger ships make use of this software to act efficiently and adapt quickly to changed situations.", slots)
    end,

    upgrade_shield1_name = "Shield MkI",
    upgrade_shield1_description = function(strength)
        return f("No merchant ship should explore the depths of space without an adequate shield. This shield with a nominal capacity of %d has the main purpose to guard against stray asteroids.", strength)
    end,

    upgrade_shield2_name = "Shield MkII",
    upgrade_shield2_description = function(strength)
        return f("The nominal capacity of %d grants basic protection from pirate attacks for most trading ships. Quite often the longevity of the shield made a trader persevere long enough until their escort drove the attackers off.", strength)
    end,

    upgrade_shield3_name = "Shield MkIII",
    upgrade_shield3_description = function(strength)
        return f("This is the highest level of shield that is licensed to be used on trading ships without the need for a special military license. It is not recommended for prolonged fights, but the nominal capacity of %d makes it possible to participate in smaller skirmishes.", strength)
    end,

    upgrade_hull1_name = "Basic Hull",
    upgrade_hull1_description = "Hulls protect the crew from dangerous influences of space, like radiation, shortness of oxygen, asteroid impacts and laser fire.",

    upgrade_hull2_name = "Plasteel Reinforcement",
    upgrade_hull2_description = function(strength)
        return f("The hull of your ship will be paved and reinforced with plates made of plasteel. It strengthens the hull up to a level of %d. It also protects vital systems of the ship from damage more efficiently.", strength)
    end,

    upgrade_laserRefit_name = "Laser Configurator",
    upgrade_laserRefit_description = "The Laser Configurator can overcharge the lasers of a ship to achieve different improvements, like improving the lasers range or its damage. On the downside operating the lasers outside its usual parameters also increases its energy consumption which also increases its heat generation.",
    upgrade_laserRefit_button = "Laser",
    upgrade_laserRefit_info_button = "Information",
    upgrade_laserRefit_info_title = "Information on Laser",
    upgrade_laserRefit_info_intro = function(refitCostPower, refitTime)
        return "Advanced control systems enable the laser to be reconfigured even during operation. The weapons officer \z
               can execute the changes and select from a variety of different modes. " ..
               f("A reconfiguration uses %0.0f units of energy and takes %0.1f seconds. ", refitCostPower, refitTime) ..
               "This process can be quickened by making more energy available to the subsystem.\n\n\z
               The following modes can be selected:"
    end,
    upgrade_laserRefit_beam_button = function(i)
        return f("Laser %d", i)
    end,
    upgrade_laserRefit_beam_info_button = "Information",
    upgrade_laserRefit_beam_info_range = function(range, minAngle, maxAngle)
        return f("The laser can be aimed at targets between  %0.0f and %0.0f degrees  in a distance with of up to  %0.3fu.", minAngle, maxAngle, range)
    end,
    upgrade_laserRefit_beam_info_damage = function(damage, shotsPerMinute, damagePerMinute)
        return f("It fires %0.1f shots per minute each causing  %0.1f  damage. Therefore, the maximum damage caused per minute is up to  %0.1f.", shotsPerMinute, damage, damagePerMinute)
    end,
    upgrade_laserRefit_beam_info_heat = function(minutesToOverHeat)
        return f("Without coolant the laser can be fired for a maximum duration of %0.1f minutes before it starts to take damage from overheating.", minutesToOverHeat)
    end,
    upgrade_laserRefit_beam_info_energy = function(energyPerMinute)
        return f("To function properly the laser needs %0.0f units of energy per minute.", energyPerMinute)
    end,
    upgrade_laserRefit_beam_info_disclaimer = "All values apply to a healthy and not overcharged system.",

    upgrade_laserRefit_beam_info_default_button = "Default",
    upgrade_laserRefit_beam_info_default_description = "This is the default for industrial lasers. They offer a fine-tuned balance of firepower, firing rate and range and are optimized regarding energy consumption and heat dissipation.",
    upgrade_laserRefit_beam_info_range_button = "Sniper",
    upgrade_laserRefit_beam_info_range_description = "This mode sacrifices firing rate and shooting angles for an increased range. The energy consumption of the weapon has to be increased to allow these improved distances which also causes significantly faster overheating.",
    upgrade_laserRefit_beam_info_power_button = "Damage",
    upgrade_laserRefit_beam_info_power_description = "With this mode the lasers are optimized for maximum damage output. The laser beams are pre-charged with more energy which causes the fire rate to drop, but also increases the damage dealt significantly. Since the laser is operated outside its specifications overheating and an increased consumption of energy have to be expected. As high energy beams have a higher diffusion, the range of the beams has to be reduced slightly.",
    upgrade_laserRefit_beam_info_speed_button = "Rate of fire",
    upgrade_laserRefit_beam_info_speed_description = "The damage output of the laser can be reduced to defend against multiple soft targets in quick succession. The damage dealt per minute does not change, but the energy demand and the lost heat are increased, since the there is less time in between shots to cool the systems down.",
    upgrade_laserRefit_beam_info_is_refitting = "reconfiguring...",

    upgrade_beam_name = "Beam Emitter",
    upgrade_beam_description = function(storageMalusSize)
        return f("An additional laser can be fitted on your ship that can defend the stern of your ship against laser fire. The general storage has to be reduced by %d units to make room for the firing bay. But especially traders love the additional laser as it allows them to defend their ship while charging the jump drive.", storageMalusSize)
    end,

    upgrade_probe_name = "Probe Storage",
    upgrade_probe_description = function(storageMalusSize, amount)
        return f("Increasing the storage capacity for Scan Probe is a very simple process. The general storage area is reduced by %d units and used to store %d more probes.", storageMalusSize, amount)
    end,

    upgrade_jumpCalculator_label_info_button = "Information",
    upgrade_jumpCalculator_label_info = "The Jump Calculator helps to calculate correct jump vectors in difficult surroundings. It can target known stations in the sector and waypoints set by the Relay Officer and outputs the direction and distance from the ships current position.",
    upgrade_jumpCalculator_label = "Jump Calculator",
    upgrade_jumpCalculator_waypoint_label = function(number)
        return f("Waypoint %d", number)
    end,
    upgrade_jumpCalculator_result = function(label, heading, distance)
        return f("Vector to %s\n\nDistance: %0.1fu\nHeading: %d", label, distance, heading)
    end,
})