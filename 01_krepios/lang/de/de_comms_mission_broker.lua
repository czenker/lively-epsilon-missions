local f = string.format

My.Translator:register("de", {
    comms_mission_broker_label = "Missionen",
    comms_mission_broker_main_no_missions = "Wir können Ihnen im Augenblick keine Missionen anbieten.",
    comms_mission_broker_main_missions = "Folgende Missionen halten wir für sie interessant:",

    comms_mission_broker_detail_too_many_missions = "Sie sollten einige ihrer aktiven Missionen beenden, bevor Sie neue annehmen.",

    comms_mission_broker_detail_acceptable = function()
        return Util.random({
            "Was haltet ihr von dem Angebot?",
            "Was denkt ihr?",
            "Klingt das attraktiv?",
            "Was haltet ihr davon?",
            "Denkt ihr, ihr könnt mir den Gefallen tun?",
            "Könnt ihr mir den Gefallen tun?",
            "Denkt ihr, ihr könnt mir helfen?",
            "Könnt ihr mir helfen?",
            "Kommen wir ins Geschäft?",
        })
    end,
    comms_mission_broker_detail_accept_label = "Mission annehmen",
    comms_mission_broker_accept_confirm = function()
        return Util.random({
            "Vielen Dank, dass sie den Auftrag annehmen.",
            "Vielen Dank, dass ihr die Mission übernehmt.",
            "Danke, dass sie in dieser Angelegenheit helfen.",
        })
    end,
})