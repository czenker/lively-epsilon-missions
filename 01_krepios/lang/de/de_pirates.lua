local f = string.format

My.Translator:register("de", {
    pirate_ship_description = function()
        return Util.random({
            "Ein dunkel lackiertes Schiff auf dessen Hülle ein riesiger Totenkopf gezeichnet wurde.",
            "Auf der Hülle dieses Schiffs wird eine Strichliste geführt, die offenbar die Abschussliste des Piloten repräsentiert.",
            "Den Energiesignaturen nach zu urteilen hat das Schiff offenbar einige illegale Verbesserungen installiert.",
            "Aus der Entfernung sieht es aus, als sei das Schiff bis an die Zähne bewaffnet. Ein Scan zeigt allerdings, dass die Hälfte der Waffen nur Attrappen sind. Gefährlich ist das Schiff aber dennoch.",
            "Der Name des Schiffes auf der Hülle wird eingerahmt von einer Komposition von Laserstrahlen und Rosendornen.",
        })
    end,
})