unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, CoolForm, HotImage, ComCtrls, StdCtrls, OleCtrls, NMHTML,
  HTMLLite, Menus, XaudioPlayer;

type
  TWndMain = class(TForm)
    CoolBackground: TCoolForm;
    HotPlay: THotImage;
    ImgTime1: TImage;
    ImgTime2: TImage;
    ImgTime3: TImage;
    ImgTime4: TImage;
    ImgTime5: TImage;
    HotQuit: THotImage;
    HotMenu: THotImage;
    ListLabel1: TLabel;
    ListLabel2: TLabel;
    ListLabel3: TLabel;
    ListLabel4: TLabel;
    ListLabel5: TLabel;
    ListLabel6: TLabel;
    HotList: THotImage;
    LabelNumber: TLabel;
    Label2: TLabel;
    HTMLite: ThtmlLite;
    PopupMenu: TPopupMenu;
    PMUndockMe: TMenuItem;
    XaudioPlayer: TXaudioPlayer;
    TimerVisible: TTimer;
    TimerInvisible: TTimer;
    HotNumbers: THotImage;
    procedure FormCreate(Sender: TObject);
    procedure HotListClick(Sender: TObject);
    procedure HotMenuClick(Sender: TObject);
    procedure HotQuitClick(Sender: TObject);
    procedure HotPlayClick(Sender: TObject);
    procedure ListLabel1Click(Sender: TObject);
    procedure ListLabel2Click(Sender: TObject);
    procedure ListLabel3Click(Sender: TObject);
    procedure ListLabel4Click(Sender: TObject);
    procedure ListLabel5Click(Sender: TObject);
    procedure ListLabel6Click(Sender: TObject);
    procedure PMUndockMeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure XaudioPlayerNotifyInputDuration(
      Sender: TXaudioPlayer; Duration: Cardinal);
    procedure XaudioPlayerNotifyInputTimecode(Sender: TXaudioPlayer; Hours,
      Minutes, Seconds, Fractions: Byte);
    procedure TimerVisibleTimer(Sender: TObject);
    procedure TimerInvisibleTimer(Sender: TObject);
    procedure HotNumbersClick(Sender: TObject);
  private
    { Private declarations }
    GamesList: TStringList;
    TopItem, EndItem, SelectedItem: Integer;
    MP3List: TStringList;
    SelectedMusic: Integer;
    IsPlaying: Boolean;
    procedure CleanList;
    procedure CreateGamesList;
    procedure ShowTime(Minutes, Seconds: Byte);
  public
    { Public declarations }
  end;

var
  WndMain: TWndMain;

implementation

uses
  HTMLForm {HTMLWnd};

var
  FinalURL: string;

{$R *.DFM}
{$R Internal.RES} { Onde estão elementos usados pelo programa }


procedure TWndMain.FormCreate(Sender: TObject);
var
  I: Integer;

