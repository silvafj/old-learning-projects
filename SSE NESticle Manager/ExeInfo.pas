unit ExeInfo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs;

type
  TMAGExeInfo = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    Signature          : DWord;   // EXE Signature
    HiVersion          : Word;    // Major version number
    LoVersion          : Word;    // Minor version number
    ReleaseVersion     : Word;    // Release version number
    BuildVersion       : Word;    // Build version number
    Debug              : Boolean; // Debug info included
    PreRelease         : Boolean; // Pre-release (beta) version
    PrivateBuild       : Boolean; // Private Build
    SpecialBuild       : Boolean; // Special Build
    FileDescription    : String;  // File Description
    FileVersion        : String;  // File Version
    InternalName       : String;  // Internal Name
    LegalCopyright     : String;  // Legal Copyright
    ProductDescription : String;  // Product Name
    ProductVersion     : String;  // Product Version
    function GetEXEInfo(FileName : String) : Boolean;
  end;

var
  MAGExeInfo: TMAGExeInfo;

implementation

{$R *.DFM}
{ Get's EXE information }
function TMAGExeInfo.GetEXEInfo(FileName : String) : Boolean;
var
  Size, Size2: DWord;
  Pt, Pt2: Pointer;
begin
  { Initialize all variables }
  Signature := 0; HiVersion := 0; LoVersion := 0;
  ReleaseVersion := 0; BuildVersion := 0; Debug := FALSE;
  PreRelease := FALSE; PrivateBuild := FALSE;
  SpecialBuild := FALSE; FileDescription := '';
  FileVersion := ''; InternalName := '';
  LegalCopyright := ''; ProductDescription := '';
  ProductVersion := '';
  { Open file and get info }
  Size := GetFileVersionInfoSize(PChar(FileName), Size2);
  if Size > 0 then
    begin
      GetMem (Pt, Size);
      try
        GetFileVersionInfo(PChar(FileName), 0, Size, Pt);
        // Get the fixed information
        VerQueryValue (Pt, '\', Pt2, Size2);
        with TVSFixedFileInfo (Pt2^) do
          begin
            Signature := dwSignature;
            HiVersion := HiWord(dwFileVersionMS);
            LoVersion := LoWord(dwFileVersionMS);
            ReleaseVersion := HiWord(dwFileVersionLS);
            BuildVersion := LoWord(dwFileVersionLS);
            if (dwFileFlagsMask and dwFileFlags and
                VS_FF_DEBUG) <> 0 then Debug := TRUE;
            if (dwFileFlagsMask and dwFileFlags and
                VS_FF_PRERELEASE) <> 0 then PreRelease := TRUE;
            if (dwFileFlagsMask and dwFileFlags and
                VS_FF_PRIVATEBUILD) <> 0 then PrivateBuild := TRUE;
            if (dwFileFlagsMask and dwFileFlags and
                VS_FF_SPECIALBUILD) <> 0 then SpecialBuild := TRUE;
          end;
        // Get some strings
        VerQueryValue(Pt,
        '\StringFileInfo\040904E4\FileDescription',
        Pt2, Size2);
        FileDescription := PChar(Pt2);
        //
        VerQueryValue(Pt,
        '\StringFileInfo\040904E4\FileVersion',
        Pt2, Size2);
        FileVersion := PChar(pt2);
        //
        VerQueryValue(Pt,
        '\StringFileInfo\040904E4\InternalName',
        Pt2, Size2);
        InternalName := PChar(pt2);
        //
        VerQueryValue(Pt,
        '\StringFileInfo\040904E4\LegalCopyright',
        Pt2, Size2);
        LegalCopyright := PChar(pt2);
        //
        VerQueryValue(Pt,
        '\StringFileInfo\040904E4\ProductDescription',
        Pt2, Size2);
        ProductDescription := PChar(pt2);
        //
        VerQueryValue(Pt,
        '\StringFileInfo\040904E4\ProductVersion',
        Pt2, Size2);
        ProductVersion := PChar(pt2);
      finally
        FreeMem (Pt);
      end;
      Result := TRUE;
    end
   else Result := FALSE;
end;

end.
