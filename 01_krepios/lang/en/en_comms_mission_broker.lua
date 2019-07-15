local f = string.format

My.Translator:register("en", {
    comms_mission_broker_label = "Missions",
    comms_mission_broker_main_no_missions = "We can't offer you any missions right now.",
    comms_mission_broker_main_missions = "We think the following missions are of interest to you:",

    comms_mission_broker_detail_acceptable = function()
        return Util.random({
            "What do you think of the offer?",
            "What do you think?",
            "Does that sound attractive?",
            "What do you think of that?",
            "You think you can do me a favor?",
            "Can you do me the favor?",
            "Do you think you can help me?",
            "Can you help me?",
            "Can we make a deal?",
        })
    end,
    comms_mission_broker_detail_accept_label = "accept mission",
    comms_mission_broker_accept_confirm = function()
        return Util.random({
            "Thank you for accepting the assignment.",
            "Thank you for taking over the mission.",
            "Thank you for helping in this matter.",
        })
    end,
})