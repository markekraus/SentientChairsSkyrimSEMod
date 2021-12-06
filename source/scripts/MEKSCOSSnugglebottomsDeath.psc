Scriptname MEKSCOSSnugglebottomsDeath extends Actor

Quest Property MEKSCOSQuestSentientChairs Auto

Event OnDeath(Actor akKiller)
    If (MEKSCOSQuestSentientChairs.GetStage() < 20)
        MEKSCOSQuestSentientChairs.SetStage(30)
        MEKSCOSQuestSentientChairs.FailAllObjectives()
        MEKSCOSQuestSentientChairs.CompleteQuest()
    EndIf
EndEvent
