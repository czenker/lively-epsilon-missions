local f = string.format
local t = My.Translator.translate

My.Translator:register("de", {
    side_mission_arena = "Kampf in der Arena",
    side_mission_arena_description = function(tinkererPerson, payment)
        return "Hey ihr." .. " " ..
        Util.random({
            "Das Volk fordert unterhalten zu werden!",
            "In dem Sektor ist es in letzter Zeit langweilig geworden.",
        }) .. "\n" ..
        Util.random({
            "Wollt ihr gegen ein paar Dronen in der Arena kämpfen?",
            f("Zum Glück hat %s ein paar Dronen gebaut. Seid ihr in der Lage sie in der Arena zu besiegen?", tinkererPerson:getNickName()),
        }) .. " " ..
        Util.random({
            f("Ihr bekommt %0.2fRP, wenn ihr sie alle besiegt ohne zu viel Schaden zu nehmen.", payment),
            f("Der Gewinner bekommt %0.2fRP.", payment),
            f("Wenn ihr gut kämpft und alle Feinde besiegt, erhaltet ihr %0.2fRP.", payment),
        })
    end,
    side_mission_arena_accept = function(sectorName)
        return "Hier sind die Regeln:\n\n" ..
        " * Ihr kämpft gegen Maschinen. Es gibt keinen Grund zimperlich mit ihnen umzugehen. Wenn ihr alle zerstört, habt ihr gewonnen.\n" ..
        " * Falls eure Hülle unter 10% fällt wird der Kampf beendet und ihr verliert.\n" ..
        " * Falls ihr die Arena verlasst, wird der Kampf beendet und ihr verliert.\n\n" ..
        f("Beginnt den Kampf indem ihr in die Arena in Sektor %s fliegt. Kommt vorbereitet.", sectorName)
    end,
    side_mission_arena_goto_hint = function(sectorName)
        return "Fliegt in die Arena in Sektor " .. sectorName .. " und seid für einen Kampf vorbereitet"
    end,
    side_mission_arena_fight_hint = "Zerstört alle Feinde in der Arena ohne sie zu verlassen",
    side_mission_arena_fight_warning = "!!!Bleibt innerhalb der Arena oder die Mission ist verloren!!!",
    side_mission_arena_fight_warning = "!!!Stay inside the Arena or the mission will be lost!!!",

    side_mission_arena_success = function(stationName, payment)
        return Util.random({
            "Das war erstklassige Unterhaltung von euch in der Arena.",
            "Beeindruckend, wie ihr mit dem Kampf klar gekommen seid.",
        }) .. " " .. Util.random({
            "Ihr habt kurzen Prozess mit den Dronen gemacht.",
            "Ihr habt es den Dronen nicht leicht gemacht.",
            "Gegen euch hatten die Dronen keine Chance.",
        }) .. "\n\n" .. Util.random({
            f("Hier ist eure Bezahlung von %0.2fRP.", payment),
            f("Eure Bezahlung von %0.2fRP wurde bereits übertragen.", payment),
        }) .. " " .. Util.random({
            f("Falls ihr nach %s zurück kehrt, macht einen Abstecher in die Bar. Ein paar Leute wollen euch da einen Drink spendieren.", stationName),
            "Und seid nicht böse auf die Leute, die auf die Dronen gewettet haben. Ich bin mir sicher das war nichts persönliches.",
        })
    end,
    side_mission_arena_failure = function(tinkererPerson)
        return Util.random({
            "Sehr unglücklich gelaufen für euch.",
            "Oooh - das war Pech."
        }) .. " " .. Util.random({
            "Die Dronen hatten euch in der Zange.",
            "Dieser Herausforderung wart ihr nicht gewachsen.",
            f("Die Dronen von %s sind einfach zu gut.", tinkererPerson:getNickName()),
        }) .. " " .. Util.random({
            "Aber wenigstens wurde die Menge unterhalten.",
            "Mehr Glück bei eurem nächsten Versuch.",
            "Wenn ihr Reparaturen durchgeführt habt, könnt ihr es ja noch mal versuchen."
        }) .. " " .. Util.random({
            f("Ich will nur hoffen, dass %s das Preisgeld nicht wieder für etwas explosives ausgibt.", tinkererPerson:getNickName()),
            f("%s scheint sich über das Preisgeld gefreut zu haben.", tinkererPerson:getNickName()),
            f("Habt ihr gewusst, dass das Preisgeld einen Großteil von %s Forschung finanziert?", Names.possessive(tinkererPerson:getNickName()))
        })
    end,
})