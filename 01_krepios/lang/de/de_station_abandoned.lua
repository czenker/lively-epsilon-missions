My.Translator:register("de", {
    station_abandoned_description = function()
        return Util.random({
            "Ein verlassener Stützpunkt.",
            "Eine verlassene Station.",
            "Diese alte Station wird nicht mehr genutzt.",
            "Diese alte Station ist außer Dienst gestellt."
        }) .. " " .. Util.random({
            "Es wird empfohlen die Station zu meiden.",
            "Das Betreten der Station ist untersagt.",
            "Das Betreten ist gefährlich und wird nicht empfohlen.",
            "In den letzten 6 Monaten sind 2 Schatzjäger auf der Station verunglückt.",
        })
    end,
    station_abandoned_hail_docked = "Die Landeluke eures Schiffs ist an die Luftschleuse der Station angedockt. Ein Schild weißt darauf hin, dass im Falle eines Energieausfalls die Luftschleuse durch manuelle Entriegelung geöffnet werden kann.\n\nDoch keiner weiß, was hinter der Schleuse verborgen liegt.",
    station_abandoned_hail_docked_searched = "Die Luftschleuse der Station laesst sich leicht oeffnen. Dahinter ist nur gähnende Leere zu sehen. Alles von Wert wurde bereits von Schatzjägern, Piraten und Opportunisten entfernt.",
    station_abandoned_enter = "Station betreten",

    -- empty
    station_abandoned_enter_empty = "Die Station ist leer und verlassen. Auch nach längerer Suche lässt sich hier nichts von Wert finden.",

    -- good
    station_abandoned_good_power = "Offenbar wurde der Fusionsreaktor der Station nur ausgeschaltet. Euer Engineer schafft es den Stromkreis soweit herzustellen, dass dockende Schiffe hier ihre Batterien aufladen können.",
    station_abandoned_good_power_hail = "Der Fusionsreaktor verrichtet treu seinen Dienst und lädt die Schiffsbatterien.",
    station_abandoned_good_repair = "Die Maschinen zur Schiffsreparatur sind noch nicht von der Station gestohlen worden. Nach einiger Zeit informiert euch euer Engineer, dass er mit Hilfe einiger Ersatzteile, das Reparaturdock wieder funktionsfähig gemacht hat.",
    station_abandoned_good_repair_hail = "Nanodroiden reparieren eure Schiffshülle",

    -- bad
    station_abandoned_bad_power = "Die verschlissene Technik der Station sorgt für eine explosionsartige Entladung großer Mengen von Energie an der Landeluke. Dies führt zu einem rapiden Spannungsabfall in ihrem Schiff und Schäden an der Elektronik.",

    station_abandoned_leave = "Station verlassen",
    station_abandoned_leave_comms = "",
})