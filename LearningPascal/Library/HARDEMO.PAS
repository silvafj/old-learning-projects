uses
  dos,math,screen,keyboard,hardware;

var
  f:byte;
  drive,face:byte;

begin
(*
  IF CMOS.CoProc Then
    Begin
      {$Define abcd}
    End;
  clrscr;
  {$IFDEF abcd}

{ Equipment }
  ClrScr;
  System.write('Drive de disquetes : ');
  IF FloppyDiskInstalled(f) then
    Begin
      system.writeln(TRUE);
      system.writeln('N§ de Drives : ',f);
    End;
  System.WriteLn('CoProcessor : ',CoProcessorInstalled);
  System.WriteLn('Pointing Device : ',PSInstalled);
  System.WriteLn('Initial Video Mode : ',InitialVideoMode);
  System.WriteLn('DMA Installed : ',DMAInstalled);
  System.WriteLn('N§ de Serial Ports : ',SerialPorts);
  System.WriteLn('Game Port Installed : ',GamePortInstalled);
  System.WriteLn('Internal Modem : ',InternalModemInstalled);
  System.WriteLn('N§ de Parallel Ports : ',ParallelPorts);
  System.Write('Base memory : ');
  writeln(memw[seg0040:$0013],+' Kb');
  IF GetConfiguration<>0 Then system.write('Error')
  Else
    Begin
          system.writeln('NumberOfBytes : ',ROM.NumberOfBytes);
          system.writeln('Model : ',Long2Hex(ROM.Model));
          system.writeln('SubModel : ',ROM.SubModel);
          system.writeln('BIOSRevision : ',ROM.BIOSRevision);
          system.writeln('Features1 : ',ROM.Features1);
          system.writeln('Features2 : ',ROM.Features2);
          system.writeln('Features3 : ',ROM.Features3);
          system.writeln('Features4 : ',ROM.Features4);
          system.writeln('Features5 : ',ROM.Features5);
          system.writeln('Award : ',ROM.Award);
        End;
  system.writeln('BIOS Date : ',BIOSDate);
*)
{ CPU }
  ClrScr;
  GetCPUInformation;
  System.writeln('Processor Type : ', CPU.Cpu_Type_Value,' --- ', CPU.Cpu_Type_Name);
  System.writeln('Processor Family : ', CPU.cpu_family_Value,' --- ', CPU.cpu_family_Name);
  System.writeln('Model: ',CPU.CPU_Model_Value,' ---  ',CPU.CPU_Model_Name);
  System.writeln('Stepping: ',CPU.CPU_Stepping_Name);
  System.writeln('Vendor ID : ',CPU.VendorString);
  System.WriteLn('The Processor contains an on-chip FPU                   (FPU) : ',CPU.Features.FPU);
  System.WriteLn('The processor supports Virtual Mode Extensions          (VME) : ',CPU.Features.VME);
  System.WriteLn('The processor supports debugging extension              (DE)  : ',CPU.Features.DE);
  System.WriteLn('The processor supports page size extension              (PSE) : ',CPU.Features.PSE);
  System.WriteLn('The processor supports Time stamp counter               (TSC) : ',CPU.Features.TSC);
  System.WriteLn('The processor supports model specific registers         (MSR) : ',CPU.Features.MSR);
  System.WriteLn('The processor contains physical address extension       (PAE) : ',CPU.Features.PAE);
  System.WriteLn('The processor supports machine check extension          (MCE) : ',CPU.Features.MCE);
  System.WriteLn('The processor supports CMPXCHG8B Instruction                  : ',CPU.Features.CX8);
  System.WriteLn('The processor contains an on-chip APIC                        : ',CPU.Features.APIC);
  System.WriteLn('The processor supports fast system call                 (SEP) : ',CPU.Features.SEP);
  System.WriteLn('The processor supports memory type range registers      (MTRR): ',CPU.Features.MTRR);
  System.WriteLn('The processor supports page global enable               (PGE) : ',CPU.Features.PGE);
  System.WriteLn('The processor supports machine check Architecture       (MCA) : ',CPU.Features.MCA);
  System.WriteLn('The processor supports Conditional Move Instruction     (CMOV): ',CPU.Features.CMOV);
  System.WriteLn('The processor supports Intel Architecture MMX tecnology (MMX) : ',CPU.Features.MMX);
  System.writeln('Is V86 : ',CPU.IsV86);
  IF Not CPU.SupportExtendedFunctions Then system.writeln('The CPU doesn''t support Extended CPUID Information');
(*
  GetCmos;
  Writeln('Found : ',CMOS.Found);
  Writeln('Date : ',CMOS.CmosDate);
  Writeln('Time : ',CMOS.CmosTime);
  Writeln('Video Type : ',CMOS.VideoType);
  Writeln('CoProcessor : ',CMOS.Coproc);
  Writeln('Floppy A : ',CMOS.FloppyA);
  Writeln('Floppy B : ',CMOS.FloppyB);
  Writeln('Hard 0 : ',CMOS.Hard0);
  Writeln('Hard 1 : ',CMOS.Hard1);
  Writeln('Conventional RAM : ',CMOS.ConvenRam);
  Writeln('Exten RAM : ',CMOS.ExtendRam);
  Writeln('ChecSum : ',CMOS.checkSum);
  writeln('What is the drive to read from ? (0=A, 1=B) : ');
  readln(drive);
  writeln;
  if drive <> 255 then
    begin
  if drive<$80 then
      face:=0
    else
      face:=1;
    if lerSector(drive,0,face,1,1) then {drive,pista,face,primeiro,numero}
      begin
        writeln('Informations from Bios Parameter Block (BPB):');
        writeln('==========================================');
        with boot.bpb do
         begin
        writeln('                   Number of per sector = ',bytesPerSect);
        writeln('          Numero de sectores por cluster = ',sectsPerClust);
        writeln('           Numero de sectores reservados = ',reservedSects);
        writeln('                          Numero de FATs = ',numOfFats);
        writeln('Numero de entradas de directoria da ROOT = ',numOfRootEntries);
        writeln('                Numero total de sectores = ',totalSects);
        writeln('                 Byte descritor da MEDIA = ',mediaDescriptorByte);
        writeln('              Numero de sectores por FAT = ',sectsPerFat);
         end;
        writeln;
        writeln('Outras informacoes do Boot Sector:');
        writeln('==================================');
        with boot do
         begin
        writeln('                           Jump = ',jump);
        writeln('                            OEM = ',oem);
        writeln('   Numero de sectores por pista = ',sectsPerTrack);
        writeln('              Numero de cabecas = ',numOfHeads);
        writeln('Numero de sectores "escondidos" = ',numOfHiddenSects);
        writeln('      Numero de serie do volume = ',serialnumber,'  ',Long2Hex(Str2Num(SerialNumber)));
        {neste ponto, os bytes podem ser mostrados em hexadecimal, como
        faz o DOS}
        writeln('                 Nome do volume = ',volumeid);
        writeln;
         end;
      end
    else
      writeln('Erro no acesso ao drive.');
   end;
*)
{ system.writeLN(' ANSI : ',localansidetected);
 SYSTEM.writeLN('RunningUnderMSWindows : ',RunningUnderMSWindows);
}
 repeat until keypressed;
(* {$ENDIF} *)
end.