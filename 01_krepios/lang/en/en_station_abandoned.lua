My.Translator:register("en", {
    station_abandoned_description = function()
        return Util.random({
            "An abandoned base.",
            "An abandoned station.",
            "This old station is no longer used.",
            "This old station has been decommissioned."
        }) .. " " .. Util.random({
            "It is recommended to avoid it.",
            "Entry of the station is prohibited.",
            "Entering the station is dangerous and is not recommended.",
            "Two treasure hunters had an accident on this station in the last 6 months.",
        })
    end,
    station_abandoned_hail_docked = "Your ship's docking bay is connected to the station's airlock. A plate indicates that in the event of a power failure, the airlock can be opened by manually unlocking it.\n\n But nobody knows what is hidden behind the airlock.",
    station_abandoned_hail_docked_searched = "You can open the airlock of the station easily. Behind it you can only see yawning emptiness. Everything of value has already been removed by treasure hunters, pirates and opportunists.",
    station_abandoned_enter = "Enter station",

    -- empty
    station_abandoned_enter_empty = "The station is empty and abandoned. Even after a long search, you do not find anything of value.",

    -- good
    station_abandoned_good_power = "You find that the fusion reactor powering the station is still present and has only been powered down. Your engineer is capable of powering it up so it can be used to recharge your ships battery.",
    station_abandoned_good_power_hail = "The fusion reactor faithfully performs its duty and charges your ship's batteries.",
    station_abandoned_good_repair = "The machines from the old repair dock have not been stolen yet. After a brief repair your engineer informs you that the repair dock is operational again and can be used to repair your ships hull.",
    station_abandoned_good_repair_hail = "nano droids repair your ship's hull",

    -- bad
    station_abandoned_bad_power = "The worn out technology of this station causes an explosive discharge of energy at the airlock. This causes a rapid voltage drop in your ship and damages some of your ships component.",

    station_abandoned_leave = "Leave station",
    station_abandoned_leave_comms = "",
})