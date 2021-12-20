Scriptname MEKSCOSMESetChairOutfitScript extends activemagiceffect  

FormList Property MEKSCOSHorseChairOutfitList  Auto
GlobalVariable Property MEKSCOSCurChairOutfitListItem  Auto
ReferenceAlias Property Alias_Horse Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
    ChangeChairOutifit(Alias_Horse.GetActorRef())
EndEvent

Function ChangeChairOutifit(Actor akTarget)
    int currentIndex = MEKSCOSCurChairOutfitListItem.GetValueInt()
    If (currentIndex >= MEKSCOSHorseChairOutfitList.GetSize())
        MEKSCOSCurChairOutfitListItem.SetValueInt(0)
        currentIndex = 0
    EndIf
    Debug.Trace(Self + ": Applying outfit index '" + currentIndex + "'")
    akTarget.SetOutfit(MEKSCOSHorseChairOutfitList.GetAt(currentIndex) as Outfit)
    MEKSCOSCurChairOutfitListItem.SetValueInt(currentIndex + 1)
EndFunction
