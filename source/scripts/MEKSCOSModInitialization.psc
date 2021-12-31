Scriptname MEKSCOSModInitialization extends Quest  

Weapon Property MEKSCOSWeapCommonChair02 Auto
Weapon Property MEKSCOSWeapWoodenChair01 Auto
Weapon Property MEKSCOSWeapOrcishChair01 Auto
Weapon Property MEKSCOSWeapDwarvenChair01 Auto
Weapon Property MEKSCOSWeapElvenChair01 Auto
Weapon Property MEKSCOSWeapGlassThrone01 Auto
Weapon Property MEKSCOSWeapEbonyThrone01 Auto
Weapon Property MEKSCOSWeapDaedricThrone01 Auto
Weapon Property DaedricWarhammer Auto


LeveledItem Property LItemWeaponDwarvenWarhammer Auto
LeveledItem Property LItemwerewolfBossWarhammer Auto
LeveledItem Property LItemSoldierSonsWarhammer Auto
LeveledItem Property LItemWeaponWarhammerTown Auto
LeveledItem Property LItemWeaponWarhammer Auto
LeveledItem Property LItemBanditWarhammer Auto
LeveledItem Property DLC2LItemWeaponWarhammerTown Auto
LeveledItem Property DLC2LItemWeaponWarhammer Auto
LeveledItem Property LItemWeaponWarhammerSpecial Auto
LeveledItem Property LItemOrcStrongholdWarhammer Auto
LeveledItem Property LItemWeaponWarhammerBlacksmith Auto
LeveledItem Property LItemWeaponWarhammerBest Auto
LeveledItem Property LItemBanditBossWarhammer Auto
LeveledItem Property DLC2LItemWeaponWarhammerDremora Auto
LeveledItem Property SublistWeaponWarhammerDaedricBest05 Auto
LeveledItem Property SublistWeaponWarhammerDaedric05 Auto
LeveledItem Property DLC1LItemDaedricWeapon Auto
LeveledItem Property LItemDraugr05EWeapon2H Auto

float Property StoredModVersion = 0.0 Auto
float Property StoredImmersiveWeaponsVersion = 0.0 Auto
float Property StoredBaseLeveledListsVersion = 0.0 Auto
float Property StoredValdacilsItemSortingVersion = 0.0 Auto

int ItemsAdded = 0
int ItemsAttempted = 0
string ImmersiveWeapons = "Immersive Weapons.esp"
string ValdacilsItemSorting = "ValdacilsItemSorting.esp"
string UpdateText = "Sentient Chairs of Skyrim Updated to "

Event OnInit()
    RegisterForSingleUpdate(15.0)
EndEvent

Event OnUpdate()
    If (StoredModVersion < 4.1)
        Maintenance()
        Debug.Notification(UpdateText + "4.1")
    EndIf
EndEvent

Function Maintenance()
    Debug.Trace("[SCOS] =================Maintenance Start=================")
    UpdateBaseLeveledLists4_1()
    UpdateImmersvieWeapons4_1()
    UpdateValdacilsItemSorting4_1()
    Debug.Trace("[SCOS] =================Maintenance End===================")
EndFunction

Function UpdateItemList(LeveledItem itemList, Form addItem, int itemLevel, int itemCount, int repeat = 1)
    int index = 0
    ; Try adding the item to Leveled Item List repeat number of times
    While (index < repeat)
        ItemsAttempted += 1
        ; Leveled Lists can only have a max of 255 items, so skip if the list is full
        If (itemList.GetNumForms() == 255)
            ; break out of repeat loop
            index = repeat
            Debug.Trace("[SCOS] Skipping adding '" + addItem + "' to '" + itemList + "'. The list is full")
        Else
            Debug.Trace("[SCOS] Adding '" + addItem + "' Level '" + itemLevel + "' count '" + itemCount + "' to '" + itemList + "'")
            itemList.AddForm(addItem, itemLevel, itemCount)
            ItemsAdded += 1
        EndIf
        index += 1
    EndWhile
EndFunction

Function UpdateRemoteItemList(string ModName, int FormID, Form addItem, int itemLevel, int itemCount, int repeat = 1)
    Form listForm = Game.GetFormFromFile(FormID, ModName)
    If (listForm == None)
        ItemsAttempted += 1
        Debug.Trace("[SCOS] Unable to find FormID '" + FormID + "' from '" + ModName + "' Skipping adding '" + addItem + "'" )
        Return
    EndIf
    UpdateItemList(listForm as LeveledItem, addItem, itemLevel, itemCount, repeat)
