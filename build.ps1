<#
.SYNOPSIS
    Creates FOMOD installer and Generates BBCODE version of Readme
.DESCRIPTION
    Creates FOMOD installer and Generates BBCODE version of Readme
.PARAMETER ConfigFile
    The path to the buildConfig.json used to build this mod
.NOTES
    Copyright 2021 Mark E. Kraus
#>
[CmdletBinding()]
param (
    [Parameter(
        Position=0,
        ValueFromPipelineByPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [string]
    $ConfigFile =
    $(
        if (![string]::IsNullOrWhitespace($PSScriptRoot)) {
            Join-Path $PSScriptRoot "buildConfig.json"
        }
        else {
            Join-Path $pwd.Path "buildConfig.json"
        }
    )
)
$StartTime = [datetime]::UtcNow
Write-Host ("Build started {0} UTC" -f $StartTime)
Write-Host " "

$BasePath = Split-Path $ConfigFile
Push-Location $BasePath

$FomodBasePath = Join-Path $BasePath "fomod"
$FomodInfoFile = Join-Path $FomodBasePath "info.xml"
$FomodModuleConfigFile = Join-Path $FomodBasePath "ModuleConfig.xml"

$Config = Get-Content -Path $ConfigFile | ConvertFrom-Json -Depth 10
$ModInfo = $Config.ModInfo
if([string]::IsNullOrWhiteSpace($Config.'$schema')) {
    Write-Error "config file is missing '`$schema'"
    exit 1
}
$Schema = (Invoke-WebRequest $Config.'$schema').Content
$SchemaIsValid = Get-Content -Path $ConfigFile -Raw | Test-Json -Schema $Schema
if(!$SchemaIsValid) {
    Write-Error "Invalid JSON Schema."
    exit 1
}


$FuzExtractorPath = Join-Path $Config.UnfuzerPath "Fuz_extractor.exe"
$XWmaEncodePath = Join-Path $Config.UnfuzerPath "xWMAEncode.exe"
$XWmaEncodeCmd = Get-Command $XWmaEncodePath

$Plugin = $Config.Plugin
$PluginPath = Join-Path $BasePath $Plugin
$BsaName = $Plugin -replace '\.esp$', '.bsa'
$ZipName = $Plugin -replace '\.esp$', '.zip'

$VoiceBasePath = Join-Path $BasePath 'Sound' 'Voice',$Plugin

Write-Host @"

BasePath:               $BasePath
FomodBasePath:          $FomodBasePath
FomodInfoFile:          $FomodInfoFile
FomodModuleConfigFile:  $FomodModuleConfigFile
VoiceBasePath:          $VoiceBasePath
FuzExtractorPath:       $FuzExtractorPath
XWmaEncodePath:         $XWmaEncodePath
PluginPath:             $PluginPath
BsaName:                $BsaName
ZipName:                $ZipName
"@

if (Test-Path $ZipName) {
    Write-Host "Deleting $ZipName"
    Remove-Item -Force $ZipName
}

$PluginXmlTemplate = @'

                        <plugin name="{0}">
                            <description>{1}</description>
                            <image path="{2}" />
                            <files>
                                <file source="{3}" destination="{3}" priority="0" />
                                <file source="{4}" destination="{4}" priority="0" />
                            </files>
                            <typeDescriptor>
                                <type name="Optional"/>
                            </typeDescriptor>
                        </plugin>
'@

$PluginPartXml = ""


$PluginPartXml = $PluginPartXml + ($PluginXmlTemplate -f @(
    $Plugin
    $ModInfo.Description
    $ModInfo.Logo
    $Plugin
    $BsaName
))


$ScriptSourceXmlTemplate = @'

                                <file source="{0}" destination="{0}" priority="0" />
'@
$ScriptsXmlPart=""

$PapyrusScripts = Get-ChildItem -Recurse *.psc
foreach ($papyrusScript in $PapyrusScripts) {
    $relPath = [Io.Path]::GetRelativePath($BasePath, $papyrusScript.FullName)
    $ScriptsXmlPart += $ScriptSourceXmlTemplate -f $relPath
}

$InfoXml = @'
<fomod>
    <Name>{0}</Name>
    <Author>{1}</Author>
    <Version>{2}</Version>
    <Website>{3}</Website>
    <Description>{4}</Description>
    <Groups>
        <element>{5}</element>
    </Groups>
</fomod>
'@ -f @(
    $ModInfo.Name
    $ModInfo.Author
    $ModInfo.Version
    $ModInfo.Website
    $ModInfo.Description
    $ModInfo.Category
)

$Null = New-Item -ItemType Directory -Path $FomodBasePath -Force
$InfoXml | Set-Content -Encoding utf8NoBOM -Path $FomodInfoFile



$ModuleConfigXML = @'
<!-- Created with build.ps1 by Mark E. Kraus --> 
<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://qconsulting.ca/fo3/ModConfig5.0.xsd"> 
    <moduleName>{0}</moduleName> 
    <installSteps order="Explicit"> 
        <installStep name="Install"> 
            <optionalFileGroups order="Explicit"> 
                <group name="Main" type="SelectExactlyOne"> 
                    <plugins order="Explicit">{1}
                    </plugins> 
                </group> 
                <group name="Install Script Sources?" type="SelectExactlyOne"> 
                    <plugins order="Explicit"> 
                        <plugin name="No (Default)"> 
                            <description>Skips installing script sources.</description>
                            <image path="{2}" />
                            <files></files>
                        <typeDescriptor> 
                            <type name="Optional"/> 
                        </typeDescriptor> 
                        </plugin>
                        <plugin name="Yes (For Mod Developers)"> 
                            <description>Installs script sources.</description>
                            <image path="{2}" />
                            <files>{3}
                            </files>
                            <typeDescriptor> 
                                <type name="Optional"/> 
                            </typeDescriptor> 
                        </plugin> 
                    </plugins> 
                </group> 
            </optionalFileGroups> 
        </installStep> 
    </installSteps> 
</config>
'@ -f @(
    $ModInfo.Name
    $PluginPartXml
    $ModInfo.Logo
    $ScriptsXmlPart
)

