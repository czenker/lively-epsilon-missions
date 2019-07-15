local t = My.Translator.translate

-- two people want to communicate in secrecy with a code phrase. The players have to relay the phrase.

-- The phrase does not need to be translated, because it is a secret phrase anyway.
-- But if you are curious what it says:
-- The phrase is german and is a variation of the form "A blackbird sits on a tree in the woods". So it does not make any more sense in german. ;)
local secretPart1 = {
    "Der Adler",
    "Die Amsel",
    "Die Bachstelze",
    "Die Blaumeise",
    "Der Buchfink",
    "Der Buntspecht",
    "Der Bussard",
    "Die Dohle",
    "Der Dompfaff",
    "Die Drossel",
    "Das Eichelhäher",
    "Die Elster",
    "Der Gartenrotschwanz",
    "Der Grauschnäpper",
    "Der Grünfink",
    "Der Habicht",
    "Der Hausrotschwanz",
    "Die Heckenbraunelle",
    "Der Kleiber",
    "Die Kohlmeise",
    "Der Kolkrabe",
    "Der Kuckuck",
    "Der Mauersegler",
    "Die Nachtigal",
    "Die Nebelkrähe",
    "Der Papagei",
    "Das Rotkehlchen",
    "Die Schwalbe",
    "Der Sperling",
    "Der Star",
    "Die Taube",
    "Der Zaunkönig",
}

local secretPart2 = {
    "balzt",
    "baut",
    "beobachtet",
    "brütet",
    "frisst",
    "hält Ausschau",
    "kackt",
    "jagt",
    "nistet",
    "putzt sich",
    "rastet",
    "ruft",
    "ruht",
    "schläft",
    "sitzt",
    "trinkt",
    "versteckt sich",
    "wartet",
}

local secretPart3 = {
    "neben einem Baumstumpf",
    "auf dem Berggipfel",
    "im Geäst",
    "auf dem Giebel",
    "auf dem Hochspannungsmast",
    "auf dem Kirchendach",
    "in der Mauerspalte",
    "im Pfarrhaus",
    "auf einem Stein",
    "auf der Straßenlaterne",
    "auf der Tanne",
    "unter dem Vordach",
    "am Waldsee",
}

local createPhrases = function()
    local one, two, three = Util.randomSort(secretPart1), Util.randomSort(secretPart2), Util.randomSort(secretPart3)

    local answers = {}
    for i=1,2 do
        for j=1,2 do
            for k=1,2 do
                table.insert(answers, one[i] .. " " .. two[j] .. " " .. three[k] .. ".")
            end
        end
    end
    local correct = table.remove(answers)

    return correct, answers
end

local crewId = "secret_informant"


My = My or {}
My.SideMissions = My.SideMissions or {}

My.SideMissions.SecretCode = function(from, to)
    if not ShipTemplateBased:hasCrew(from) then ShipTemplateBased:withCrew(from) end
    if not ShipTemplateBased:hasCrew(to) then ShipTemplateBased:withCrew(to) end

    if not from:hasCrewAtPosition(crewId) then
        ShipTemplateBased:withCrew(from, { [crewId] = Person:newHuman() })
    end
    if not to:hasCrewAtPosition(crewId) then
        ShipTemplateBased:withCrew(to, { [crewId] = Person:newHuman() })
    end

    local fromPerson = from:getCrewAtPosition(crewId)
    local toPerson = to:getCrewAtPosition(crewId)
    local correctAnswer, wrongAnswers = createPhrases()
    local payment = My.SideMissions.paymentPerDistance(distance(from, to))

    local mission = Missions:answer(to,
        function(_, player)
            if player:isDocked(to) then
                return t("side_mission_secret_code_comms", toPerson, fromPerson)
            else
                return t("side_mission_secret_code_comms_not_docked", to:getCallSign())
            end
        end,
        t("side_mission_secret_code_comms_label", toPerson), {
        correctAnswer = function(mission)
            if mission:getPlayer():isDocked(to) then
                return correctAnswer
            else
                return -- don't accept answer if not docked
            end
        end,
        wrongAnswers = function(mission)
            if mission:getPlayer():isDocked(to) then
                return wrongAnswers
            else
                return -- don't accept answer if not docked
            end
        end,
        backLabel = t("generic_button_back"),
        correctAnswerResponse = t("side_mission_secret_code_success", payment),
        wrongAnswerResponse = t("side_mission_secret_code_failure", fromPerson),
        acceptCondition = function(self, error)
            if not self:getPlayer():isDocked(from) then
                return t("side_mission_secret_code_not_docked", from:getCallSign())
            else
                return true
            end
        end,
        onStart = function(self)
            self:setHint(t("side_mission_secret_code_hint", fromPerson, toPerson, to:getCallSign()))
        end,
        onSuccess = function(self)
            logInfo("Mission " .. self:getTitle() .. " successful.")
            self:getPlayer():addToShipLog(t("generic_mission_successful", self:getTitle()), "255,127,0")
            self:getPlayer():addReputationPoints(payment)
        end,
        onFailure = function(self)
            logInfo("Mission " .. self:getTitle() .. " failed.")
            if self:getPlayer():isValid() then
                self:getPlayer():addToShipLog(t("generic_mission_failed", self:getTitle()), "255,127,0")
            end
        end,
    })

    Mission:withBroker(mission, t("side_mission_secret_code", to:getCallSign()), {
        description = t("side_mission_secret_code_description", toPerson, to:getCallSign(), payment),
        acceptMessage = t("side_mission_secret_code_accept", fromPerson, correctAnswer),
    })

    Mission:forPlayer(mission)

    return mission
end