EndFunction

Function RenameWeaponValdacilsItemSorting(Weapon WeaponToRename)
    string prefix = "[2H Blunt] "
    string oldName = WeaponToRename.GetName()
    If (StringUtil.Find(oldName, prefix) != -1)
        Debug.Trace("[SCOS] '" + oldName + "' is already correct on '" + WeaponToRename + "'")
        Return
    EndIf
    string newName = prefix + oldName
    Debug.Trace("[SCOS] Renaming '" + oldName + "' to '" + newName + "' on '" + WeaponToRename + "'")
    WeaponToRename.SetName(newName)
EndFunction

Function UpdateBaseLeveledLists4_1()
    If (StoredBaseLeveledListsVersion < 4.1)
        StoredBaseLeveledListsVersion = 4.1
    Else
        Return
    EndIf
    Debug.Trace("[SCOS] ==========Updating Base Game Leveled Lists=========")
    UpdateItemList(LItemWeaponDwarvenWarhammer, MEKSCOSWeapCommonChair02, 1, 1, 2)
    UpdateItemList(LItemWeaponDwarvenWarhammer, MEKSCOSWeapWoodenChair01, 3, 1, 1)
    UpdateItemList(LItemWeaponDwarvenWarhammer, MEKSCOSWeapWoodenChair01, 4, 1, 1)
    UpdateItemList(LItemWeaponDwarvenWarhammer, MEKSCOSWeapWoodenChair01, 5, 1, 1)
    UpdateItemList(LItemWeaponDwarvenWarhammer, MEKSCOSWeapWoodenChair01, 6, 1, 1)
    UpdateItemList(LItemWeaponDwarvenWarhammer, MEKSCOSWeapDwarvenChair01, 12, 1, 1)
    UpdateItemList(LItemWeaponDwarvenWarhammer, MEKSCOSWeapDwarvenChair01, 13, 1, 1)
    UpdateItemList(LItemWeaponDwarvenWarhammer, MEKSCOSWeapDwarvenChair01, 14, 1, 1)
    UpdateItemList(LItemWeaponDwarvenWarhammer, MEKSCOSWeapDwarvenChair01, 15, 1, 1)
    
    UpdateItemList(LItemwerewolfBossWarhammer, MEKSCOSWeapCommonChair02, 1, 1, 1)
    UpdateItemList(LItemwerewolfBossWarhammer, MEKSCOSWeapWoodenChair01, 1, 1, 1)
    UpdateItemList(LItemwerewolfBossWarhammer, MEKSCOSWeapOrcishChair01, 6, 1, 1)
    UpdateItemList(LItemwerewolfBossWarhammer, MEKSCOSWeapDwarvenChair01, 12, 1, 1)
    UpdateItemList(LItemwerewolfBossWarhammer, MEKSCOSWeapElvenChair01, 19, 1, 1)
    UpdateItemList(LItemwerewolfBossWarhammer, MEKSCOSWeapGlassThrone01, 27, 1, 1)
    UpdateItemList(LItemwerewolfBossWarhammer, MEKSCOSWeapEbonyThrone01, 36, 1, 1)

    UpdateItemList(LItemSoldierSonsWarhammer, MEKSCOSWeapCommonChair02, 1, 1, 2)
    UpdateItemList(LItemSoldierSonsWarhammer, MEKSCOSWeapWoodenChair01, 4, 1, 1)
    UpdateItemList(LItemSoldierSonsWarhammer, MEKSCOSWeapWoodenChair01, 5, 1, 1)
    UpdateItemList(LItemSoldierSonsWarhammer, MEKSCOSWeapWoodenChair01, 6, 1, 1)
    UpdateItemList(LItemSoldierSonsWarhammer, MEKSCOSWeapWoodenChair01, 7, 1, 1)
    UpdateItemList(LItemSoldierSonsWarhammer, MEKSCOSWeapWoodenChair01, 10, 1, 1)
    UpdateItemList(LItemSoldierSonsWarhammer, MEKSCOSWeapWoodenChair01, 11, 1, 1)
    UpdateItemList(LItemSoldierSonsWarhammer, MEKSCOSWeapWoodenChair01, 12, 1, 1)
    UpdateItemList(LItemSoldierSonsWarhammer, MEKSCOSWeapWoodenChair01, 13, 1, 1)

    UpdateItemList(LItemWeaponWarhammerTown, MEKSCOSWeapCommonChair02, 1, 1, 2)
    UpdateItemList(LItemWeaponWarhammerTown, MEKSCOSWeapWoodenChair01, 4, 1, 1)
    UpdateItemList(LItemWeaponWarhammerTown, MEKSCOSWeapWoodenChair01, 5, 1, 1)
    UpdateItemList(LItemWeaponWarhammerTown, MEKSCOSWeapWoodenChair01, 6, 1, 1)
    UpdateItemList(LItemWeaponWarhammerTown, MEKSCOSWeapWoodenChair01, 7, 1, 1)
    UpdateItemList(LItemWeaponWarhammerTown, MEKSCOSWeapOrcishChair01, 13, 1, 1)
    UpdateItemList(LItemWeaponWarhammerTown, MEKSCOSWeapDwarvenChair01, 18, 1, 1)
    UpdateItemList(LItemWeaponWarhammerTown, MEKSCOSWeapElvenChair01, 23, 1, 1)

    UpdateItemList(LItemWeaponWarhammer, MEKSCOSWeapCommonChair02, 1, 1, 2)
    UpdateItemList(LItemWeaponWarhammer, MEKSCOSWeapWoodenChair01, 2, 1, 1)
    UpdateItemList(LItemWeaponWarhammer, MEKSCOSWeapWoodenChair01, 3, 1, 1)
    UpdateItemList(LItemWeaponWarhammer, MEKSCOSWeapWoodenChair01, 4, 1, 1)
    UpdateItemList(LItemWeaponWarhammer, MEKSCOSWeapOrcishChair01, 6, 1, 1)
    UpdateItemList(LItemWeaponWarhammer, MEKSCOSWeapDwarvenChair01, 12, 1, 1)
    UpdateItemList(LItemWeaponWarhammer, MEKSCOSWeapElvenChair01, 19, 1, 1)
    UpdateItemList(LItemWeaponWarhammer, MEKSCOSWeapGlassThrone01, 27, 1, 1)
    UpdateItemList(LItemWeaponWarhammer, MEKSCOSWeapEbonyThrone01, 36, 1, 1)

    UpdateItemList(LItemBanditWarhammer, MEKSCOSWeapCommonChair02, 1, 1, 1)
    UpdateItemList(LItemBanditWarhammer, MEKSCOSWeapWoodenChair01, 1, 1, 1)
    UpdateItemList(LItemBanditWarhammer, MEKSCOSWeapCommonChair02, 1, 1, 1)
    UpdateItemList(LItemBanditWarhammer, MEKSCOSWeapWoodenChair01, 1, 1, 1)
    UpdateItemList(LItemBanditWarhammer, MEKSCOSWeapOrcishChair01, 9, 1, 1)
    UpdateItemList(LItemBanditWarhammer, MEKSCOSWeapDwarvenChair01, 15, 1, 1)
    UpdateItemList(LItemBanditWarhammer, MEKSCOSWeapElvenChair01, 22, 1, 1)

    UpdateItemList(DLC2LItemWeaponWarhammerTown, MEKSCOSWeapCommonChair02, 1, 1, 2)
    UpdateItemList(DLC2LItemWeaponWarhammerTown, MEKSCOSWeapWoodenChair01, 4, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammerTown, MEKSCOSWeapWoodenChair01, 5, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammerTown, MEKSCOSWeapWoodenChair01, 6, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammerTown, MEKSCOSWeapWoodenChair01, 7, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammerTown, MEKSCOSWeapOrcishChair01, 13, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammerTown, MEKSCOSWeapDwarvenChair01, 18, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammerTown, MEKSCOSWeapElvenChair01, 23, 1, 1)
    
    UpdateItemList(DLC2LItemWeaponWarhammer, MEKSCOSWeapCommonChair02, 1, 1, 2)
    UpdateItemList(DLC2LItemWeaponWarhammer, MEKSCOSWeapWoodenChair01, 2, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammer, MEKSCOSWeapWoodenChair01, 3, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammer, MEKSCOSWeapWoodenChair01, 4, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammer, MEKSCOSWeapOrcishChair01, 6, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammer, MEKSCOSWeapElvenChair01, 19, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammer, MEKSCOSWeapGlassThrone01, 27, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammer, MEKSCOSWeapEbonyThrone01, 36, 1, 1)

    UpdateItemList(LItemWeaponWarhammerSpecial, MEKSCOSWeapWoodenChair01, 1, 1, 1)
    UpdateItemList(LItemWeaponWarhammerSpecial, MEKSCOSWeapOrcishChair01, 6, 1, 1)
    UpdateItemList(LItemWeaponWarhammerSpecial, MEKSCOSWeapDwarvenChair01, 12, 1, 1)
    UpdateItemList(LItemWeaponWarhammerSpecial, MEKSCOSWeapElvenChair01, 19, 1, 1)
    UpdateItemList(LItemWeaponWarhammerSpecial, MEKSCOSWeapGlassThrone01, 27, 1, 1)
    UpdateItemList(LItemWeaponWarhammerSpecial, MEKSCOSWeapEbonyThrone01, 36, 1, 1)

    UpdateItemList(LItemOrcStrongholdWarhammer, MEKSCOSWeapWoodenChair01, 1, 1, 1)
    UpdateItemList(LItemOrcStrongholdWarhammer, MEKSCOSWeapOrcishChair01, 6, 1, 1)

    UpdateItemList(LItemWeaponWarhammerBlacksmith, MEKSCOSWeapWoodenChair01, 1, 1, 2)
    UpdateItemList(LItemWeaponWarhammerBlacksmith, MEKSCOSWeapOrcishChair01, 6, 1, 1)
    UpdateItemList(LItemWeaponWarhammerBlacksmith, MEKSCOSWeapDwarvenChair01, 12, 1, 1)
    UpdateItemList(LItemWeaponWarhammerBlacksmith, MEKSCOSWeapElvenChair01, 19, 1, 1)
    UpdateItemList(LItemWeaponWarhammerBlacksmith, MEKSCOSWeapGlassThrone01, 27, 1, 1)
    UpdateItemList(LItemWeaponWarhammerBlacksmith, MEKSCOSWeapEbonyThrone01, 36, 1, 1)

    UpdateItemList(LItemWeaponWarhammerBest, MEKSCOSWeapWoodenChair01, 1, 1, 2)
    UpdateItemList(LItemWeaponWarhammerBest, MEKSCOSWeapOrcishChair01, 6, 1, 1)
    UpdateItemList(LItemWeaponWarhammerBest, MEKSCOSWeapDwarvenChair01, 12, 1, 1)
    UpdateItemList(LItemWeaponWarhammerBest, MEKSCOSWeapElvenChair01, 19, 1, 1)
    UpdateItemList(LItemWeaponWarhammerBest, MEKSCOSWeapGlassThrone01, 27, 1, 1)
    UpdateItemList(LItemWeaponWarhammerBest, MEKSCOSWeapEbonyThrone01, 36, 1, 1)

    UpdateItemList(LItemBanditBossWarhammer, MEKSCOSWeapWoodenChair01, 1, 1, 1)
    UpdateItemList(LItemBanditBossWarhammer, MEKSCOSWeapOrcishChair01, 6, 1, 1)
    UpdateItemList(LItemBanditBossWarhammer, MEKSCOSWeapDwarvenChair01, 12, 1, 1)
    UpdateItemList(LItemBanditBossWarhammer, MEKSCOSWeapElvenChair01, 19, 1, 1)
    UpdateItemList(LItemBanditBossWarhammer, MEKSCOSWeapGlassThrone01, 27, 1, 1)
    UpdateItemList(LItemBanditBossWarhammer, MEKSCOSWeapEbonyThrone01, 36, 1, 1)

    UpdateItemList(DLC2LItemWeaponWarhammerDremora, MEKSCOSWeapWoodenChair01, 1, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammerDremora, MEKSCOSWeapOrcishChair01, 6, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammerDremora, MEKSCOSWeapDwarvenChair01, 13, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammerDremora, MEKSCOSWeapElvenChair01, 21, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammerDremora, MEKSCOSWeapGlassThrone01, 30, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammerDremora, MEKSCOSWeapEbonyThrone01, 40, 1, 1)
    UpdateItemList(DLC2LItemWeaponWarhammerDremora, MEKSCOSWeapDaedricThrone01, 51, 1, 1)

    UpdateItemList(SublistWeaponWarhammerDaedricBest05, MEKSCOSWeapDaedricThrone01, 1, 1, 1)

    UpdateItemList(SublistWeaponWarhammerDaedric05, MEKSCOSWeapDaedricThrone01, 1, 1, 1)

    UpdateItemList(DLC1LItemDaedricWeapon, MEKSCOSWeapEbonyThrone01, 1, 1, 4)
    UpdateItemList(DLC1LItemDaedricWeapon, MEKSCOSWeapDaedricThrone01, 1, 1, 2)
    UpdateItemList(DLC1LItemDaedricWeapon, DaedricWarhammer, 1, 1, 2)

    UpdateItemList(LItemDraugr05EWeapon2H, MEKSCOSWeapEbonyThrone01, 1, 1, 1)

    Debug.Trace("[SCOS] ItemsAttemped: " + ItemsAttempted)
    Debug.Trace("[SCOS] ItemsAdded: " + ItemsAdded)
    Debug.Trace("[SCOS] ==========Base Game Leveled Lists Updated==========")
