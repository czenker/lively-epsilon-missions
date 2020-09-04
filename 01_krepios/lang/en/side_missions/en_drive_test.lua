local t = My.Translator.translate
local f = string.format

My.Translator:register("en", {
    side_mission_drive_test = "Test a new Impulse Drive",
    side_mission_drive_test_description = function(tinkererPerson, payment, bonusMinutes, bonusPayment)
        return Util.random({
            f("Hey there fellows. It's me, your favorite tinkerer %s.", tinkererPerson:getNickName()),
            f("This is a very special mission from %s. Wanna do something valuable for my development?", tinkererPerson:getNickName())
        }) .. " " .. Util.random({
            "I developed a new impulse drive. On paper it should work perfectly, but I need to give it a test run in the real world.",
            "I finally finished the prototype of a new impulse drive. Now I am looking for some one to test it out.",
        }) .. " " .. Util.random({
            "All you need to do is fly around the station and I will monitor the systems from here.",
            "So your job is to fly around the station as fast as you can to give the drive a proper stress test.",
        }) .. " " .. Util.random({
            f("I will pay you %0.2fRP as soon as you make it back to the station. And if you finish the test in less than %0.1f minutes I will add another %0.2fRP on top.", payment, bonusMinutes, bonusPayment),
            f("%0.2fRP will be yours. Plus, when you finish the job in less than %0.1f minutes, there will be a bonus of %0.2fRP.", payment, bonusMinutes, bonusPayment)
        }).. "\n\n" .. Util.random({
            "And don't let the rumors, that most of my inventions fail in horrible ways, confuse you. They are mostly untrue.",
            "This is the first invention of mine that is absolutely failure-proof. Trust me!",
        })
    end,
    side_mission_drive_test_accept_dock = "You need to dock the station, so I can install the drive if you want to accept the mission.",
    side_mission_drive_test_accept = function()
        return "Alright. I have replaced your Impulse Drive with my newer version and set it to the parameters of your previous Impulse Drive. It also takes the place used for Jump or Warp Drives, so you can not use those for now. But in the final version, I will find a solution for it.\n\n" ..
        "I have marked waypoints on your map. Follow them and then dock with the station again, so I can reinstall your previous drive again. I will be monitoring the experiment from this station."
    end,
    side_mission_drive_test_artifact_name = function(wayPointId)
        return f("Waypoint %d", wayPointId)
    end,
    side_mission_drive_test_hint = function(waypointId, stationCallSign)
        return f("Fly to \"%s\" close to station %s.", t("side_mission_drive_test_artifact_name", waypointId), stationCallSign)
    end,
    side_mission_drive_test_hint_bonus = function(time)
        return f("Finish before %0.0f to get a bonus.", time)
    end,
    side_mission_drive_test_log = function(wayPointId)
        return f("Waypoint %d passed", wayPointId)
    end,
    side_mission_drive_test_hint_dock = function(stationCallSign)
        return "Dock with " .. stationCallSign .. " to finish the mission."
    end,
    side_mission_drive_test_success = function(tinkererPerson, payment)
        return Util.random({
            "Welcome back."
        }) .. "\n\n" .. Util.random({
            "At least the drive did not blow up.",
            "That test went better than I anticipated.",
            "Well the test could have been worse."
        }) .. " " .. Util.random({
            "Except for some minor difficulties the results of the test drive are impressive.",
            "I think I can eliminate these few minor glitches with a little work."
        }) .. " " .. Util.random({
            "But it will surely help my developments.",
            "With you help I can further my developments.",
        }) .. " " .. Util.random({
            f("And, as promised, here is your payment of %0.2fRP.", payment),
            f("I think, %0.2fRP should compensate you for your troubles.", payment),
        }) .. "\n\n- " .. tinkererPerson:getNickName()
    end,
    side_mission_drive_test_complication1 = function(tinkererPerson)
        return "Bad news.\n\n" ..
        "The thrusters on the left side seem to have a malfunction and only work at half capacity. This makes the ship fly to the left. But if your Helms Officer stears to the right, this should not be a major issue.\n\n" ..
        "- " .. tinkererPerson:getNickName()
    end,
    side_mission_drive_test_complication2 = function(tinkererPerson)
        return "The drive is creating more heat than I anticipated.\n\n" ..
        "I don't know how this could happen, but there is heat radiating from the impulse drive and spreading into other systems. Your Engineering Officer should reserve some coolant to cool those systems off to avoid a catastrophe.\n\n" ..
        "- " .. tinkererPerson:getNickName()
    end,
    side_mission_drive_test_complication3 = function(tinkererPerson)
        return "Was that an explosion in one of the drives?\n\n" ..
        "I don't think this is normal. But I have seen worse. I recommend having your Engineering Officer to dispatch your Repair Crew to repair potential damage. And maybe have them take some fire extinguishers.\n\n" ..
        "- " .. tinkererPerson:getNickName()
    end,
})
