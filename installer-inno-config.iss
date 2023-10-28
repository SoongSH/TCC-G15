; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Thermal Control Center"
#define MyAppVersion "1.5.0"
#define MyAppPublisher "AlexIII"
#define MyAppURL "https://github.com/AlexIII/tcc-g15"
#define MyAppExeName "tcc-g15.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{8009F57D-B404-4274-BB42-A8AEBB02F37F}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DisableProgramGroupPage=yes
LicenseFile=.\LICENSE
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
OutputDir=.\dist
OutputBaseFilename="tcc-g15-installer-{#MyAppVersion}"
SetupIconFile=.\icons\gaugeIcon.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"

[Files]
Source: ".\dist\tcc-g15\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: ".\dist\tcc-g15\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon; AfterInstall: SetElevationBit('{autodesktop}\{#MyAppName}.lnk')

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait skipifsilent

[Code]
procedure SetElevationBit(Filename: string);
var
  Buffer: string;
  Stream: TStream;
begin
  Filename := ExpandConstant(Filename);
  Log('Setting elevation bit for ' + Filename);

  Stream := TFileStream.Create(FileName, fmOpenReadWrite);
  try
    Stream.Seek(21, soFromBeginning);
    SetLength(Buffer, 1);
    Stream.ReadBuffer(Buffer, 1);
    Buffer[1] := Chr(Ord(Buffer[1]) or $20);
    Stream.Seek(-1, soFromCurrent);
    Stream.WriteBuffer(Buffer, 1);
  finally
    Stream.Free;
  end;
end;