EndFunction

Function UpdateImmersvieWeapons4_1()
    If (Game.GetModByName(ImmersiveWeapons) == 255)
        Return
    EndIf
    If (StoredImmersiveWeaponsVersion < 4.1)
        StoredImmersiveWeaponsVersion = 4.1
    Else
        Return
    EndIf
    Debug.Trace("[SCOS] Immersive Armors Detected. Updating leveled lists")

    int IWLIWeaponWarhammer = 0x0001CB26
    UpdateRemoteItemList(ImmersiveWeapons, IWLIWeaponWarhammer, MEKSCOSWeapWoodenChair01, 1, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIWeaponWarhammer, MEKSCOSWeapOrcishChair01, 6, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIWeaponWarhammer, MEKSCOSWeapDwarvenChair01, 13, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIWeaponWarhammer,  MEKSCOSWeapElvenChair01, 21, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIWeaponWarhammer,  MEKSCOSWeapGlassThrone01, 30, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIWeaponWarhammer,  MEKSCOSWeapEbonyThrone01, 40, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIWeaponWarhammer,  MEKSCOSWeapDaedricThrone01, 51, 1, 1)

    int IWLIBanditWarhammer = 0x0001D603
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBanditWarhammer, MEKSCOSWeapWoodenChair01, 1, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBanditWarhammer, MEKSCOSWeapOrcishChair01, 6, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBanditWarhammer, MEKSCOSWeapDwarvenChair01, 13, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBanditWarhammer,  MEKSCOSWeapElvenChair01, 21, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBanditWarhammer,  MEKSCOSWeapGlassThrone01, 30, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBanditWarhammer,  MEKSCOSWeapEbonyThrone01, 40, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBanditWarhammer,  MEKSCOSWeapDaedricThrone01, 51, 1, 1)

    int IWLISoldierSonsWeapon2H = 0x0001F0F6
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H, MEKSCOSWeapWoodenChair01, 1, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H, MEKSCOSWeapOrcishChair01, 6, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H, MEKSCOSWeapDwarvenChair01, 13, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H,  MEKSCOSWeapElvenChair01, 21, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H,  MEKSCOSWeapGlassThrone01, 30, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H,  MEKSCOSWeapEbonyThrone01, 40, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H,  MEKSCOSWeapDaedricThrone01, 51, 1, 1)

    int IWLITownWarhammer = 0x000365C4
    UpdateRemoteItemList(ImmersiveWeapons, IWLITownWarhammer, MEKSCOSWeapCommonChair02, 1, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLITownWarhammer, MEKSCOSWeapWoodenChair01, 2, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLITownWarhammer, MEKSCOSWeapOrcishChair01, 6, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLITownWarhammer, MEKSCOSWeapDwarvenChair01, 13, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLITownWarhammer,  MEKSCOSWeapElvenChair01, 21, 1, 1)

    int IWLI_ListWarhammer = 0x00039B9E
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H, MEKSCOSWeapWoodenChair01, 1, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H, MEKSCOSWeapOrcishChair01, 6, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H, MEKSCOSWeapDwarvenChair01, 13, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H,  MEKSCOSWeapElvenChair01, 21, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H,  MEKSCOSWeapGlassThrone01, 30, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H,  MEKSCOSWeapEbonyThrone01, 40, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLISoldierSonsWeapon2H,  MEKSCOSWeapDaedricThrone01, 51, 1, 1)

    int IWLIBoss2H = 0x0003FCB7
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBoss2H, MEKSCOSWeapWoodenChair01, 1, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBoss2H, MEKSCOSWeapOrcishChair01, 6, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBoss2H, MEKSCOSWeapDwarvenChair01, 13, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBoss2H,  MEKSCOSWeapElvenChair01, 21, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBoss2H,  MEKSCOSWeapGlassThrone01, 30, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBoss2H,  MEKSCOSWeapEbonyThrone01, 40, 1, 1)

    int IWLIBlacksmithWarhammer = 0x00040CF6
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBlacksmithWarhammer, MEKSCOSWeapWoodenChair01, 1, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBlacksmithWarhammer, MEKSCOSWeapOrcishChair01, 6, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBlacksmithWarhammer, MEKSCOSWeapDwarvenChair01, 13, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBlacksmithWarhammer,  MEKSCOSWeapElvenChair01, 21, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBlacksmithWarhammer,  MEKSCOSWeapGlassThrone01, 30, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBlacksmithWarhammer,  MEKSCOSWeapEbonyThrone01, 40, 1, 1)

    int IWLIBestWarhammer = 0x00040CF7
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBestWarhammer, MEKSCOSWeapWoodenChair01, 1, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBestWarhammer, MEKSCOSWeapOrcishChair01, 6, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBestWarhammer, MEKSCOSWeapDwarvenChair01, 13, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBestWarhammer,  MEKSCOSWeapElvenChair01, 21, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBestWarhammer,  MEKSCOSWeapGlassThrone01, 30, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIBestWarhammer,  MEKSCOSWeapEbonyThrone01, 40, 1, 1)

    int IWLIVRareWarhammerBest = 0x0004125C
    UpdateRemoteItemList(ImmersiveWeapons, IWLIVRareWarhammerBest,  MEKSCOSWeapDaedricThrone01, 1, 1, 1)

    int IWLIOrcWarhammer = 0x000417C1
    UpdateRemoteItemList(ImmersiveWeapons, IWLIOrcWarhammer, MEKSCOSWeapOrcishChair01, 6, 1, 1)

    int IWLIDraugr2H = 0x000417C7
    UpdateRemoteItemList(ImmersiveWeapons, IWLIDraugr2H, MEKSCOSWeapWoodenChair01, 1, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIDraugr2H, MEKSCOSWeapOrcishChair01, 6, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIDraugr2H, MEKSCOSWeapDwarvenChair01, 13, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIDraugr2H,  MEKSCOSWeapElvenChair01, 21, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIDraugr2H,  MEKSCOSWeapGlassThrone01, 30, 1, 1)
    UpdateRemoteItemList(ImmersiveWeapons, IWLIDraugr2H,  MEKSCOSWeapEbonyThrone01, 40, 1, 1)

    int IWLIEbony2H = 0x000417CA
    UpdateRemoteItemList(ImmersiveWeapons, IWLIDraugr2H,  MEKSCOSWeapEbonyThrone01, 1, 1, 1)

    Debug.Trace("[SCOS] Immersive Armors leveled lists updated.")
