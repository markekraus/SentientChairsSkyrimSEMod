;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname MEKSCOSTIF__06000B32 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.GetPlayer().RemoveItem(Gold001, MEKSCOSRingOfChairHorseChangingCost.value as int)
Game.GetPlayer().AddItem(MEKSCOSRingOfChairHorseChanging, 1)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property MEKSCOSRingOfChairHorseChangingCost  Auto  

MiscObject Property Gold001  Auto  

Armor Property MEKSCOSRingOfChairHorseChanging  Auto  
