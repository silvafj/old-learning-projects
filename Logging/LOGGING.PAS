Program LOGGING;

Uses
  DOS;

Const
  DS : array [0..6] of string = ('Domingo',
                                 'Segunda Feira',
                                 'Ter‡a Feira',
                                 'Quarta Feira',
                                 'Quinta Feira',
                                 'Sexta Feira',
                                 'S bado');
Var
  Ficheiro : Text;
  Dia, Mes, Ano, DiaSemana : Word;
  Hora, Minuto, Segundo, Seg100 : Word;

Begin
  {$I-}
  Assign(Ficheiro,'LOG.TXT');
  Reset(Ficheiro);
  Close(Ficheiro);
  {$I+}
  if IOResult <> 0 then Rewrite(Ficheiro)
  else Append(Ficheiro);
  GetDate(Ano, Mes, Dia, DiaSemana);
  GetTime(Hora, Minuto, Segundo, Seg100);
  Writeln(Ficheiro, DS[DiaSemana]+' ',Dia:2,'-',Mes:2,'-',Ano:4,'   ',Hora:2,':',Minuto:2,':',Segundo:2,',',Seg100:2);
  Close(Ficheiro);
end.