begin
  { Create Games List }
  CreateGamesList;
  { Start the List Menu }
  TopItem := 0;
  EndItem := 6;
  SelectedItem := 0;
  ListLabel1.Caption := GamesList.Strings[TopItem];
  ListLabel2.Caption := GamesList.Strings[TopItem + 1];
  ListLabel3.Caption := GamesList.Strings[TopItem + 2];
  ListLabel4.Caption := GamesList.Strings[TopItem + 3];
  ListLabel5.Caption := GamesList.Strings[TopItem + 4];
  ListLabel6.Caption := GamesList.Strings[TopItem + 5];
  LabelNumber.Caption := IntToStr(GamesList.Count);
  { Create MP3 playable list }
  MP3List := TStringList.Create;
  SelectedMusic := 0;
  MP3List.Sorted := TRUE;
  MP3List.Add('Neo-Geo Gals - Heavy Baby''s');
  MP3List.Add('Neo-Geo Gals - Psycho Soldier');
  MP3List.Add('Neo-Geo Gals - The Remains of My Love');
  MP3List.Add('Real Bout Fatal Fury - Blue Mary');
  MP3List.Add('Real Bout Fatal Fury - Kim Kap Hwan');
  MP3List.Add('Waku Waku 7 - Arina');
  MP3List.Add('Waku Waku 7 - Dandy J');
  MP3List.Add('Waku Waku 7 - Ending');
  MP3List.Add('Waku Waku 7 - Slash');
  MP3List.Add('World Heroes - Brocken');
  MP3List.Add('World Heroes - Fuuma');
  MP3List.Add('World Heroes - Hanzo');
  MP3List.Add('World Heroes - Neo Geegus');
  { Load first MP3 }
  XAudioPlayer.InputOpen('.\MP3\' + MP3List.Strings[SelectedMusic] + '.MP3');
  IsPlaying := FALSE;
  { Actualiza as hints }
  if SelectedMusic > 0 then HotPlay.HotSpots.Spots[0].HintText := 'PREVIOUS [' + MP3List.Strings[SelectedMusic - 1] + ']'
  else HotPlay.HotSpots.Spots[0].HintText := 'PREVIOUS [' + MP3List.Strings[SelectedMusic] + ']';
  HotPlay.HotSpots.Spots[1].HintText := 'PLAY [' + MP3List.Strings[SelectedMusic] + ']';
  HotPlay.HotSpots.Spots[2].HintText := 'PAUSE [' + MP3List.Strings[SelectedMusic] + ']';
  HotPlay.HotSpots.Spots[3].HintText := 'STOP [' + MP3List.Strings[SelectedMusic] + ']';
  HotPlay.HotSpots.Spots[4].HintText := 'NEXT [' + MP3List.Strings[SelectedMusic + 1] + ']';
  for I := 0 to 12 do
    HotNumbers.HotSpots.Spots[I].HintText := MP3List.Strings[I];
end;

procedure TWndMain.HotListClick(Sender: TObject);
begin
  case HotList.SelectedSpot.SpotID of
    1: begin { Games List UP }
        if TopItem > 0 then
        begin
          Dec(TopItem);
          Dec(EndItem);
          Dec(SelectedItem);
          FinalURL := '.\Database\' +
            GamesList.Strings[SelectedItem] +
            '\index.htm';
          HTMLite.LoadFromFile(FinalURL);
        end;
      end;
    2: begin { Games List DOWN }
        if EndItem < GamesList.Count then
        begin
          Inc(EndItem);
          Inc(TopItem);
          Inc(SelectedItem);
          FinalURL := '.\Database\' +
            GamesList.Strings[SelectedItem] +
            '\index.htm';
          HTMLite.LoadFromFile(FinalURL);
        end;
      end;
  end;
  ListLabel1.Caption := GamesList.Strings[TopItem];
  ListLabel2.Caption := GamesList.Strings[TopItem + 1];
  ListLabel3.Caption := GamesList.Strings[TopItem + 2];
  ListLabel4.Caption := GamesList.Strings[TopItem + 3];
  ListLabel5.Caption := GamesList.Strings[TopItem + 4];
  ListLabel6.Caption := GamesList.Strings[TopItem + 5];
end;

procedure TWndMain.HotMenuClick(Sender: TObject);
begin
  case HotMenu.SelectedSpot.SpotID of
    1: begin { Game Info }
        HTMLite.Visible := TRUE;
        FinalURL := '.\Database\' +
          GamesList.Strings[SelectedItem] +
          '\index.htm';
        HTMLite.LoadFromFile(FinalURL);
      end;
    2: begin { Game Review }
        HTMLite.Visible := TRUE;
        FinalURL := '.\Database\' +
          GamesList.Strings[SelectedItem] +
          '\Review\index.htm';
        HTMLite.LoadFromFile(FinalURL);
      end;
    3: begin { Game Animations }
        HTMLite.Visible := TRUE;
        FinalURL := '.\Database\' +
          GamesList.Strings[SelectedItem] +
          '\Animations\index.htm';
        HTMLite.LoadFromFile(FinalURL);
      end;
    4: begin { Game Musics }
        HTMLite.Visible := TRUE;
        FinalURL := '.\Database\' +
          GamesList.Strings[SelectedItem] +
          '\Musics\index.htm';
        HTMLite.LoadFromFile(FinalURL);
      end;
  end;
end;

procedure TWndMain.HotQuitClick(Sender: TObject);
begin
  case HotQuit.SelectedSpot.SpotID of
    1: begin { About }
        HTMLite.Visible := FALSE;
        ShowMessage(' Show My Movie ');
      end;
    2: begin { Quit }
        Close;
      end;
  end;
end;

procedure TWndMain.HotPlayClick(Sender: TObject);
begin
  case HotPlay.SelectedSpot.SpotID of
    1: begin { Previous Track }
        { Actualiza a musica }
        if SelectedMusic >= 1 then
        begin
          Dec(SelectedMusic);
          XAudioPlayer.Stop;
          XAudioPlayer.InputClose;
          XAudioPlayer.InputOpen('.\MP3\' + MP3List.Strings[SelectedMusic] + '.MP3');
          if IsPlaying then XAudioPlayer.Play;
        end;
        { Actualiza o display }
        if SelectedMusic > 0 then HotPlay.HotSpots.Spots[0].HintText := 'PREVIOUS [' + MP3List.Strings[SelectedMusic - 1] + ']'
        else HotPlay.HotSpots.Spots[0].HintText := 'PREVIOUS [' + MP3List.Strings[SelectedMusic] + ']';
        HotPlay.HotSpots.Spots[1].HintText := 'PLAY [' + MP3List.Strings[SelectedMusic] + ']';
        HotPlay.HotSpots.Spots[2].HintText := 'PAUSE [' + MP3List.Strings[SelectedMusic] + ']';
        HotPlay.HotSpots.Spots[3].HintText := 'STOP [' + MP3List.Strings[SelectedMusic] + ']';
        HotPlay.HotSpots.Spots[4].HintText := 'NEXT [' + MP3List.Strings[SelectedMusic + 1] + ']';
        { Actualiza os timers }
        TimerVisible.Enabled := FALSE;
        TimerInvisible.Enabled := FALSE;
      end;
    2: begin { Play }
        { Actualiza a musica }
        IsPlaying := TRUE;
        XAudioPlayer.Play;
        { Actualiza o display }
        ImgTime1.Visible := TRUE;
        ImgTime2.Visible := TRUE;
        ImgTime3.Visible := TRUE;
        ImgTime4.Visible := TRUE;
        ImgTime5.Visible := TRUE;
        { Actualiza os timers }
        TimerVisible.Enabled := FALSE;
        TimerInvisible.Enabled := FALSE;
      end;
    3: begin { Pause }
        { Actualiza a musica }
        XAudioPlayer.Pause;
        { Actualiza os timers }
        TimerVisible.Enabled := TRUE;
      end;
    4: begin { Stop }
        { Actualiza a musica }
        IsPlaying := FALSE;
        XAudioPlayer.Stop;
        { Actualiza o display }
        ImgTime1.Visible := FALSE;
        ImgTime2.Visible := FALSE;
        ImgTime3.Visible := FALSE;
        ImgTime4.Visible := FALSE;
        ImgTime5.Visible := FALSE;
        { Actualiza os timers }
        TimerVisible.Enabled := FALSE;
        TimerInvisible.Enabled := FALSE;
      end;
    5: begin { Next Track }
        { Actualiza a musica }
        if SelectedMusic <= 11 then
        begin
          Inc(SelectedMusic);
          XAudioPlayer.Stop;
          XAudioPlayer.InputClose;
          XAudioPlayer.InputOpen('.\MP3\' + MP3List.Strings[SelectedMusic] + '.MP3');
          if IsPlaying then XAudioPlayer.Play;
        end;
        { Actualiza o display }
        HotPlay.HotSpots.Spots[0].HintText := 'PREVIOUS [' + MP3List.Strings[SelectedMusic - 1] + ']';
        HotPlay.HotSpots.Spots[1].HintText := 'PLAY [' + MP3List.Strings[SelectedMusic] + ']';
        HotPlay.HotSpots.Spots[2].HintText := 'PAUSE [' + MP3List.Strings[SelectedMusic] + ']';
        HotPlay.HotSpots.Spots[3].HintText := 'STOP [' + MP3List.Strings[SelectedMusic] + ']';
        if SelectedMusic < 12 then HotPlay.HotSpots.Spots[4].HintText := 'PREVIOUS [' + MP3List.Strings[SelectedMusic + 1] + ']'
        else HotPlay.HotSpots.Spots[4].HintText := 'NEXT [' + MP3List.Strings[SelectedMusic] + ']';
        { Actualiza os timers }
        TimerVisible.Enabled := FALSE;
        TimerInvisible.Enabled := FALSE;
      end;
  end;
end;

procedure TWndMain.ListLabel1Click(Sender: TObject);
begin
  CleanList;
  ListLabel1.Transparent := FALSE;
  ListLabel1.Font.Color := clYellow;
  ListLabel1.Font.Style := [fsBold];
  SelectedItem := TopItem;
  FinalURL := '.\Database\' +
    GamesList.Strings[SelectedItem] +
    '\index.htm';
  HTMLite.LoadFromFile(FinalURL);
end;

procedure TWndMain.CleanList;
begin
  ListLabel1.Transparent := TRUE;
  ListLabel1.Font.Color := clAqua;
  ListLabel1.Font.Style := [];
  ListLabel2.Transparent := TRUE;
  ListLabel2.Font.Color := clAqua;
  ListLabel2.Font.Style := [];
  ListLabel3.Transparent := TRUE;
  ListLabel3.Font.Color := clAqua;
  ListLabel3.Font.Style := [];
  ListLabel4.Transparent := TRUE;
  ListLabel4.Font.Color := clAqua;
  ListLabel4.Font.Style := [];
  ListLabel5.Transparent := TRUE;
  ListLabel5.Font.Color := clAqua;
  ListLabel5.Font.Style := [];
  ListLabel6.Transparent := TRUE;
  ListLabel6.Font.Color := clAqua;
  ListLabel6.Font.Style := [];
end;

procedure TWndMain.ListLabel2Click(Sender: TObject);
begin
  CleanList;
  ListLabel2.Transparent := FALSE;
  ListLabel2.Font.Color := clYellow;
  ListLabel2.Font.Style := [fsBold];
  SelectedItem := TopItem + 1;
  FinalURL := '.\Database\' +
    GamesList.Strings[SelectedItem] +
    '\index.htm';
  HTMLite.LoadFromFile(FinalURL);
end;

procedure TWndMain.ListLabel3Click(Sender: TObject);
begin
  CleanList;
  ListLabel3.Transparent := FALSE;
  ListLabel3.Font.Color := clYellow;
  ListLabel3.Font.Style := [fsBold];
  SelectedItem := TopItem + 2;
  FinalURL := '.\Database\' +
    GamesList.Strings[SelectedItem] +
    '\index.htm';
  HTMLite.LoadFromFile(FinalURL);
end;

procedure TWndMain.ListLabel4Click(Sender: TObject);
begin
  CleanList;
  ListLabel4.Transparent := FALSE;
  ListLabel4.Font.Color := clYellow;
  ListLabel4.Font.Style := [fsBold];
  SelectedItem := TopItem + 3;
  FinalURL := '.\Database\' +
    GamesList.Strings[SelectedItem] +
    '\index.htm';
  HTMLite.LoadFromFile(FinalURL);
end;

procedure TWndMain.ListLabel5Click(Sender: TObject);
begin
  CleanList;
  ListLabel5.Transparent := FALSE;
  ListLabel5.Font.Color := clYellow;
  ListLabel5.Font.Style := [fsBold];
  SelectedItem := TopItem + 4;
  FinalURL := '.\Database\' +
    GamesList.Strings[SelectedItem] +
    '\index.htm';
  HTMLite.LoadFromFile(FinalURL);
end;

procedure TWndMain.ListLabel6Click(Sender: TObject);
begin
  CleanList;
  ListLabel6.Transparent := FALSE;
  ListLabel6.Font.Color := clYellow;
  ListLabel6.Font.Style := [fsBold];
  SelectedItem := TopItem + 5;
  FinalURL := '.\Database\' +
    GamesList.Strings[SelectedItem] +
    '\index.htm';
  HTMLite.LoadFromFile(FinalURL);
end;

procedure TWndMain.CreateGamesList;
begin
  GamesList := TStringList.Create;
  GamesList.Sorted := TRUE;
  GamesList.Add('2020 Super Baseball');
  GamesList.Add('3 Count Bout');
  GamesList.Add('AeroFighters 2');
  GamesList.Add('AeroFighters 3');
  GamesList.Add('Agressors of Dark Kombat');
  GamesList.Add('Andro Dunos');
  GamesList.Add('Art of Fighting');
  GamesList.Add('Art of Fighting 2');
  GamesList.Add('Art of Fighting 3');
  GamesList.Add('ASO 2 - Alpha Mission 2');
  GamesList.Add('Baseball Stars');
  GamesList.Add('Baseball Stars 2');
  GamesList.Add('Bakatono');
  GamesList.Add('Blazing Star');
  GamesList.Add('Blues Journey');
  GamesList.Add('Breakers');
  GamesList.Add('Breakers Revenge');
  GamesList.Add('Burning Fight');
  GamesList.Add('Captain Tomaday');
  GamesList.Add('Crossed Swords');
  GamesList.Add('Cyber Lip');
  GamesList.Add('Double Dragon');
  GamesList.Add('Eight Man');
  GamesList.Add('Fatal Fury');
  GamesList.Add('Fatal Fury 2');
  GamesList.Add('Fatal Fury 3');
  GamesList.Add('Fatal Fury Special');
  GamesList.Add('Fight Fever');
  GamesList.Add('Flip Shot');
  GamesList.Add('Football Frenzy');
  GamesList.Add('Galaxy Fight');
  GamesList.Add('Ghost Pilots');
  GamesList.Add('Goal! Goal! Goal!');
  GamesList.Add('Gururin');
  GamesList.Add('Irritating Maze');
  GamesList.Add('Joy Joy Kid (Puzzled)');
  GamesList.Add('Kabuki Klash');
  GamesList.Add('Karnovs Revenge');
  GamesList.Add('King of Fighters 94');
  GamesList.Add('King of Fighters 95');
  GamesList.Add('King of Fighters 96');
  GamesList.Add('King of Fighters 97');
  GamesList.Add('King of Fighters 98');
  GamesList.Add('King of Monsters');
  GamesList.Add('King of Monsters 2');
  GamesList.Add('Kizuna Encounter');
  GamesList.Add('Last Blade');
  GamesList.Add('Last Blade 2');
  GamesList.Add('Last Resort');
  GamesList.Add('League Bowling');
  GamesList.Add('Legend of Success Joe');
  GamesList.Add('Magical Drop 2');
  GamesList.Add('Magical Drop 3');
  GamesList.Add('Magician Lord');
  GamesList.Add('MahJong');
  GamesList.Add('Marukos Deluxe Quiz');
  GamesList.Add('Metal Slug');
  GamesList.Add('Metal Slug 2');
  GamesList.Add('Metal Slug X');
  GamesList.Add('Minnasan');
  GamesList.Add('Money Idol Exchanger');
  GamesList.Add('Mutation Nation');
  GamesList.Add('NAM 1975');
  GamesList.Add('Neo BomberMan');
  GamesList.Add('Neo DriftOut');
  GamesList.Add('Neo MrDo');
  GamesList.Add('Neo Turf Masters');
  GamesList.Add('Neogeo Cup 98');
  GamesList.Add('Ninja Combat');
  GamesList.Add('Ninja Comando');
  GamesList.Add('Ninja Masters');
  GamesList.Add('OverTop');
  GamesList.Add('Panic Bomber');
  GamesList.Add('Pop n Bounce');
  GamesList.Add('Power Spikes 2');
  GamesList.Add('Pulstar');
  GamesList.Add('Puzzle Bobble');
  GamesList.Add('Puzzle Bobble 2');
  GamesList.Add('Puzzle de Pon');
  GamesList.Add('Puzzle de Pon R');
  GamesList.Add('Quest of Jong Master');
  GamesList.Add('Quiz Dausousasen');
  GamesList.Add('Quiz Dausousasen 2');
  GamesList.Add('Quiz KOF');
  GamesList.Add('Ragnagard');
  GamesList.Add('Real Bout Fatal Fury');
  GamesList.Add('Real Bout Fatal Fury 2');
  GamesList.Add('Real Bout Fatal Fury Special');
  GamesList.Add('Riding Hero');
  GamesList.Add('RoboArmy');
  GamesList.Add('Samurai Shodown');
  GamesList.Add('Samurai Shodown 2');
  GamesList.Add('Samurai Shodown 3');
  GamesList.Add('Samurai Shodown 4');
  GamesList.Add('Savage Reign');
  GamesList.Add('Sengoku');
  GamesList.Add('Sengoku 2');
  GamesList.Add('Shock Troopers');
  GamesList.Add('Shock Troopers 2');
  GamesList.Add('Soccer Brawl');
  GamesList.Add('Spin Master');
  GamesList.Add('Stakes Winners');
  GamesList.Add('Stakes Winners 2');
  GamesList.Add('Street Hoop');
  GamesList.Add('Super Dodgeball');
  GamesList.Add('Super Sidekicks');
  GamesList.Add('Super Sidekicks 2');
  GamesList.Add('Super Sidekicks 3');
  GamesList.Add('Super Sidekicks 4');
  GamesList.Add('Super Spy');
  GamesList.Add('Top Hunter');
  GamesList.Add('Top Players Golf');
  GamesList.Add('Trash Rally');
  GamesList.Add('Twinkle Star Sprites');
  GamesList.Add('View Point');
  GamesList.Add('VF Gowcaizer');
  GamesList.Add('Waku Waku 7');
  GamesList.Add('WindJammers');
  GamesList.Add('World Heroes');
  GamesList.Add('World Heroes 2');
  GamesList.Add('World Heroes 2 Jet');
  GamesList.Add('World Heroes Perfect');
  GamesList.Add('World Soccer 96');
  GamesList.Add('Zed Blade');
end;

procedure TWndMain.PMUndockMeClick(Sender: TObject);
begin
  if not PMUndockMe.Checked then
  begin
    HTMLWnd.Left := 0;
    HTMLWnd.Top := 0;
    HTMLWnd.HTMLite.PopupMenu := PopupMenu;
    HTMLWnd.HTMLite.LoadFromFile(FinalURL);
    HTMLite.Visible := FALSE;
    PMUndockMe.Checked := TRUE;
    HTMLWnd.ShowModal;
    HTMLite.Visible := TRUE;
    PMUndockMe.Checked := FALSE;
  end
  else
  begin
    HTMLWnd.Close;
    HTMLite.Visible := TRUE;
    PMUndockMe.Checked := FALSE;
  end;
end;

procedure TWndMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  XAudioPlayer.Stop;
  XAudioPlayer.InputClose;
end;

procedure TWndMain.XaudioPlayerNotifyInputDuration(
  Sender: TXaudioPlayer; Duration: Cardinal);
var
  Hours: Integer;
  Minutes: Integer;
  Seconds: Integer;
begin
  Hours := Duration div 3600;
  Duration := Duration - 3600 * Hours;
  Minutes := Duration div 60;
  Duration := Duration - 60 * Minutes;
  Seconds := Duration;
  ImgTime1.Hint := 'TOTAL [' + IntToStr(Minutes) + ':' + IntToStr(Seconds) + ']';
  ImgTime2.Hint := 'TOTAL [' + IntToStr(Minutes) + ':' + IntToStr(Seconds) + ']';
  ImgTime3.Hint := 'TOTAL [' + IntToStr(Minutes) + ':' + IntToStr(Seconds) + ']';
  ImgTime4.Hint := 'TOTAL [' + IntToStr(Minutes) + ':' + IntToStr(Seconds) + ']';
  ImgTime5.Hint := 'TOTAL [' + IntToStr(Minutes) + ':' + IntToStr(Seconds) + ']';
end;

procedure TWndMain.XaudioPlayerNotifyInputTimecode(Sender: TXaudioPlayer;
  Hours, Minutes, Seconds, Fractions: Byte);
begin
  ShowTime(Minutes, Seconds);
end;

procedure TWndMain.ShowTime(Minutes, Seconds: Byte);
var
  MinutesStr: string;
  SecondsStr: string;

begin
  MinutesStr := IntToStr(Minutes);
  SecondsStr := IntToStr(Seconds);
  if Minutes < 10 then
  begin
    ImgTime1.Picture.Bitmap.LoadFromResourceName(HInstance, 'N0');
    ImgTime2.Picture.Bitmap.LoadFromResourceName(HInstance, 'N' + MinutesStr[1]);
  end
  else
  begin
    ImgTime1.Picture.Bitmap.LoadFromResourceName(HInstance, 'N' + MinutesStr[1]);
    ImgTime2.Picture.Bitmap.LoadFromResourceName(HInstance, 'N' + MinutesStr[2]);
  end;
  if Seconds < 10 then
  begin
    ImgTime4.Picture.Bitmap.LoadFromResourceName(HInstance, 'N0');
    ImgTime5.Picture.Bitmap.LoadFromResourceName(HInstance, 'N' + SecondsStr[1]);
  end
  else
  begin
    ImgTime4.Picture.Bitmap.LoadFromResourceName(HInstance, 'N' + SecondsStr[1]);
    ImgTime5.Picture.Bitmap.LoadFromResourceName(HInstance, 'N' + SecondsStr[2]);
  end;
  ImgTime3.Picture.Bitmap.LoadFromResourceName(HInstance, 'NP');
end;

procedure TWndMain.TimerVisibleTimer(Sender: TObject);
begin
  ImgTime1.Visible := TRUE;
  ImgTime2.Visible := TRUE;
  ImgTime3.Visible := TRUE;
  ImgTime4.Visible := TRUE;
  ImgTime5.Visible := TRUE;
  TimerVisible.Enabled := FALSE;
  TimerInvisible.Enabled := TRUE;
end;

procedure TWndMain.TimerInvisibleTimer(Sender: TObject);
begin
  ImgTime1.Visible := FALSE;
  ImgTime2.Visible := FALSE;
  ImgTime3.Visible := FALSE;
  ImgTime4.Visible := FALSE;
  ImgTime5.Visible := FALSE;
  TimerVisible.Enabled := TRUE;
  TimerInvisible.Enabled := FALSE;
end;

procedure TWndMain.HotNumbersClick(Sender: TObject);

  procedure ActualizaMusica(Musica: Integer);
  begin
    { Actualiza a musica }
    SelectedMusic := Musica;
    XAudioPlayer.Stop;
    XAudioPlayer.InputClose;
    XAudioPlayer.InputOpen('.\MP3\' + MP3List.Strings[SelectedMusic] + '.MP3');
    if IsPlaying then XAudioPlayer.Play;
    { Actualiza o display }
    if SelectedMusic > 0 then HotPlay.HotSpots.Spots[0].HintText := 'PREVIOUS [' + MP3List.Strings[SelectedMusic - 1] + ']'
    else HotPlay.HotSpots.Spots[0].HintText := 'PREVIOUS [' + MP3List.Strings[SelectedMusic] + ']';
    HotPlay.HotSpots.Spots[1].HintText := 'PLAY [' + MP3List.Strings[SelectedMusic] + ']';
    HotPlay.HotSpots.Spots[2].HintText := 'PAUSE [' + MP3List.Strings[SelectedMusic] + ']';
    HotPlay.HotSpots.Spots[3].HintText := 'STOP [' + MP3List.Strings[SelectedMusic] + ']';
    if SelectedMusic < 12 then HotPlay.HotSpots.Spots[4].HintText := 'PREVIOUS [' + MP3List.Strings[SelectedMusic + 1] + ']'
    else HotPlay.HotSpots.Spots[4].HintText := 'NEXT [' + MP3List.Strings[SelectedMusic] + ']';
    { Actualiza os timers }
    TimerVisible.Enabled := FALSE;
    TimerInvisible.Enabled := FALSE;
  end;

begin
  case HotNumbers.SelectedSpot.SpotID of
    1: begin
        ActualizaMusica(0);
      end;
    2: begin
        ActualizaMusica(1);
      end;
    3: begin
        ActualizaMusica(2);
      end;
    4: begin
        ActualizaMusica(3);
      end;
    5: begin
        ActualizaMusica(4);
      end;
    6: begin
        ActualizaMusica(5);
      end;
    7: begin
        ActualizaMusica(6);
      end;
    8: begin
        ActualizaMusica(7);
      end;
    9: begin
        ActualizaMusica(8);
      end;
    10: begin
        ActualizaMusica(9);
      end;
    11: begin
        ActualizaMusica(10);
      end;
    12: begin
        ActualizaMusica(11);
      end;
    13: begin
        ActualizaMusica(12);
      end;
  end;
end;

end.

