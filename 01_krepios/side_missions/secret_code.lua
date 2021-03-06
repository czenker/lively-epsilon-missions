local t = My.Translator.translate

-- two people want to communicate in secrecy with a code phrase. The players have to relay the phrase.

local createSecrets = function(translationKey)
    local first = t(translationKey)
    for _=1,10 do
        local second = t(translationKey)
        if first ~= second then
            return {first, second}
        end
    end
    error(string.format("Could not find two distinct translations for \"%s\" after multiple tries.", translationKey))
end

local createPhrases = function()
    local one, two, three = createSecrets("side_mission_secret_code_part1"), createSecrets("side_mission_secret_code_part2"), createSecrets("side_mission_secret_code_part3")

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
            self:getPlayer():addReputationPoints(payment)
        end,
    })

    Mission:withBroker(mission, t("side_mission_secret_code", to:getCallSign()), {
        description = t("side_mission_secret_code_description", toPerson, to:getCallSign(), payment),
        acceptMessage = t("side_mission_secret_code_accept", fromPerson, correctAnswer),
    })

    Mission:forPlayer(mission)

    return mission
end