local f = string.format

My.Translator:register("de", {
    side_mission_gather_crystals = function(nebulaName)
        return f("Kristalle in %s sammeln", nebulaName)
    end,
    side_mission_gather_crystals_description = function(person, amount, payment)
        return Util.random({
            "Hey Sie. Sind sie an Wissenschaft interessiert?",
            "Sie sehen nicht so aus als hätten sie ein Problem damit im Interesse der Wissenschaft einen kleinen Botengang zu absolvieren.",
        }) .. " " .. Util.random({
            "Meinen Namen haben Sie sicherlich schon in der Fachpresse gelesen.",
            "Ich bin ihnen sicher aus zahlreichen Publikationen bekannt.",
            "Bestimmt kennen sie mich aus meinen veröffentlichten Forschungsartikeln.",
        }) .. " " .. Util.random({
            "Nein? Nicht?",
            "Nein? Wirklich nicht?",
            "Wie? Sie haben noch nie von mir gehört?",
        }) .. " " .. Util.random({
            f("Nun gut, ich heiße %s.", person:getFormalName()),
            f("Dann prägen Sie sich den Namen \"%s\" gut ein.", person:getFormalName()),
        }) .. " " .. Util.random({
            "Die Kristallographieabteilung fällt in meine Zuständigkeit.",
            "Ich leite die Kristallographieabteilung.",
        }) .. "\n\n" ..
        "Zur Erforschung von " .. Util.random({
            "hexagonal-trapezoedrischen",
            "monoklin-prismatischen",
            "tetragonal-dipyramidalen",
            "triakistetraedrischen",
            "rhombendodekaedrischen",
            "deltoidikositetraedrischen",
        }) .. " " .. Util.random({
            "Kristallstrukturen", "Gitterstrukturen", "Diamantstrukturen", "Caesiumchloridstrukturen"
        }) .. " in " .. Util.random({
            "idiomorphen", "hypidiomorphen", "xenomorphen", "polymorphen", "translationssymmetrischen",
        }) .. " " .. Util.random({"Mineralien", "Kristallen"}) .. " benötige ich " .. amount .. " " .. Util.random({
            "Musterstücke", "Proben", "Untersuchungsgegenstände",
        }) .. ", die sich in der umgebenden " .. Util.random({
            "Molekülwolke", "Konzentration von Materie"
        }) .. " finden lassen.\n\n" .. Util.random({
            f("Die Wissenschaftswelt wird Ihnen mit %0.2fRP danken.", payment),
            f("Wie bitte? Eine Erwähnung in meinen Papern ist ihnen nicht Dank genug? Nun, sie Halsabschneider. Ich kann ihnen stattdessen auch %0.2fRP anbieten.", payment),
            f("Dafür, dass sie nicht darauf bestehen bei meiner Nobelpreis-Rede erwähnt zu werden zahle ich Ihnen %0.2fRP.", payment),
        })
    end,
    side_mission_gather_crystals_accept = function()
        return Util.random({
            "Im Namen der Wissenschaft danke ich Ihnen für Ihre Unterstützung.",
            "Ich werde mich nun wieder meinen Forschungen zu wenden.",
            "Was wollen Sie noch hier? Machen Sie sich an die Arbeit.",
        }) .. " " .. Util.random({
            "Ich habe einige Stellen markiert, wo sie im Nebel fündig werden können.",
            "Einige aussichtsreiche Stellen für Proben habe ich auf ihrer Karte markiert.",
        })
    end,

    side_mission_gather_crystals_artifact_name = "Kristall",
    side_mission_gather_crystals_artifact_description = "Ein Kristall", -- @TODO: description is pretty lame

    side_mission_gather_crystals_hint_ok = "Kristall eingesammelt",
    side_mission_gather_crystals_hint_gather = function(amount, stationCallSign)
        local msg = "Sammeln Sie noch "
        if amount > 1 then
            msg = msg .. f("%d Kristalle", amount)
        else
            msg = msg .. "einen Kristall"
        end
        msg = msg .. f(" und kehren Sie nach %s zurück.", stationCallSign)
        return msg
    end,
    side_mission_gather_crystals_hint_return = function(stationCallSign)
        return f("Liefern Sie die Kristalle in %s ab.", stationCallSign)
    end,
    side_mission_gather_crystals_success_comms = function(payment)
        return Util.random({
            "Oh, da haben Sie ja einige sehr schöne Kristalle gefunden. Die muss ich sofort untersuchen.",
            "Jetzt geben Sie mir die Kristalle. Schön sehen sie aus... Sehr schön... Diese Symmetrie... und Formschönheit......"
        }) .. " " ..
        Util.random({
            "Was bitte? Ach ihre Bezahlung?",
            "Warum stehen Sie neben mir und halten die Hand auf? Achso! Die vereinbarte Bezahlung.",
            "Soll ihr Räuspern mir etwas mitteilen? Achso, ihre Bezahlung.",
            "Wie bitte? Ich hab ihre Bezahlung vergessen?",
        }) .. " " .. Util.random({
            f("Was interessieren mich ihre menschlichen Bedürfnisse. Hier nehmen Sie schon die %0.2fRP.", payment),
            f("Wenn ihnen der wissenschaftliche Fortschritt gar nichts bedeutet, dann nehmen sie doch diese %0.2fRP aus meinem Forschungsetat.", payment),
            f("Kein Geld der Welt kann die Freude bezahlen, die einem die Kristallographie bringt. Insofern bedauere ich sehr, dass sie sich mit diesen %0.2fRP zufrieden müssen.", payment),
        }) .. "\n\n" .. Util.random({
            "Und jetzt raus hier. Ich habe zu arbeiten.",
            "Sie sind ja immer noch hier? Wie oft muss ich noch sagen: Ich brauche Ruhe zum Arbeiten. Verschwinden Sie jetzt!",
        })
    end,
})