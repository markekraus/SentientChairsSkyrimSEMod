Scriptname MEKSCOSSummonChairHorse extends activemagiceffect  

ReferenceAlias Property Alias_Horse Auto
EffectShader Property DA02ArmorShadow Auto
Faction Property PlayerHorseFaction  Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
    If (Alias_Horse.GetActorRef().IsInFaction(PlayerHorseFaction))
        Alias_Horse.GetActorRef().MoveTo(Game.GetPlayer(), 0, -200, 0)
        DA02ArmorShadow.Play(Alias_Horse.GetActorRef(), 0.25)
        if (!Game.GetPlayer().HasLOS(Alias_Horse.GetActorRef()))
            Alias_Horse.GetActorRef().MoveTo(Game.GetPlayer(), 0, 200, 0)
        EndIf
        if (!Game.GetPlayer().HasLOS(Alias_Horse.GetActorRef()))
            Alias_Horse.GetActorRef().MoveTo(Game.GetPlayer(), 200, 0, 0)
        EndIf
        if (!Game.GetPlayer().HasLOS(Alias_Horse.GetActorRef()))
            Alias_Horse.GetActorRef().MoveTo(Game.GetPlayer(), -200, 0, 0)
        EndIf
    EndIf
EndEvent