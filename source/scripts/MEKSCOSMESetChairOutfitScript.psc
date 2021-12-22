Scriptname MEKSCOSMESetChairOutfitScript extends activemagiceffect  

FormList Property MEKSCOSHorseChairOutfitList  Auto
GlobalVariable Property MEKSCOSCurChairOutfitListItem  Auto
GlobalVariable Property MEKSCOSChairHorseStyleSwapIntervalSeconds  Auto
ReferenceAlias Property Alias_Horse Auto
EffectShader Property DA02ArmorShadow Auto
bool Property IsConstant Auto

bool KeepUpdating = false

Event OnUpdate()
    If (KeepUpdating)
        ChangeChairOutifit(Alias_Horse.GetActorRef())
        RegisterForSingleUpdate(MEKSCOSChairHorseStyleSwapIntervalSeconds.GetValue())
    EndIf
EndEvent

Event OnEffectStart(Actor akTarget, Actor akCaster)
    If (IsConstant)
        KeepUpdating = true
        RegisterForSingleUpdate(MEKSCOSChairHorseStyleSwapIntervalSeconds.GetValue())
    Else
        ChangeChairOutifit(Alias_Horse.GetActorRef())
    EndIf
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    KeepUpdating = false
EndEvent

Function ChangeChairOutifit(Actor akTarget)
    int currentIndex = MEKSCOSCurChairOutfitListItem.GetValueInt()
    If (currentIndex >= MEKSCOSHorseChairOutfitList.GetSize())
        MEKSCOSCurChairOutfitListItem.SetValueInt(0)
        currentIndex = 0
    EndIf
    Debug.Trace(Self + ": Applying outfit index '" + currentIndex + "'")
    DA02ArmorShadow.Play(akTarget, 0.25)
    Utility.Wait(0.20)
    akTarget.SetOutfit(MEKSCOSHorseChairOutfitList.GetAt(currentIndex) as Outfit)
    MEKSCOSCurChairOutfitListItem.SetValueInt(currentIndex + 1)
EndFunction
