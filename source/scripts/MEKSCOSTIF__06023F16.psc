;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname MEKSCOSTIF__06023F16 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
If (MEKSCOSGrumpyChairNoteSent.GetValue() != 1 )
    CourierNote.ForceRefTo(Game.GetPlayer().PlaceAtMe(MEKSCOSGrumpyChairNote))
    (WICourier as WICourierScript).AddAliasToContainer(CourierNote)
    MEKSCOSGrumpyChairNoteSent.SetValue(1)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property MEKSCOSGrumpyChairNoteSent Auto
Book Property MEKSCOSGrumpyChairNote Auto
Quest Property WICourier Auto
ReferenceAlias Property CourierNote Auto