EndFunction

Function UpdateValdacilsItemSorting4_1()
    If (Game.GetModByName(ValdacilsItemSorting) == 255)
        Return
    EndIf
    If (StoredValdacilsItemSortingVersion < 4.1)
        StoredValdacilsItemSortingVersion = 4.1
    Else
        Return
    EndIf

    Debug.Trace("[SCOS] Valdacil's Item Sorting Detected. Updating Weapon Names")
    RenameWeaponValdacilsItemSorting(MEKSCOSWeapCommonChair02)
    RenameWeaponValdacilsItemSorting(MEKSCOSWeapDaedricThrone01)
    RenameWeaponValdacilsItemSorting(MEKSCOSWeapDwarvenChair01)
    RenameWeaponValdacilsItemSorting(MEKSCOSWeapEbonyThrone01)
    RenameWeaponValdacilsItemSorting(MEKSCOSWeapElvenChair01)
    RenameWeaponValdacilsItemSorting(MEKSCOSWeapGlassThrone01)
    RenameWeaponValdacilsItemSorting(MEKSCOSWeapOrcishChair01)
    RenameWeaponValdacilsItemSorting(MEKSCOSWeapWoodenChair01)
    Debug.Trace("[SCOS] Valdacil's Item Sorting Names Set")
EndFunction