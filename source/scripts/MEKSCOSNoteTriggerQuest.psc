Scriptname MEKSCOSNoteTriggerQuest extends ObjectReference  

Quest Property MEKSCOSQuestSentientChairs  Auto  

Event OnRead()
    MEKSCOSQuestSentientChairs.Start()
    MEKSCOSQuestSentientChairs.SetObjectiveDisplayed(10)
    MEKSCOSQuestSentientChairs.SetStage(10)
EndEvent