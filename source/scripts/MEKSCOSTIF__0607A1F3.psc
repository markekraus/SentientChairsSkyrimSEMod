;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname MEKSCOSTIF__0607A1F3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.GetPlayer().AddItem(MEKSCOSSentientChairsBook)
MEKSCOSGrumpyChairNoteSent.SetValue(1)
GetOwningQuest().SetStage(20)
GetOwningQuest().CompleteQuest()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property MEKSCOSGrumpyChairNoteSent  Auto  

Book Property MEKSCOSSentientChairsBook  Auto  