Write-Host @'
Converting Fuzzing Voice and Lip Files...

'@
if(Test-Path $VoiceBasePath) {
    Push-Location $VoiceBasePath
    foreach ($WavFile in (Get-ChildItem -Recurse -Filter '*.wav')) {
        Push-Location $WavFile.Directory
        Write-Host ([Io.Path]::GetRelativePath($VoiceBasePath, $WavFile))
        $XWmaFile = $WavFile.BaseName + '.xwm'
        $LipFile = $WavFile.BaseName + '.lip'
        $FuzFile = $WavFile.BaseName + '.fuz'
        $HashFile = $WavFile.BaseName + '.hash'
        $currentHash = (Get-FileHash $WavFile -Algorithm SHA256).Hash
        if ((Test-Path $HashFile) -and (Test-Path $FuzFile)) {
            $oldHash = Get-Content $HashFile -TotalCount 1
            if ($currentHash -eq $oldHash) {
                Write-Host "No change. Skipping..."
                Pop-Location
                continue
            }
        }
        else {
            $currentHash | Set-Content -Path $HashFile -Encoding utf8BOM -NoNewline
        }
        & $XWmaEncodeCmd $WavFile $XWmaFile
        if (Test-Path $LipFile) {
            & $FuzExtractorPath -i $FuzFile $XWmaFile /l
            # Remove-Item $LipFile -Force
        } else {
            & $FuzExtractorPath -i $FuzFile $XWmaFile
        }
        # Remove-Item $WavFile -Force
        Remove-Item $XWmaFile -Force
        Pop-Location
    }
    Pop-Location
}

$ModuleConfigXML | Set-Content -Encoding utf8NoBOM -Path $FomodModuleConfigFile

# Get-ChildItem -Recurse $VoiceBasePath

$bbcode = [System.Text.StringBuilder]::New()
$inList = $false

Copy-Item ".\README.md" "README.txt"
foreach ($Line in (Get-Content "README.md")) {
    if ($Line -match '^#[^#]') {
        $Line = $Line -replace '^# ','[size=6]'
        $Line = $Line + '[/size]'
    }
    elseif ($Line -match '^##[^#]') {
        $Line = $Line -replace '^## ','[size=5]'
        $Line = $Line + '[/size]'
    }
    elseif ($Line -match '^#') {
        $Line = $Line -replace '^#* ','[size=4]'
        $Line = $Line + '[/size]'
    }
    if ($inList -and $Line -notmatch '^\* ') {
        $inList = $false
        $null =  $bbcode.AppendLine('[/list]')
    }
    if (!$inList -and $Line -match '^\* ') {
        $inList = $true
        $null =  $bbcode.AppendLine('[list]')
    }
    if($inList -and $Line -match '^\* ') {
        $Line = $Line -replace '^\* ', '[*]'
    }
    $Line = $Line -replace '!\[[^)]*\)'
    $Line = $Line -replace '\[([^\]]*)\]\(([^)]*)\)', '[url=$2]$1[/url]'
    $Line = $Line -replace '`([^`]*)`', '[font=Courier New]$1[/font]'
    $null = $bbcode.AppendLine($Line)
}
$bbcode.ToString() | Set-Content -Encoding utf8NoBOM README.bbcode -NoNewline

Pop-Location
$EndTime = [datetime]::UtcNow
$Elapsed = ($EndTime - $StartTime).TotalSeconds
Write-Host @"

Build ended $EndTime UTC
$Elapsed (s)
"@