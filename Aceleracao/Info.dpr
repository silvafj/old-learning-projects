PROGRAM Deslocamento;

{ Delphi Version }
{
USES
wintypes,
  winprocs,
  sysutils,
  wincrt;

procedure InitScreen;
  begin
    WITH ScreenSize DO BEGIN
      x := 90;
      y := 500;
    END;
    WITH WindowOrg DO BEGIN
      x := 1;
      y := 1
    END;
    WITH WindowSize DO BEGIN
      y := 30;
    END;
  end;
}

const
  g = 9.80665;

var
  tempstr : string; { variavel temporaria }
  Error : integer; {variavel de controlo de erros }
  angulo, tempo : real; { variaveis de entrada }
  a, e, v : real; { variaveis de calculo }

BEGIN
  Write('Introduza o ângulo de inclinação (em graus) : ');
  ReadLn(tempstr);
  Val(tempstr,angulo,error);
  Write('Introduza o tempo de deslocamento (em segundos) : ');
  ReadLn(tempstr);
  Val(tempstr,tempo,error);
  a := sin(angulo) * g;
  e := 1/2 * a * SQR(tempo);
  v := a * tempo;
  WriteLn('Deslocamento efectuado : ',Round(e),' m');
  WriteLn('Velocidade : ', Round(v),' m/s');
END.

