$oldFiles = @(
    "FixAudio\dialogueExportMEKSCOSQuestChairDialogue.old..txt"
    "FixAudio\dialogueExportMEKSCOSQuestMaleChairSassyDialogue.old.txt"
    "FixAudio\dialogueExportMEKSCOSQuestSentientChairs.old.txt"
)
$newFiles = @(
    "FixAudio\dialogueExportMEKSCOSQuestChairDialogue.txt"
    "FixAudio\dialogueExportMEKSCOSQuestMaleChairSassyDialogue.txt"
    "FixAudio\dialogueExportMEKSCOSQuestSentientChairs.txt"
)

$Old = Import-Csv -Delimiter "`t" -Path $oldFiles
$New = Import-Csv -Delimiter "`t" -Path $newFiles

$missing = [System.Collections.Generic.List[object]]::new()
$multiple = [System.Collections.Generic.List[object]]::new()
$fileNotFound = [System.Collections.Generic.List[object]]::new()
$lipNotFound = [System.Collections.Generic.List[object]]::new()

foreach ($oldEntry in $Old) {
    $newEntry = $New.Where({
        $_.'RESPONSE TEXT' -eq $oldEntry.'RESPONSE TEXT' -and
        $_.BRANCH -eq $oldEntry.BRANCH -and
        $_.QUEST -eq $oldEntry.QUEST -and
        $_.'VOICE TYPE' -eq $oldEntry.'VOICE TYPE' -and
        $_.CATEGORY -eq $oldEntry.CATEGORY
    })
    if ($newEntry.Count -lt 1) {
        $missing.Add($oldEntry)
    }
    elseif ($newEntry.Count -gt 1) {
        $multiple.Add($oldEntry)
    }
    else {
        $oldPath = $oldEntry.'FULL PATH' -replace '^Data\\'
        $newPath = $newEntry[0].'FULL PATH' -replace '^Data\\'
        $oldLip = $oldPath -replace '\.wav$', '.lip'
        $newLip = $newPath -replace '\.wav$', '.lip'
        'Old: {0}' -f $oldPath
        'New: {0}' -f $newPath
        'Old lip: {0}' -f $oldLip
        'New lip: {0}' -f $newLip
        ' '
        if (Test-Path $oldPath) {
            Move-Item -Path $oldPath -Destination $newPath -Force
        }
        else {
            $fileNotFound.Add($oldEntry)
            'Cant find file: {0}' -f $oldPath
        }
        if (Test-Path $oldLip) {
            Move-Item -Path $oldLip -Destination $newLip -Force
        }
        else {
            $lipNotFound.Add($oldEntry)
            'Cant find lip: {0}' -f $oldLip
        }
    }
}

' '
' '
' '
'Missing Matches:'
$missing.'RESPONSE TEXT'

' '
' '
'Multiple Matches:'
$multiple.'RESPONSE TEXT'

' '
' '
'WAV File not found:'
$fileNotFound.'RESPONSE TEXT'

' '
' '
'Lip File not found:'
$lipNotFound.'RESPONSE TEXT'