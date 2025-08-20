PPRECONU
Unit PPRECONU;

Interface

Uses
  Windows, Messages, SysUtils, StrUtils, DateUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdIOHandler, IdIOHandlerStream,
  Vcl.ExtCtrls, SabUtils, uLGAini, Vcl.Grids, UITypes, System.IOUtils, System.Types;

Type
  Tppreconform = Class(TForm)
    Panel1: TPanel;
    Button1: tButton;
    Label1: tLabel;
    lStatus: tLabel;
    ListBox1: TListBox;
    Timer1: TTimer;
    StringGrid1: TStringGrid;
    CancelAUTORUN: TButton;
    procedure WaitForABit(Const TickLimit: Integer);
    procedure gettrovedata(const ChkField: AnsiString; const Rule: AnsiString; const MovField: AnsiString;
     var trovedata: AnsiString; var rc: integer);
    procedure GetRFiles(const StartDir: String; const List: TStrings; var GRFresult: boolean);
    procedure ScriptIfNotFound(Const Operand1: String; Const Operand2: String; Const Operand3: String);
    procedure ScriptIfFound(Const Operand1: String; Const Operand2: String; Const Operand3: String);
    procedure ScriptFindInFile01(Const Operand1: String; Const Operand2: String; Const Operand3: String);
    procedure BuildPlus(Const fieldin: AnsiString; Var fieldout: AnsiString);
    procedure ScriptCopyWNC(Const Operand1: String; Const Operand2: String; Const Operand3: String);
    procedure ScriptRename(Const Operand1: String; Const Operand2: String; Const Operand3: String);
    procedure ScriptIfne(Const Operand1: String; Const Operand2: String; Const Operand3: String);
    procedure ScriptIfgt(Const Operand1: String; Const Operand2: String; Const Operand3: String);
    procedure ScriptCopyAsis(Const Operand1: String; Const Operand2: String; Const Operand3: String);
    procedure ScriptDeleteFile(Const Operand1: String; Const Operand2: String; Const Operand3: String);
    procedure ScriptIfeq(Const Operand1: String; Const Operand2: String; Const Operand3: String);
    procedure ScriptGoto(Const Operand1: String; Const Operand2: String; Const Operand3: String);
    procedure ScriptUnsupported(Const Field1: String; Const Field2: String);
    procedure ISOLATETEXT(Const infield: AnsiString; Var outfield: AnsiString);
    procedure ScriptSet(Const Operand1: String; Const Operand2: String; Const Operand3: String);
    procedure ScriptReport(Const Operand1: String; Const Operand2: String; Const Operand3: String);
    procedure ScriptCompare(Const Operand1: String; Const Operand2: String; Const Operand3: String);
    procedure ScriptIncrement(Const Operand1: String; Const Operand2: String; Const Operand3: String);
    procedure ScriptDecrement(Const Operand1: String; Const Operand2: String; Const Operand3: String);
    procedure ScriptIferror(Const Operand1: String; Const Operand2: String; Const Operand3: String);
    procedure ScriptIfnoerror(Const Operand1: String; Const Operand2: String; Const Operand3: String);
    procedure APPLYSCRIPT(const S_REFFILENAME: AnsiString);
    Procedure DoWaitx(J_RUNDATETIME: String);
    procedure FillGrid(const EXECPARM: AnsiString; const PPTH: Ansistring;
     const AITOUSE: AnsiString; StringGrid1: TStringGrid; script: TStringList);
    procedure FormCreate(Sender: TObject);
    Procedure FormShow(Sender: tObject);
    Procedure OnActivate(Sender: TObject);
    Procedure Button1Click(Sender: tObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure CancelAUTORUNClick(Sender: TObject);
  Private
    { Private declarations }
    //
    S_LINETRACKER: TStringList;            // to track script lines executed and related return code
    S_SPERR: Integer;                      // script processing error code
    S_GOTONEXTSTMT: AnsiString;            // a script re-direction "next line" pointer - set by a GOTO statement
    S_LASTSTMTNUM: AnsiString;             // the statement number of the last script statement
    //
    S_ReportNTLSSP: AnsiString;             // next to last script statement processed
    S_ReportLSSP: AnsiString;               // last script statement processed
    S_ReportRecord: AnsiString;            // overall output report line area
    S_ReportLT: AnsiString;                // the segment of the report line having to do with Line Tracker info
    S_ReportMRL: AnsiString;               // most recently encountered script Label name
    S_ReportTF: AnsiString;
    S_ReportStates: AnsiString;
    //
    S_CAPITALIZEREFDATA: AnsiString;       // turn incoming REF data (in memory) to be all caps upon data acquisition
    //
    S_FILESIZE: AnsiString;                // size of the in-focus Ref file
    S_LASTMODDT: AnsiString;               // last modified date of the currently-in-focus Ref file
    S_ATTRREADONLY: AnsiString;            //  Y in this means it is a READ ONLY file
    S_CURRRECORD: AnsiString;              //  the currently-in-focus record from the current Reference file
    S_RECPOINTER: LongInt;                 //  the currently-in-focus record number within current Reference file
    S_RECPOSITION: Integer;                //  a pointer value.   it points to "where" in the record some data was found
    //
    S_RECPOINTERFIF01: LongInt;            //  a saveoff value when leaving Find-in-File routine
    S_STATEFOUNDFIF01: AnsiString;         //  "
    S_RECPOSITIONFIF01: Integer;           //  "
    S_SPERRFIF01: Integer;                 //  "
    //
    S_STATEEQUAL: AnsiString;               // F in this means NOT equal    (T means it WAS equal)
    S_STATELESSTHAN: AnsiString;            // F in this means NOT less than
    S_STATELESSTHANOREQUAL: AnsiString;     // F in this means NOT less than or equal to
    S_STATEGREATERTHAN: AnsiString;         // F in this means NOT greater than
    S_STATEGREATERTHANOREQUAL: AnsiString;  // F in this means NOT greater than or equal to
    S_STATEFOUND: AnsiString;               // F in this means NOT found
    //
    S_STATEERROR: AnsiString;               // F placed here means that there was no error
    //
    S_STATEFOUNDPOSITION: Integer;          // if FOUND IN RECORD is true, this is the POSITION that it was found at
    S_STATEFOUNDRECPOINTER: Integer;        // for FOUND state True, this is the rec num of the rec that the prior FIND was successful on
    S_RUNDATETIME: AnsiString;              // run date and time
    S_RUNDATE: AnsiString;                  // run date
    S_RUNTIME: AnsiString;                  // run time
    S_TEXT0, S_TEXT1, S_TEXT2, S_TEXT3, S_TEXT4, S_TEXT5, S_TEXT6, S_TEXT7, S_TEXT8, S_TEXT9: AnsiString;
    S_PCKD0, S_PCKD1, S_PCKD2, S_PCKD3, S_PCKD4, S_PCKD5, S_PCKD6, S_PCKD7, S_PCKD8, S_PCKD9: LongInt;
    //
    S_PCKD1_STRTEMP: AnsiString;    // temp garygary  garygarygary
    //
    //S_FILESIZE: AnsiString;                 // filesize of the in-focus REF file
    //S_LASTMODDT: AnsiString;                // last modified date of the in-focus REF file
    //S_ATTRREADONLY: AnsiString;             // one byte for Y or N
    //
    //S_DATA1: AnsiString;
    //S_DATA2: AnsiString;
    //S_DATA3: AnsiString;
    //S_DATA4: AnsiString;
    //S_DATA5: AnsiString;
    //S_DATA6: AnsiString;
    //S_DATA7: AnsiString;
    //S_DATA8: AnsiString;
    //S_DATA9: AnsiString;
    //S_FOUNDSWITCH: AnsiString; // is set to Y or N as result of a FIND command
    //S_RESULTSWITCH: AnsiString;  //  set to T (for true) if IF statement is found to be true,   F if found to be false
    //S_DATAINDEX: AnsiString;      //  an in-record pointer to the specific byte that is in question (a FIND will set this value)
    //
    S_LAST_LOADED: AnsiString;              // the path + filename of the last Reference file that was loaded into S_REFFILERECORD
    S_REFFILENAME: AnsiString;              // the full filename of the in-focus Reference file
    S_REFFILESTEM: AnsiString;              // left (STEM) part of the filename for the in-focus Ref file
    S_REFFILEEXTENSION: AnsiString;         // right (Extension) part of the filenmae fo rthe in-focus Ref file
    S_REFNEXTRECORD: AnsiString;            // going to try to NOT need this at all
    S_REFPRIORRECORD: AnsiString;           // going to try to NOT need this at all
    //S_REFCURRRECORD: AnsiString;
    //S_REFFILENAME: AnsiString;
    //S_REFFILENAMEWITHOUTEXTENSION: AnsiString;
    //S_REFFILENAMEEXTENSION: AnsiString;
    //
    S_REFFILERECORD: TStringList;    //  when this variable really exists, it contains indexed list of ALL records in the in-focus REF file (first rec is record zero)
    //
    J_TROVE1CHK: AnsiString;                 //   a trove is a tuck-away data store which will get dumped as output at the end
    J_TROVE1RULE: AnsiString;
    J_TROVE1MOV: AnsiString;
    J_TROVE1: TStringList;
    J_TROVE2CHK: AnsiString;                 //
    J_TROVE2RULE: AnsiString;
    J_TROVE2MOV: AnsiString;
    J_TROVE2: TStringList;
    J_TROVE3CHK: AnsiString;                 //
    J_TROVE3RULE: AnsiString;
    J_TROVE3MOV: AnsiString;
    J_TROVE3: TStringList;
    //
    J_REPORTLINE: TStringList;  // tempStringList := TStringList.Create;
    J_TEXTFIELDREPORTMAXBYTES: Integer;
    J_RUNDATETIME: String;
    J_PATHINOPT: AnsiString;
    J_PATHIN: AnsiString;
    J_FILTER: AnsiString;
    J_RPTTITLE: AnsiString;
    J_RPTNOTE: AnsiString;
    J_RPTFILENAME: AnsiString;    // output file name for the file we create on pathout1
    J_OF1FILENAME: AnsiString;
    J_OF2FILENAME: AnsiString;
    J_OF3FILENAME: AnsiString;
    J_DELIMRPT: AnsiString;
    J_DELIM1: AnsiString;
    J_DELIM2: AnsiString;
    J_DELIM3: AnsiString;
    J_LIMITINFILES: AnsiString;
    J_LIMITRPT: AnsiString;
    J_RPTWHENISAY: AnsiString;
    J_LOGFILENAME: AnsiString;
    J_PATHOUT1: AnsiString;
    J_PATHOUT2: AnsiString;
    J_PATHOUT3: AnsiString;
    //
    PPTH: AnsiString;
    EXECPARM: AnsiString;
    AITOUSE: AnsiString;
    //
    delayseconds: Integer;
    Delay: integer;
    AutoContinue: AnsiString;
    ErrColl: Integer;
    FCount: Integer;
    TimeOut: TDateTime;
    script: tStringList;
    ParmData: tStringList;
    StatementError: tStringList;
    StatementErrorCodes: array of Integer;
    //
  Public
    { Public declarations }
    log: ttextfileout;
    //s: AnsiString; del
    //tfilenm: AnsiString;    del
    //pfilenm: AnsiString;           del
    //x: Integer;    del
    Function DtNow(DT: tDateTime): AnsiString;
  End;

//type
//  TTmColumnTitle = class(TTmObject)
//  private
//    FCellColor: TColor;
//  public
//    property CellColor: TColor read FCellColor write FCellColor;
//  end;



Var
  ppreconform: Tppreconform;

Implementation

//var
//  FG: array of array of TColor;
//  BG: array of array of TColor;

{$R *.dfm}


//    FUNCTIONS


procedure Tppreconform.CancelAUTORUNClick(Sender: TObject);
begin
   CancelAUTORUN.Enabled := False;            // user clicked CANCEL autorun button, so turn this off
   AutoContinue := 'N';
   //
   //    and here, we should cancel the timer and maybe set delayseconds to zero
   TimeOut := IncSecond(Now, 0);
   Delay := 0;
   //Timer1.Enabled := False;
   //delayseconds := 0;
   //
end;




Function Tppreconform.DtNow(DT: tDateTime): AnsiString;
Begin
  Result := EmptyStr;
  Result := datetostr(DT) + ' ' + timetostr(DT) + ': ';
End;



Function IsStrANumber(Const s: AnsiString): Boolean;
Var
  C: PAnsiChar;
Begin
  C := PAnsiChar(s);
  Result := False;
  While C^ <> #0 Do
  Begin
    If Not (C^ In ['0'..'9']) Then
      Exit;
    Inc(C);
  End;
  Result := True;
End;




function FileSizeStr (const filename: string ): string;
var
  size: Int64;
  handle: integer;
begin
  handle := FileOpen(filename, fmOpenRead);
  if handle = -1 then
    result := '??'                                   // unable to open the sought file, so return ?? as the size
  else try
    size := Int64(FileSeek(handle,Int64(0),2));
    case Length(IntToStr(size)) of
      1..3: result := Format ( '%d bytes', [size] );
      4..6: result := Format ( '%f KB', [size / 1E3] );
      7..9: result := Format ( '%f MB', [size / 1E6] );
      10..12: result := Format ( '%f GB', [size / 1E9] );
      13..15: result := Format ( '%f TB', [size / 1E12] );
    end;
  finally
    FileClose ( handle );
  end;
end;




// F comes in as B (blank) or C (colon) or X (check for either blank or colon)
function FindBCX(const F: String; const S: String; const startbyte: Integer): Integer;
var
  z: Integer;
  testbyte: AnsiString;
 begin
   Result := 0;
   for z := startbyte to Length(S) do
    begin
     testbyte := S[z];
     if ((F = 'B') or (F = 'X')) and (testbyte = ' ') then result := z;
     if ((F = 'C') or (F = 'X')) and (testbyte = ':') then result := z;
     //if and (testbyte = ':')) then result := z;
     if result <> 0 then Break;
    end;
 end;



function ISOLOPER(var StartByte: integer; const OperandArea: AnsiString; var EndByte: integer): AnsiString;
var
  i: Integer;
  capturing: AnsiString;
  mybyte: AnsiString;
  countofsc: Integer;
  WorkingWithinQuotes: AnsiString;

LABEL
 EXITNOW;

begin
  capturing := 'N';
  countofsc := 0;
  WorkingWithinQuotes := 'N';
  //
  for i := StartByte to Length(OperandArea) do
      //if (WorkingWithinQuotes = 'Y') and (OperandArea [i] = '"') then WorkingWithinQuotes := 'N';
      //if (WorkingWithinQuotes = 'N') and (OperandArea [i] = '"') then WorkingWithinQuotes := 'Y';
      if capturing = 'Y' then
         begin
           mybyte := OperandArea [i];
           if (WorkingWithinQuotes = 'Y') and (OperandArea [i] = '"') then WorkingWithinQuotes := 'N';
           if (WorkingWithinQuotes = 'N') and (OperandArea [i] = '"') then WorkingWithinQuotes := 'Y';
           if (OperandArea [i] = ' ') and (WorkingWithinQuotes = 'N') then
             begin
               //EndByte := EndByte - 1;
               Break;
             end
           else
             begin
               EndByte := EndByte + 1;
               if EndByte > Length(OperandArea) then Break;
             end
         end
      else
         begin
           mybyte := OperandArea [i];   // gary test
           if (WorkingWithinQuotes = 'Y') and (OperandArea [i] = '"') then WorkingWithinQuotes := 'N';
           if (WorkingWithinQuotes = 'N') and (OperandArea [i] = '"') then WorkingWithinQuotes := 'Y';
           if (OperandArea [i] = ' ') or (OperandArea [i] = CHR(0)) then
              begin
                //if (OperandArea [i] = ' ') then StartByte := Startbyte + 1;
                StartByte := Startbyte + 1;
                //if (OperandArea [i] = CHR(0)) then EndByte := EndByte + 1;
                EndByte := EndByte + 1;
                if (OperandArea [i] = CHR(0)) then
                  begin
                   countofsc := countofsc + 1;
                  end;
              end
           else
              begin
                capturing := 'Y';
                EndByte := StartByte + 1 + countofsc;
              end
         end;
//
result := Copy(OperandArea, StartByte, EndByte - StartByte);
//
if countofsc = 0 then GOTO EXITNOW;
//
EndByte := EndByte - countofsc;
//
EXITNOW:
end;


//function ISOLOPER(var StartByte: integer; const OperandArea: AnsiString; var EndByte: integer): AnsiString;
//var
//  i: Integer;
//  capturing: AnsiString;
//  mybyte: AnsiString;
//
//begin
//  capturing := 'N';
//  //
//  for i := StartByte to Length(OperandArea) do
//      if capturing = 'Y' then
//         begin
//           mybyte := OperandArea [i];
//           if OperandArea [i] = ' ' then
//             begin
//               EndByte := EndByte - 1;
//               Break;
//             end
//           else
//            begin
//               EndByte := EndByte + 1;
//               if EndByte > Length(OperandArea) then Break;
//             end
//         end
//      else
//         begin
//           mybyte := OperandArea [i];   // gary test
//           if ((OperandArea [i] <> ' ') and (OperandArea [i] <> CHR(0))) or (OperandArea [i] = CHR(94)) then
//              begin
//                capturing := 'Y';
//                EndByte := StartByte + 1;
//              end
//           else
//              begin
//                StartByte := Startbyte + 1;
//                if (OperandArea [i] = CHR(0)) then EndByte := EndByte + 1;
//              end
//         end;
//   result := Copy(OperandArea, StartByte, EndByte - StartByte);
//end;




function OccurrencesOfChar(const S: string; const C: char): integer;
var
  i: Integer;
begin
  result := 0;
  for i := 1 to Length(S) do
    if S[i] = C then
      inc(result);
end;




function ScriptLineEdit(const SL: AnsiString; var Operand1: AnsiString;
 var Operand2: AnsiString; var Operand3: AnsiString): integer;        // this will be added to to supply edits of Script lines
var
  OperandArea: AnsiString;
  //OperandCount: Integer;
  countofquotes: Integer;
  countofoperands: Integer;
  //i: Integer;  del
  StartSpot: Integer;
  EndSpot: Integer;
  F: AnsiString;
  P: Integer;
  TrimSL: AnsiString;
  Command: AnsiString;

Label
  EDITEXIT, NOCOLON, QUOTEERR, OPERANDSSET, WRONGNUMOPERANDS, TROVEERR;

begin
  result := 0;
  StartSpot := 1;
  F := 'C';
  //
  TrimSL := TrimLeft(SL);
  P := FindBCX(F, TrimSL, StartSpot);   // set P to byte-position of first (left-most) colon
  if P = 0 then GOTO NOCOLON;
  Command := Copy(TrimSL, 1, P-1);
  OperandArea := Copy(TrimSL, P+1, Length(TrimSL));
  //
  //OperandCount := 0;
  //Operand1 := '';
  //Operand2 := '';
  //Operand3 := '';


  //garygary
  if Command = 'FINDINFILE01' then
    begin
      Command := Command;
    end;
   //garygary






  if Length(OperandArea) = 0 then GOTO OPERANDSSET;
  if (Command = 'RPTTITLE') or (Command = 'RPTNOTE') then
    begin
      //OperandCount := 1;
      Operand1 := OperandArea;
      countofoperands := 1;
      GOTO OPERANDSSET;
    end;
  //
  countofquotes := OccurrencesOfChar(OperandArea, '"');
  if (countofquotes > 0) and (countofquotes mod 2 = 1) then GOTO QUOTEERR;   // an odd num of quotes is problematic

  //if MyNumber mod 2 = 0 then
  //if (countofquotes <> 0) and (countofquotes <> 2) then GOTO QUOTEERR;
  //
  countofoperands := 0;
  StartSpot := 0;
  Operand1 := TrimRight(ISOLOPER(StartSpot, OperandArea, EndSpot));
  //Operand1 := ISOLOPER(StartSpot, OperandArea, EndSpot);
  if Operand1 = '' then GOTO OPERANDSSET;
  countofoperands := countofoperands + 1;
  //
  StartSpot := EndSpot + 1;
  if EndSpot < Length(OperandArea) then
   begin
    //Operand2 := ISOLOPER(StartSpot, OperandArea, EndSpot);
    Operand2 := TrimRight(ISOLOPER(StartSpot, OperandArea, EndSpot));
    if Operand2 = '' then GOTO OPERANDSSET;
    countofoperands := countofoperands + 1;
   end;
  //
  StartSpot := EndSpot + 1;
  if EndSpot < Length(OperandArea) then
   begin
    //Operand3 := ISOLOPER(StartSpot, OperandArea, EndSpot);
    Operand3 := TrimRight(ISOLOPER(StartSpot, OperandArea, EndSpot));
    if Operand3 = '' then GOTO OPERANDSSET;
    countofoperands := countofoperands + 1;
   end;
  //
  if EndSpot < Length(OperandArea) then GOTO WRONGNUMOPERANDS;
  //


  //
OPERANDSSET:
  //
  // IFFOUND can have zero or one operands. If has one operand, it must be a GOTO:nnnn statement+labelname
  if Command = 'IFFOUND' then
   begin
     if countofoperands > 1 then GOTO WRONGNUMOPERANDS;
      // gary, here we just need to confirm that the ONE operand we have is a GOTO with label
     GOTO EDITEXIT;
   end;
  //
  // IFNOTFOUND can have zero or one operands. If has one operand, it must be a GOTO:nnnn statement+labelname
  if Command = 'IFNOTFOUND' then
   begin
     if countofoperands > 1 then GOTO WRONGNUMOPERANDS;
      // gary, here we just need to confirm that the ONE operand we have is a GOTO with label
     GOTO EDITEXIT;
   end;
  //
  //   17) FINDINFILE01 Search exactly ONE time for a given value (optionally, you can indicate
  //   which in-record "row" to search in)
  //   This can have up to three operands:
  //    RECORDRANGE(nnn,yyy) where nnn indicates "which record within curr ref file to start the search in)
  //         and yyy indicates which record is the LAST record in which the search should be done.
  //              RECORDRANGE(DATA5,DATA5+11) would mean to search the TWELVE records only (or up to 12) that are at record counter DATA5.
  //        (For the short term, I will support RECORDRANGE(NEXT,ALL) as "find starting in the next unsearched rec no, and go through end of file")
  //    COLUMNRANGE(ccc,xxx) where ccc is the "column number" within the record to begin the search - and
  //         xxx is the last column number that is to be considered to be in searchable area for each record
  //    %TEXT8  (an operand to explain "what we are seeking").  If this is referring to a work filed,
  //         we should see if that work field appears to be being set ANYWHERE within the script
  if Command = 'FINDINFILE01' then
   begin
     if countofoperands > 3 then GOTO WRONGNUMOPERANDS;
     if countofoperands < 1 then GOTO WRONGNUMOPERANDS;

     // gary - here we need to parse and edit whatever operands are provided
     GOTO EDITEXIT;
   end;
  //
  if Command = 'FINDINRECORD' then
   begin

   GOTO EDITEXIT;
   end;
  //
  // for findfile, just ensure that exactly ONE operand exists
  // (it can be a compound operand, like DATA2+DATA6))
    if Command = 'FINDFILE' then
   begin
     if countofoperands <> 1 then GOTO WRONGNUMOPERANDS;
     GOTO EDITEXIT;
   end;
  //
  //   22) SET   must have exactly TWO operands.  The first operand is set to some value - based on
  //   what the second operand resolves to.  If the second operand is a work data field (DATA03, etc)
  //   then check the overall script to see if that data field appears to be being set at all.
  if Command = 'SET' then
   begin
     if countofoperands <> 2 then GOTO WRONGNUMOPERANDS;
     GOTO EDITEXIT;
   end;
  //
  //    24)  COMPARE    exactly two operands must be provided
  //    for this, just ensure that there are exactly two operands and that both are either
  //    work data names (DATA05, etc) or Script Keyword fields (such as @FILENAME)
  if Command = 'COMPARE' then
   begin
     if countofoperands <> 2 then GOTO WRONGNUMOPERANDS;
     // gary - add checks to validate the KIND of operands here
     GOTO EDITEXIT;
   end;
  //
  //   12) COPYASIS:  Copy current REF file (as it exists in memory) from PATHIN to selcted output path.
  //    There must be exactly ONE operand.  This operand resolves to the output location (path) to which
  //    the file is to be copied.
  if Command = 'COPYASIS' then
   begin
     if countofoperands <> 1 then GOTO WRONGNUMOPERANDS;
     GOTO EDITEXIT;
   end;
  //
  //   13) COPYWNC:   Copy with filename change.  For this command, there must be exactly TWO operands.
  //   The first operand must resolve to a location (path) where the file is to be copied to.  The
  //   second operand must resolve to a FileName.  Both operands can be compound operands.
  if Command = 'COPYWNC' then
   begin
     if countofoperands <> 2 then GOTO WRONGNUMOPERANDS;
     GOTO EDITEXIT;
   end;
  //
  //   25) DELETEFILE    erase an existing file
  //  for edit, we just will check if there are exactly ONE operand provided AND confirm if that operand is
  //  a work field (DATA0, DATA1, etc) - and if so, then see if a line elsewhere (anywhere) in the script
  //  that SETS that field in question... and if so, then consider this statement to pass the edits
  if Command = 'DELETEFILE' then
   begin
     if countofoperands > 1 then GOTO WRONGNUMOPERANDS;
     GOTO EDITEXIT;
   end;
  //
  //   11) GOTO:      Jump to a stated Label within the script.
  //    after the colon, there must be a label name.  so, one check taht we'll need to do is to
  //     confirm that whatever label is pointed to by this GOTO - that label really does exist
  if Command = 'GOTO' then
   begin
     if countofoperands <> 1 then GOTO WRONGNUMOPERANDS;
     // gary - for the one operand received, ensure that the label referred to really DOES exist
     GOTO EDITEXIT;
   end;
  //
  //   23) LABEL:xxx   provides a jump-to script location – for use by a GOTO statement that is
  // somewhere in the logic.   Just ensure that the refferred to LABEL IS defined exactly ONE time in the
  // script.  Also - as you are editing these, complete the JUMPTO array (just a label name and a script
  // pointer).
  if Command = 'LABEL' then
   begin
     if countofoperands <> 1 then GOTO WRONGNUMOPERANDS;
     // gary - for the one operand received, ensure that the specified label name does not already exist (if so, duplicate labell has been requested)
     GOTO EDITEXIT;
   end;
  //
  //
    if (Command = 'INCREMENT') OR (Command = 'DECREMENT') then
   begin
     if countofoperands <> 1 then GOTO WRONGNUMOPERANDS;
     GOTO EDITEXIT;
   end;
  //
  //
    if (Command = 'IFERROR') OR (Command = 'IFNOERROR') then
   begin
     if countofoperands <> 1 then GOTO WRONGNUMOPERANDS;
     GOTO EDITEXIT;
   end;
  //
  //
  //   10) IFEQ (if A operand equals B operand)        example:   IFEQ: DATA1 DATA2
  //   for IFEQ, there may be ZERO or ONE operand.   If there is an operand, it must be a
  //   GOTO command (which includes a target label)
  if Command = 'IFEQ' then
   begin
     if countofoperands > 1 then GOTO WRONGNUMOPERANDS;
     if countofoperands = 0 then GOTO EDITEXIT;
     // gary - for the ONE operand received, confirm that it is a valid GOTO with label
     GOTO EDITEXIT;
   end;
  //
  //   13) IFNE   (if A operand NOT equal to B operand)     example:   IFNE DATA5 DATA4
  //   for IFNE, there may be ZERO or ONE operand.   If there is an operand, it must be a
  //   GOTO command (which includes a target label)
  if Command = 'IFNE' then
   begin
     if countofoperands > 1 then GOTO WRONGNUMOPERANDS;
     if countofoperands = 0 then GOTO EDITEXIT;
     // gary - for the ONE operand received, confirm that it is a valid GOTO with label
     GOTO EDITEXIT;
   end;
  //
  if Command = 'IFLT' then
   begin

   GOTO EDITEXIT;
   end;
   //
  if Command = 'IFGT' then
   begin
     if countofoperands > 1 then GOTO WRONGNUMOPERANDS;
     if countofoperands = 0 then GOTO EDITEXIT;
     GOTO EDITEXIT;
   end;
  //
  if Command = 'IFGE' then
   begin

   GOTO EDITEXIT;
   end;
  //
  if Command = 'IFLE' then
   begin

   GOTO EDITEXIT;
   end;
  //
  //    0) CAPITALIZEREFDATA requires exactly one operand.   It must be a Y or an N.
  if Command = 'CAPITALIZEREFDATA' then
   begin
     if countofoperands <> 1 then GOTO WRONGNUMOPERANDS;
     GOTO EDITEXIT;
   end;
  //
  //    1) PATHIN  exactly one operand must exist for this.  It shows where to look for input REF files.
  if Command = 'PATHIN' then
   begin
     if countofoperands <> 1 then GOTO WRONGNUMOPERANDS;
     // gary - confirm that valid path value is provided, if possible
     GOTO EDITEXIT;
   end;
  //
  //    2) FILTER: provides a filter/mask to limit "which" REF files within PATHIN are processed
  //    If this is not provided, we will seek to get this information via dialogue with user (unless
  //     autorun is on... in which case, we then would apply the script to ALL REF files in PATHIN).
  //     Exactly one operand is provided - and it describes the MASK to use when selecting input REF
  //     files from PATHIN.
  if Command = 'FILTER' then
   begin
     if countofoperands <> 1 then GOTO WRONGNUMOPERANDS;
     // gary - confirm that valid filter value is received, if possible
     GOTO EDITEXIT;
   end;
  //
  //    2) RPTTITLE:  specifies what value to write as first output line in the primary output report
  //    The processing includes a SINGLE textual line at TOP of the main output report.
  //    Whatever information is found to right of the command is considered to be that data which goes tehre.
  if Command = 'RPTTITLE' then
   begin
     if countofoperands <> 1 then GOTO WRONGNUMOPERANDS;
     GOTO EDITEXIT;
   end;
  //
  //    2) RPTNOTE:   specifies what value to write as second output line in primary output report.
  //    When this is present, record TWO written to the primary output "report" will be whatever is in
  //    this record (right of the command value).
  if Command = 'RPTNOTE' then
   begin
     if countofoperands <> 1 then GOTO WRONGNUMOPERANDS;
     GOTO EDITEXIT;
   end;
  //
  //    2) RPTFILENAME: specifies the filename of the final Output (primary) report.
  //    When present, this provides a SINGLE operand - which when resolved (it can be a compound
  //    operand such as "FUNREPORT"+%DATETIME) - provides FILENAME of the output primary report file.
  if Command = 'RPTFILENAME' then
   begin
     if countofoperands <> 1 then GOTO WRONGNUMOPERANDS;
     // gary - attempt to validate that the ONE operand received is a valid filename
     GOTO EDITEXIT;
   end;
  //
  //    2) OF1FILENAME: specifies filename of OUTFILE1
  //    If Output file is written to PATHOUT1, it will use this SINGLE operand as the output filename.
  //    Note: this doesn't apply to REF files copied to PATHOUT1... just work files that the script
  //    logic creates to PATHOUT1.
  if Command = 'OF1FILENAME' then
   begin
     if countofoperands <> 1 then GOTO WRONGNUMOPERANDS;
     // gary - attempt to validate that the ONE operand received is a valid filename
     GOTO EDITEXIT;
   end;
  //
  //    2) OF2FILENAME: specifies filename of OUTFILE2
  //    If Output file is written to PATHOUT2, it will use this SINGLE operand as the output filename
  if Command = 'OF2FILENAME' then
   begin
     if countofoperands <> 1 then GOTO WRONGNUMOPERANDS;
     // gary - attempt to validate that the ONE operand received is a valid filename
     GOTO EDITEXIT;
   end;
  //
  //    2) OF3FILENAME: specifies filename of OUTFILE3
  //    If Output file is written to PATHOUT3, it will use this SINGLE operand as the output filename
  if Command = 'OF3FILENAME' then
   begin
     if countofoperands <> 1 then GOTO WRONGNUMOPERANDS;
     // gary - attempt to validate that the ONE operand received is a valid filename
     GOTO EDITEXIT;
   end;
  //
  //    2) DELIMRPT:  A value to use as field delimiter when constructing report line
  //    A single operand for this provides the value that will be used in separting report fields in rows that make up the primary output report
  if Command = 'DELIMRPT' then
   begin
     if countofoperands <> 1 then GOTO WRONGNUMOPERANDS;
     // gary - validate that the delimiter value received is ONE byte and should 'work'
     GOTO EDITEXIT;
   end;
  //
  //    2) DELIM1:  Another Delimiter value that user can set (for use with outputs which are not the primary report)
  if Command = 'DELIM1' then
   begin
     if countofoperands <> 1 then GOTO WRONGNUMOPERANDS;
     // gary - validate that the delimiter value received is ONE byte and should 'work'
     GOTO EDITEXIT;
   end;
  //
  //    2) DELIM2:  Another Delimiter value that user can set (for use with outputs which are not the primary report)
  if Command = 'DELIM2' then
   begin
     if countofoperands <> 1 then GOTO WRONGNUMOPERANDS;
     // gary - validate that the delimiter value received is ONE byte and should 'work'
     GOTO EDITEXIT;
   end;
  //
  //    2) DELIM3:  Another Delimiter value that user can set (for use with outputs which are not the primary report)
  if Command = 'DELIM3' then
   begin
     if countofoperands <> 1 then GOTO WRONGNUMOPERANDS;
     // gary - validate that the delimiter value received is ONE byte and should 'work'
     GOTO EDITEXIT;
   end;
  //
  //
  //    2) LIMITINFILES:    A number of maximum input REF files allowed to be considered in this run
  //    exactly ONE operand supplies this limiting value
  if Command = 'LIMITINFILES' then
   begin
     if countofoperands <> 1 then GOTO WRONGNUMOPERANDS;
     // gary - validate the value of the ONE operand is usable as a count limiter
     GOTO EDITEXIT;
   end;
  //
  //    2) LIMITRPT:    A number of maximum report entries to allow written to the output report
  //    exactly ONE operand supplies this limiting value
  if Command = 'LIMITRPT' then
   begin
     if countofoperands <> 1 then GOTO WRONGNUMOPERANDS;
     // gary - validate the value of the ONE operand is usable as a count limiter
     GOTO EDITEXIT;
   end;
  //
  //    2) RPTWHENISAY: Directive to ONLY write to the main output report when script processing encounters "REPORT"
  //    A single operand (one position... Y or N) supplies this switch value.
  if Command = 'RPTWHENISAY' then
   begin
     if countofoperands <> 1 then GOTO WRONGNUMOPERANDS;
     // gary - validate the switch value (must by Y or N)
     GOTO EDITEXIT;
   end;
  //
  //    2) REPORT:    used only when RPTWHENISAY is "Y"... encountering this command tells report writer to create and write a report line at this time;
  //    This has exactly one Operand - which provides the info that needs reporting... (can use Complex operand with + to append more fields)
  if Command = 'REPORT' then
   begin
     if countofoperands <> 1 then GOTO WRONGNUMOPERANDS;
     GOTO EDITEXIT;
   end;
  //
  //    2) LOGFILENAME a single operand for this indicates what the outut LOG file name should be;
  //    A single operand supplies filename of the to-be-created log file (can be a compound operand)
  if Command = 'LOGFILENAME' then
   begin
     if countofoperands <> 1 then GOTO WRONGNUMOPERANDS;
     // gary - attempt to validate that the ONE operand received is a valid LOG filename
     GOTO EDITEXIT;
   end;
  //
  //    2) PATHOUT1:  (if creating any work files for reports or OUTFILE1 files)
  //    A single operand supplies PATH value
  if Command = 'PATHOUT1' then
   begin
     if countofoperands <> 1 then GOTO WRONGNUMOPERANDS;
     // gary - confirm that valid path value is provided, if possible
     GOTO EDITEXIT;
   end;
  //
  //    2) PATHOUT2:  (if creating any OUTFILE2 files)
  //    A single operand supplies PATH value
  if Command = 'PATHOUT2' then
   begin
     if countofoperands <> 1 then GOTO WRONGNUMOPERANDS;
     // gary - confirm that valid path value is provided, if possible
     GOTO EDITEXIT;
   end;
  //
  //    2) PATHOUT3:  (if creating any OUTFILE3 files)
  //    A single operand supplies PATH value
  if Command = 'PATHOUT3' then
   begin
     if countofoperands <> 1 then GOTO WRONGNUMOPERANDS;
     // gary - confirm that valid path value is provided, if possible
     GOTO EDITEXIT;
   end;
  //
  if (Command = 'TROVE1') OR (Command = 'TROVE2') OR (Command = 'TROVE3') then
   begin
     if countofoperands <> 3 then GOTO WRONGNUMOPERANDS;
     if copy(Operand1, 1, 5) <> '%TEXT' then GOTO TROVEERR;
     if (copy(Operand3, 1, 5) <> '%TEXT') and (copy(Operand3,1, 4)  <> '%REF') and (copy(Operand3,1, 5)  <> '%PATH') then GOTO TROVEERR;
     if (Operand2 <> 'NULL') and (Operand2 <> 'NOTNULL') then GOTO TROVEERR;
     // gary - could do more checking of operand 1 and 2
     GOTO EDITEXIT;
   end;
  //
  result := 5;    // command is not recognized
  GOTO EDITEXIT;
  //
  //
  //
  GOTO EDITEXIT;
NOCOLON:
  result :=1;     // this command is lacking the colon - which needs to come immediatly after the command
  GOTO EDITEXIT;
  //
TROVEERR:
  result :=4;     // TROVE command is using un-supported operands
  GOTO EDITEXIT;
  //
QUOTEERR:
  result :=6;     // count of quote marks within operand area must be zero or two
  GOTO EDITEXIT;
  //
WRONGNUMOPERANDS:
  result :=7;     // some extra data - which MAY be mistaken as an extra operand - is found in this statement
  GOTO EDITEXIT;
  //
EDITEXIT:
  //
end;









function FindPos(aCh: AnsiChar; const S: String; const startbyte: Integer): Integer;
var
  z: Integer;
  testbyte: AnsiString;
 begin
   Result := 0;
   for z := startbyte to Length(S) do
    begin
     testbyte := S[z];
     if (testbyte = aCh) then Result := z;
     if Result <> 0 then Break;
    end;
     //  begin
     //    Result := z;
     //    Break
     //  end;
 end;








// function FindBlankOrColon(const S: String; const startbyte: Integer): Integer;
//var
//  z: Integer;
//  testbyte: AnsiString;
// begin
//   Result := 0;
//   for z := startbyte to Length(S) do
//    begin
//     testbyte := S[z];
//     if (testbyte = ' ') then result := z;
//     if (testbyte = ':') then result := z;
//     if result <> 0 then Break;
//    end;
// end;













function SecsToHmsStr(ASecs: integer):string;
begin
  Result := Format('%2d:%2.2d:%2.2d',
    [ASecs div 3600, ASecs mod 3600 div 60, ASecs mod 3600 mod 60]);
end;





//   SUBROUTINES



procedure  Tppreconform.GetRFiles(const StartDir: String; const List: TStrings; var GRFresult: boolean);
var
  SRec: TSearchRec;
  Res: Integer;
  filt: AnsiString;
Label
  NOL, GONE;
begin
  filt := '*.*';
  if J_FILTER <> '' then filt := J_FILTER;
  if not Assigned(List) then
  begin
    GRFresult := False;
    Exit;
  end;
  if J_PATHINOPT <> 'L' then goto NOL;
  try
    List.LoadFromFile(J_PATHIN);     // load Ref filenames from user-provided file
  except
    ShowMessage('Job failed when trying to load list of REF files from PATHIN.');
  end;
  goto GONE;
NOL:
  Res := FindFirst(StartDir + filt, faAnyfile, SRec );
  if Res = 0 then
  try
    while res = 0 do
    begin
      if (SRec.Attr and faDirectory <> faDirectory) then
        // If you want filename only, remove "StartDir +"
        // from next line
        //List.Add( StartDir + SRec.Name );
      List.Add(SRec.Name);
      Res := FindNext(SRec);
    end;
  finally
    FindClose(SRec)
  end;
GONE:
  GRFresult := (List.Count > 0);
end;




// garygary there is a lot more to do in this function...
procedure Tppreconform.gettrovedata(const ChkField: AnsiString; const Rule: AnsiString; const MovField: AnsiString; var trovedata: AnsiString; var rc: integer);

var
 worksender: AnsiString;
 workcheck: AnsiString;

begin
  rc := 0;
  //
  ISOLATETEXT(MovField, worksender);
  ISOLATETEXT(ChkField, workcheck);
  //
  trovedata := worksender;
  if (workcheck = '') and (Rule = 'NOTNULL') then rc := 1;
  if (workcheck <> '') and (Rule = 'NULL') then rc := 1;
end;








procedure Tppreconform.ScriptUnsupported(Const Field1: String; Const Field2: String);
//var
// i: Integer;
Begin
  showmessage('Script Line ' + Field1 + ' is using command that is currently unsupported:' + Field2);
End;




//   gary - the next bit to do is to make ISOLATETEXT be able to deal with internal fields, like %REFFILENAME@001(003)
//procedure Tppreconform.ISOLATETEXT(Const infield: AnsiString; Var outfield: AnsiString; Var LI: LongInt);
procedure Tppreconform.ISOLATETEXT(Const infield: AnsiString; Var outfield: AnsiString);
var
//i: Integer;  del
Quote1POS: Integer;
Quote2POS: Integer;

MOVEBYTES: Integer;
MOVEDISPLACEMENT: Integer;
MOVEEND: Integer;
MOVELENGTH: Integer;

POSAT: Integer;
POSOPEN: Integer;
POSCLOSE: Integer;
MOVELEN: AnsiString;
MOVEPOS: AnsiString;

zeros15: AnsiString;

startmark: Integer;
endmark: Integer;

//charArray : Array[0..2] of Char;      del
//strArray  : Array of String;     del

//strA      : String;  del

LABEL
 ISO_NOTDOINGQUOTES, ISOLATETEXTX, ISO_NOTCURRREC, ISO_LFF_NOTNEEDED, ISO_NOTRECPOINTER, ISO_NOTPCKD1, ISO_NOTFWORCR;
begin
  //
  zeros15 := '000000000000000';
  //
  Quote1POS := FindPos('"', infield, 1);
  if Quote1POS = 0 then GOTO ISO_NOTDOINGQUOTES;
  Quote2POS := FindPos('"', infield, Quote1POS+1);
  outfield := copy(infield, Quote1POS+1, Quote2POS - Quote1POS - 1);
  GOTO ISOLATETEXTX;
  //
ISO_NOTDOINGQUOTES:
  outfield := infield;                                        //  assume we should end up with this user-coded constant for this field
  if infield = '%TEXT0' then outfield := S_TEXT0;
  if infield = '%TEXT1' then outfield := S_TEXT1;
  if infield = '%TEXT2' then outfield := S_TEXT2;
  if infield = '%TEXT3' then outfield := S_TEXT3;
  if infield = '%TEXT4' then outfield := S_TEXT4;
  if infield = '%TEXT5' then outfield := S_TEXT5;
  if infield = '%TEXT6' then outfield := S_TEXT6;
  if infield = '%TEXT7' then outfield := S_TEXT7;
  if infield = '%TEXT8' then outfield := S_TEXT8;
  if infield = '%TEXT9' then outfield := S_TEXT9;
  //
  if copy(infield, 1, 12) = '%REFFILENAME' then
   begin
     outfield := S_REFFILENAME;
     if length(infield) = 12 then GOTO ISOLATETEXTX;
     POSAT := FindPos('@', infield, 1);
     POSOPEN := FindPos('(', infield, 1);
     POSCLOSE := FindPos(')', infield, 1);
     if POSOPEN = 0 then POSOPEN := Length(S_REFFILENAME);
     MOVEPOS := copy(infield, POSAT+1, POSOPEN-POSAT-1);
     MOVELEN := IntToStr(Length(S_REFFILENAME) - StrToInt(MOVEPOS) + 1);
     if POSCLOSE <> 0 then MOVELEN := copy (infield, POSOPEN+1, POSCLOSE - POSOPEN - 1);
     outfield := copy(S_REFFILENAME, StrToInt(MOVEPOS), StrToInt(MOVELEN));
   end;
  //
  if infield = '%PATHIN' then outfield := J_PATHIN;
  if infield = '%PATHOUT1' then outfield := J_PATHOUT1;
  if infield = '%PATHOUT2' then outfield := J_PATHOUT2;
  if infield = '%PATHOUT3' then outfield := J_PATHOUT3;
  //
  if infield = '%REFFILEEXTENSION' then
   begin
    outfield := S_REFFILEEXTENSION;
   end;
  if infield = '%REFFILESTEM' then outfield := S_REFFILESTEM;
  //
  //
  ///if copy(infield, 1, 17) <> '%REFCURRENTRECORD' then  GOTO ISO_NOTCURRREC;
  if (copy(infield, 1, 17) <> '%REFCURRENTRECORD') and (copy(infield, 1, 31) <> '%FIRSTWORDOF(%REFCURRENTRECORD)') then  GOTO ISO_NOTCURRREC;
  // okay - we have now learned that we'll need focus on data/content that is within this REF file.
  if S_LAST_LOADED = J_PATHIN + S_REFFILENAME then GOTO ISO_LFF_NOTNEEDED;  // if curr REF file alread loaded, then branch (with S_CURRECORDNUM set how ever it is set...)
  S_RECPOINTER := 0;                                                        // record pointer will show that FIRST recd in file has focus
  if Assigned(S_REFFILERECORD) then S_REFFILERECORD.free;                   // free stringlist if needed
  S_REFFILERECORD:= TStringList.Create;                                     // create stringlist for REF file content
  S_REFFILERECORD.LoadFromFile(J_PATHIN + S_REFFILENAME);                   // put all rows from curr REF file into this stringlist at once
  if S_CAPITALIZEREFDATA = 'Y' Then S_REFFILERECORD.text := UpperCase(S_REFFILERECORD.text);
  WaitForABit(100);                                                         // give Windows a chance to catch up (loading all the records may take a bit)
  S_LAST_LOADED := J_PATHIN + S_REFFILENAME;                                // keep track of which REF file we last loaded into S_REFFILERECORD
  S_CURRRECORD := S_REFFILERECORD[S_RECPOINTER];                            // the in-focus REF file record content
ISO_LFF_NOTNEEDED:
  //
  if copy(infield, 1, 31) = '%FIRSTWORDOF(%REFCURRENTRECORD)' then
    begin
      S_CURRRECORD := S_REFFILERECORD[S_RECPOINTER];
      GOTO ISO_NOTCURRREC;
    end;
  //if copy(infield, 1, 17) <> '%REFCURRENTRECORD' then GOTO ISO_NOTCURRREC;
  outfield := S_CURRRECORD;                                                 // assume for now that we want the ENTIRE in-focus record...
  if Length(infield) = 17 then GOTO ISOLATETEXTX;                           // if no qualifiers after main part of the operand, then we are done
  //
  //here - if position 18 is an @, then find either an set MOVEEND to either the location of an open-paren OR length of this operand
  MOVEEND := Length(infield);                                               // assume it'll be len of infield that we'll need...
  POSOPEN := FindPos('(', infield, 1);                                      // see what position the open-paren is in, if any
  if POSOPEN > 0 then                                                       // if there is an open-paren then that marks the 'end' of the move length data
    begin
      MOVEEND := POSOPEN;
      POSCLOSE := FindPos(')', infield, 1);
    end;
  // MOVEBYTES is zero when SET stmt has @ without immed trailing digits:  SET:%TEXT3 %REFCURRENTRECORD@(000072)
  MOVEBYTES := MOVEEND - 19;                                                // calc num-of-bytes in the script-specified Displacement data
  // garygarygarygary JAN 2024
  if MOVEBYTES = 0 then                               //garygarygarygary Jan 2024
    begin
      MOVEDISPLACEMENT := S_RECPOSITION;
    end
  else
    begin
      MOVEDISPLACEMENT := StrToInt(copy(infield, 19, MOVEBYTES));
    end;
//  MOVEDISPLACEMENT := StrToInt(copy(infield, 19, MOVEBYTES));               // set the script-prescribed "move from" position (within the in-focus REF file record)
  MOVELENGTH := StrToInt(copy(infield, POSOPEN+1, POSCLOSE-POSOPEN-1));     // set move length (if provided)
  outfield := copy(outfield, MOVEDISPLACEMENT, MOVELENGTH);                 // isolate the proper part of the data, now
  //
ISO_NOTCURRREC:
  //
  if copy(infield, 1, 11) <> '%RECPOINTER' then  GOTO ISO_NOTRECPOINTER;    // we do Not need to isolate a field based on %RECPOINTER, so branch
  outfield := IntToStr(S_RECPOINTER);                                       // gary
  outfield := RightStr(zeros15 + outfield, 15);                             // garygary
ISO_NOTRECPOINTER:
  //
  //
  //
  startmark := 0;
  endmark := 0;
  if copy(infield, 1, 31) <> '%FIRSTWORDOF(%REFCURRENTRECORD)' then GOTO ISO_NOTFWORCR;
  outfield := TrimRight(ISOLOPR(startmark, S_CURRRECORD+' ', endmark));
ISO_NOTFWORCR:
  //
  //
  //
  if copy(infield, 1, 6) <> '%PCKD1' then  GOTO ISO_NOTPCKD1;    // we do Not need to isolate a field based on %PCKD1, so branch
  outfield := S_PCKD1_STRTEMP;                                       // garygary
ISO_NOTPCKD1:
  //
ISOLATETEXTX:                                             //garygary - currently testing the SET based on %REFCURRENTRECORD
end;




procedure Tppreconform.WaitForABit(Const TickLimit: Integer);
var
  StartTickCount, CurTicks: DWORD;
begin
// sleep for 5 seconds without freezing
StartTickCount := GetTickCount();
//Start := Ticks;
CurTicks := 0;
repeat
  // (WAIT_OBJECT_0+nCount) is returned when a message is in the queue.
  // WAIT_TIMEOUT is returned when the timeout elapses.
  if MsgWaitForMultipleObjects(0, Pointer(nil)^, FALSE, TickLimit-CurTicks, QS_ALLINPUT) <> WAIT_OBJECT_0 then Break;
  Application.ProcessMessages;
  CurTicks := GetTickCount() - StartTickCount;
  //Elapsed := Ticks - Start;
until CurTicks >= TickLimit;
end;




procedure Tppreconform.ScriptFindInFile01(Const Operand1: String; Const Operand2: String; Const Operand3: String);
var
 i: Integer;
 lasti: Integer;
 P: Integer;
 //WORKLEFT: AnsiString;       del
 //WORKRIGHT: AnsiString;   del
 //compareformat: AnsiString;   del
 soughtdata: AnsiString;
 colendviaop: AnsiString;                 // a switch - to let the below loop know whether the in-play script stmt provided an artificial Column End limiter for searching
 colstart: Integer;
 colend: Integer;
 wrklen: Integer;    // garygarygarygary
 recnostart: Integer;
 recnoend: Integer;
 numofgoodfindsneeded: Integer;
 numofgoodfinds: Integer;
 finddirection: AnsiString;

 temppath: String;
 input: String;
 CreateOk: boolean;
 StartInfo: TStartupInfo;
 ProcInfo: TProcessInformation;
 tempSL: TStringList;
 cresult: Integer;

 //LI: LongInt;

LABEL
 FIF, FIF00, FIF01, FIF01NOTF, FIF01EXIT, FIF_LFF_NOTNEEDED, FIFBEGIN;

Begin
  //
  S_STATEFOUND := 'F';        // assume search will be unsuccessful
  S_STATEERROR := 'T';        // set error state
  //
  //
  //
  S_RECPOINTER := 0;             //  if find is successful, this becomes the Record Number of the record we found
  S_RECPOSITION := 0;            //  a pointer to "where" in the record the data was found
  numofgoodfindsneeded := 1;     //  the number of successful "finds" we are trying for
  finddirection := 'F';          //  indicate that the search for the data should be "F"orward through the file
  colstart :=1;
  recnostart := 0;
  colendviaop := 'N';
  //
  //
  //
  //
  if S_LAST_LOADED = J_PATHIN + S_REFFILENAME then GOTO FIF_LFF_NOTNEEDED;
  //
  S_RECPOINTER := 0;
  if Assigned(S_REFFILERECORD) then S_REFFILERECORD.free;    // doing it this way, you'd load every time a file operation like FINDINFILE is done...
  S_REFFILERECORD:= TStringList.Create;
  S_REFFILERECORD.LoadFromFile(J_PATHIN + S_REFFILENAME);
  if S_CAPITALIZEREFDATA = 'Y' Then S_REFFILERECORD.text := UpperCase(S_REFFILERECORD.text);
  WaitForABit(100);
  S_LAST_LOADED := J_PATHIN + S_REFFILENAME;
  if S_REFFILERECORD.Count > 0 then S_CURRRECORD := S_REFFILERECORD[S_RECPOINTER];
  GOTO FIFBEGIN;
 //
FIF_LFF_NOTNEEDED:
  if S_SPERRFIF01 > 0 then GOTO FIFBEGIN;    //  if prior call to FIF01 was not able to find what was sought, branch
  //              gary - set these things for a CONTINUANCE of the search, now
  S_RECPOINTER := S_RECPOINTERFIF01;
  recnostart := S_RECPOINTERFIF01;
  S_RECPOSITION := S_RECPOSITIONF01;
  colstart := S_RECPOSITIONFIF01 + 1;
  //
 // if not Assigned(S_REFFILERECORD) then
 //  S_REFFILERECORD:= TStringList.Create;
 //  S_REFFILERECORD.LoadFromFile(J_PATHIN + S_REFFILENAME);
 //  WaitForABit(100);
  //
  //if S_REFFILERECORD.Count < 1 then GOTO FIF01NOTF;
  //
  //S_RECPOINTER := 0;             //  if find is successful, this becomes the Record Number of the record we found
  //S_RECPOSITION := 0;            //  a pointer to "where" in the record the data was found
  //numofgoodfindsneeded := 1;     //  the number of successful "finds" we are trying for
  //finddirection := 'F';          //  indicate that the search for the data should be "F"orward through the file
  //colstart :=1;
  //recnostart := 0;
  //recnoend := S_REFFILERECORD.Count;
  //colendviaop := 'N';
  //
  //
FIFBEGIN:
  recnoend := S_REFFILERECORD.Count;
  if S_REFFILERECORD.Count < 1 then GOTO FIF01NOTF;
  //
  //
  //
  ISOLATETEXT(Operand2, soughtdata);   // put Operand2 data into field "soughtdata"
  //
  //    gary - for Jan, 2024 mods, I'm turning off this next if stmt
  //
  //if (soughtdata = 'RECORDANGE(next,end)') OR (soughtdata = 'RECORDRANGE(NEXT,END)') Then
  //  begin
  //    recnostart := S_STATEFOUNDECPOINTER + 1;      // to be able to keep looking beyond place where last FIND was successful
  //  end;
  //
  //
  //
  //
  //
  //
  //ISOLATETEXT(Operand1, soughtdata, LI);   // resolve the search data as set forth by the current script statement
  ISOLATETEXT(Operand1, soughtdata);   // resolve the search data as set forth by the current script statement
  //
  //resolve colstart, colend, recnostart, recnoend - these are established based on Operand2 and Operand3.
  // also set colendviaop to "Y" if the user did provide a colend value... see for loop below for 'why we need it'
  //
  //
  cresult := AnsiCompareText(S_REFFILEEXTENSION, '.EXE');
  if cresult = 0 then GOTO FIF;
  //
  cresult := AnsiCompareText(S_REFFILEEXTENSION, '.DLL');
  if cresult = 0 then GOTO FIF;
  //
  //if S_REFFILEEXTENSION = '.EXE' then  GOTO FIF;
  //if S_REFFILEEXTENSION = '.DLL' then  GOTO FIF;
  //
  GOTO FIF00;
  //
FIF:            // for now, only DLL and EXE files will use this method:
  try
    temppath := TPath.Combine(TPath.GetTempPath, '$P');
    if not TDirectory.Exists(temppath) then
      TDirectory.CreateDirectory(temppath);
    TFile.WriteAllText(TPath.Combine(temppath, '$Pwork.txt'), '.');
  except
    Showmessage('Script FIND command in binary or executable files requires access to Temp file storage - but could not access that.');
  end;

  FillChar(StartInfo, SizeOf(TStartupInfo), #0);
  FillChar(ProcInfo, SizeOf(TProcessInformation), #0);
  StartIfo.cb := SizeOf(TStartupInfo);
  input := GetEnvironmentVariable('COMSPEC') + ' /C FINDSTR /m /i ' + soughtdata + ' ' + J_PATHIN + S_REFFILENAME + ' > ' +  temppath + '\' + '$Pwork.txt';
  UniqueString(input);
  CreateOK := CreateProcess(
  nil,
  PChar(input),
  nil,
  nil,
  False,
  CREATE_NEW_PROCESS_GROUP or NORMAL_PRIORITY_CLASS,
  nil,
  nil,
  StartInfo,
  ProcInfo
);
  //'D:\Qport\trunk\Qport',
  //  PChar(J_PATHIN+S_REFFILENAME),
  If CreateOK then WaitForSingleObject(ProcInfo.hProcess, INFINITE); // in case you want to wait for Process to terminate
  CloseHandle(ProcInfo.hProcess);
  CloseHandle(ProcInfo.hThread);
  //
  tempSL := TStringList.Create;
  try
    tempSL.LoadFromFile(temppath + '\' + '$Pwork.txt');
    if (tempSL.Text <> '') AND (tempSL.Text <> '.') then
      begin
        numofgoodfinds := numofgoodfinds + 1;
        S_STATEFOUND := 'T';
        S_SPERR := 0;
        S_STATEFOUNDRECPOINTER := 1;
        S_RECPOINTER := 1;
        S_CURRECORD := S_REFFILERECORD[0];
        S_RECPOSITION := P;
      end;
  finally
    tempSL.Free;
  end;
  //
  GOTO FIF01;
  //
FIF00:
  // For i := recnostart To recnoend - 1 Do  //  THIS IS THE ORIGINAL ONE - WHICH I THINK WORKS
  // For i := recnostart -1 to recnoend - 1 Do   // TRYING THIS   garygarygarygary
  lasti := recnostart;
  For i := recnostart To recnoend - 1 Do  // THIS IS THE ORIGINAL ONE - PUTTING THIS BACK ON JAN262024
    Begin
    //
      if i > lasti then colstart := 1;
      lasti := i;
    //
      wrklen := Length(S_REFFILERECORD[i]);
      if colendviaop = 'N' then
        Begin
         colend := wrklen; //Length(S_REFFILERECORD[i]);    // note: if colend WAS set via operand, then colend has already been set... via above stmts
        End;
      //
      P := PosEx(soughtdata, S_REFFILERECORD[i], colstart);    //
      //
      If (P <> 0) And (P >= colstart) And (P <= colend) Then
        Begin
          numofgoodfinds := numofgoodfinds + 1;
          if numofgoodfinds = numofgoodfindsneeded Then
             begin
               S_STATEFOUND := 'T';
               S_RECPOINTER := i + 1;
               //
               S_CURRRECORD := S_REFFILERECORD[i];         //
               //
               S_RECPOSITION := P;
               S_STATEFOUNDRECPOINTER := i + 1;
               S_SPERR := 0;
               Break;
             end;
        End;
    End;
  //
FIF01:
  if S_STATEFOUND = 'T' then 
    begin
      S_STATEERROR := 'F';           //  show that no error occurred
      GOTO FIF01EXIT;
    end;
  //
FIF01NOTF:
    S_SPERR := 1;                 //  we were not able to find what user asked to find
    S_STATEFOUNDRECPOINTER := 0;  //  reset this - since FIND was not successful
  //
FIF01EXIT:
  S_RECPOINTERFIF01 := i;
  S_STATEFOUNDFIF01 := S_STATEFOUND;
  S_RECPOSITIONFIF01 := S_RECPOSITION;
  S_SPERRFIF01 := S_SPERR;
End;



procedure Tppreconform.ScriptIncrement(Const Operand1: String; Const Operand2: String; Const Operand3: String);
LABEL
 INCREMENTEXIT, INCREMENTERR8;
Begin
  S_SPERR := 0;
  S_STATEERROR := 'F';         //  assume that no error will occur
  //
  if copy(Operand1, 1, 11) <> '%RECPOINTER' then GOTO INCREMENTERR8;
  //
  S_RECPOINTER := S_RECPOINTER + 1;
  if S_RECPOINTER = S_REFFILERECORD.Count then    // if have already maxed out, just set error 1 and exit
    begin
      S_STATEERROR := 'T';         //  show that an error occurred
      S_SPERR := 1;
      GOTO INCREMENTEXIT;
    end;
  //
  //S_CURRRECORD := S_REFFILERECORD[S_RECPOINTER];
  //S_RECPOINTER := S_RECPOINTER + 1;
  GOTO INCREMENTEXIT;
  //
INCREMENTERR8:
  S_STATEERROR := 'T';           //  show that an error occurred
  S_SPERR := 8;                  //
INCREMENTEXIT:
End;




procedure Tppreconform.ScriptDecrement(Const Operand1: String; Const Operand2: String; Const Operand3: String);
LABEL
 DECREMENTEXIT, DECREMENTERR8;
Begin
  S_SPERR := 0;
  S_STATEERROR := 'F';         //  assume that no error will occur
  //
  if copy(Operand1, 1, 11) <> '%RECPOINTER' then GOTO DECREMENTERR8;
  //
  if S_RECPOINTER = 0 then    // if have already maxed out, just set error 1 and exit
    begin
      S_STATEERROR := 'T';         //  show that an error occurred
      S_SPERR := 1;
      GOTO DECREMENTEXIT;
    end;
  //
  //S_CURRRECORD := S_REFFILERECORD[S_RECPOINTER];  //garygarygary note that this is currently BEFORE the minus one...
  S_RECPOINTER := S_RECPOINTER -1;
  GOTO DECREMENTEXIT;
  //
DECREMENTERR8:
  S_STATEERROR := 'T';           //  show that an error occurred
  S_SPERR := 8;                  //
DECREMENTEXIT:
End;



procedure Tppreconform.ScriptIferror(Const Operand1: String; Const Operand2: String; Const Operand3: String);
//var
 //i: Integer;   del
// WORKRIGHT: AnsiString;
LABEL
 IFERREXITNOW;
Begin                                  // gary - might want to clean up the below... next sentence implies it is okay to not have an 'operand1'... and its not ok
  if (S_STATEERROR = 'T') and (Operand1 = '') then GOTO IFERREXITNOW;    // if no goto exists in this command AND if the "IF" passes...  then branch
  //
  if (S_STATEERROR = 'T') then
    begin
      ScriptGoto(Operand1, '', '');        // this just sets field S_GOTONEXTSTMT to the STATEMENT NUMBER that we should bounce to
      GOTO IFERREXITNOW;
    end;
  //
  IFERREXITNOW:
  //
End;





procedure Tppreconform.ScriptIfnoerror(Const Operand1: String; Const Operand2: String; Const Operand3: String);
//var
 //i: Integer;   del
// WORKRIGHT: AnsiString;
LABEL
 IFNOERREXITNOW;
Begin                                  // gary - might want to clean up the below... next sentence implies it is okay to not have an 'operand1'... and its not ok
  if (S_STATEERROR = 'F') and (Operand1 = '') then GOTO IFNOERREXITNOW;    // if no goto exists in this command AND if the "IF" passes...  then branch
  //
  if (S_STATEERROR = 'F') then
    begin
      ScriptGoto(Operand1, '', '');        // this just sets field S_GOTONEXTSTMT to the STATEMENT NUMBER that we should bounce to
      GOTO IFNOERREXITNOW;
    end;
  //
  IFNOERREXITNOW:
  //
End;





procedure Tppreconform.ScriptCompare(Const Operand1: String; Const Operand2: String; Const Operand3: String);
var
 //i: Integer; del
 WORKLEFT: AnsiString;
 WORKRIGHT: AnsiString;
 compareformat: AnsiString;
 //LI: LongInt;
LABEL
 COMPARENUM, COMPAREEXIT, COMPAREISEQUAL, COMPAREISGREATER;
Begin
  //showmessage('Compare Operand2:'+Operand2);
  //
  S_SPERR := 0;
  //
  //
  //
  //S_TEXT1 := 'JEG';   // for a test
  //
  //
  //
  //
  S_STATEERROR := 'F';          //  assume that no error will occur
  S_STATEEQUAL := 'F';
  S_STATELESSTHANOREQUAL := 'F';
  S_STATEGREATERTHANOREQUAL := 'F';
  S_STATELESSTHAN := 'F';
  S_STATEGREATERTHAN := 'F';
  //
  compareformat := 'P';                                           // assume it will be a packed (numeric) compare
  if copy(Operand1, 1, 5) = '%TEXT' then compareformat := 'T';    // indicate that we are to compare Text
  if copy(Operand1, 1, 1) = '"' then compareformat := 'T';
  //
  if compareformat = 'P' then GOTO COMPARENUM;
  //
  //ISOLATETEXT(Operand1, WORKLEFT, LI);                                // whatever value is indicated by operand1 now goes into field WORKLEFT
  //ISOLATETEXT(Operand2, WORKRIGHT, LI);                               // whatever data value is indicated by operand2 goes into WORKRIGHT
  ISOLATETEXT(Operand1, WORKLEFT);                                // whatever value is indicated by operand1 now goes into field WORKLEFT
  ISOLATETEXT(Operand2, WORKRIGHT);                               // whatever data value is indicated by operand2 goes into WORKRIGHT
  //
  if WORKLEFT = WORKRIGHT then GOTO COMPAREISEQUAL;
  if WORKLEFT > WORKRIGHT then GOTO COMPAREISGREATER;
  //
  S_STATELESSTHANOREQUAL := 'T';
  S_STATELESSTHAN := 'T';
  GOTO COMPAREEXIT;
  //
COMPAREISGREATER:
  S_STATEGREATERTHANOREQUAL := 'T';
  S_STATEGREATERTHAN := 'T';
  GOTO COMPAREEXIT;
  //
COMPAREISEQUAL:
  S_STATEEQUAL := 'T';
  S_STATELESSTHANOREQUAL := 'T';
  S_STATEGREATERTHANOREQUAL := 'T';
  GOTO COMPAREEXIT;
  //
COMPARENUM:
  S_STATEERROR := 'T';           //  show that an error occurred
  S_SPERR := 8;                  // for now, we don't have all of the COMPARE logic in place
COMPAREEXIT:
End;






procedure Tppreconform.ScriptSet(Const Operand1: String; Const Operand2: String; Const Operand3: String);
var
 //LI: LongInt;
 WORKRIGHT: AnsiString;
 targetformat: AnsiString;
 SaveOperand2: AnsiString;
 WorkOperand2: AnsiString;
 UL_Switch: AnsiString;
 Paren1POS: Integer;
 Paren2POS: Integer;
LABEL
 SETBP, SETNUM, SETNUMBAD, SETEXIT;
Begin
  S_SPERR := 0;
  S_STATEERROR := 'F';           //  assume that no error will occur
  //
  SaveOperand2 := Operand2;         // save off what Operand2 came in as
  WorkOperand2 := Operand2;         // make working version of this field
  UL_Switch := '';                  // indicate that Operand2 does NOT include a request to make something upper or lower case...
  //
  if Operand1 = '%TEXT6' then         // garygary temptemp
     begin
       S_REFFILENAME := S_REFFILENAME; // garygary temp stuff
     end;
  //
  //
  if Copy(WorkOperand2, 1, 18) = '%REFCURRENTRECORD@' then         // garygary temptemp
     begin
       S_REFFILENAME := S_REFFILENAME; // garygary temp stuff
     end;
  //
  targetformat := 'T';                                           // assume it will be a text set
  if (copy(Operand1, 1, 5) = '%PCKD') or (copy(Operand1, 1, 11) = '%RECPOINTER') then             // added recopointer 5/25/2023
    begin
      targetformat := 'P';    // indicate that we are to result in Packed
      if S_REFFILENAME = 'MDADMIN_D4_ANNSTMTSWP_ERRORS.TXT' then
        begin
          S_REFFILENAME := S_REFFILENAME; // garygary temp stuff
        end;
    end;
  //
  if targetformat = 'P' then GOTO SETNUM;
  //
  if (copy(WorkOperand2, 1, 10) = '%UPPERCASE') OR (copy(WorkOperand2, 1, 10) = '%LOWERCASE') then UL_Switch := copy(WorkOperand2, 2, 1);
  //
  if UL_Switch = '' then GOTO SETBP;
  //
  Paren1POS := FindPos('(', WorkOperand2, 1);
  Paren2POS := FindPos(')', WorkOperand2, 1);
  WorkOperand2 := copy(WorkOperand2, Paren1POS+1, Paren2POS - Paren1POS - 1);
  //
SETBP:
  //
  BuildPlus(WorkOperand2, WORKRIGHT);   // use Operand2 info to construct some "sending" value for this SET instruction
  //
  WorkOperand2 := SaveOperand2;
  //
  if UL_Switch = 'U' then WORKRIGHT := AnsiUpperCase(WORKRIGHT);
  if UL_Switch = 'L' then WORKRIGHT := AnsiLowerCase(WORKRIGHT);
  UL_Switch := '';  
  //
  if Operand1 = '%TEXT0' then S_TEXT0 := WORKRIGHT;
  if Operand1 = '%TEXT1' then S_TEXT1 := WORKRIGHT;
  if Operand1 = '%TEXT2' then S_TEXT2 := WORKRIGHT;
  if Operand1 = '%TEXT3' then S_TEXT3 := WORKRIGHT;
  if Operand1 = '%TEXT4' then S_TEXT4 := WORKRIGHT;
  if Operand1 = '%TEXT5' then S_TEXT5 := WORKRIGHT;
  if Operand1 = '%TEXT6' then S_TEXT6 := WORKRIGHT;
  if Operand1 = '%TEXT7' then S_TEXT7 := WORKRIGHT;
  if Operand1 = '%TEXT8' then S_TEXT8 := WORKRIGHT;
  if Operand1 = '%TEXT9' then S_TEXT9 := WORKRIGHT;
  if copy(Operand1, 1, 5) = '%TEXT' then GOTO SETEXIT;
  //
  if Operand1 = '%REFCURRENTRECORD' then
    begin
      S_CURRRECORD := WORKRIGHT;
      S_REFFILERECORD[S_RECPOINTER-1] := S_CURRRECORD;
      GOTO SETEXIT;
    end;
 //
SETNUM:
  BuildPlus(WorkOperand2, WORKRIGHT);    // set WORKRIGHT to be numeric version of whatever Operand2 suggests
  //garygary
  if Operand1 = '%PCKD1' then
    begin
      S_PCKD1_STRTEMP := WORKRIGHT;
    end;
  //
  if Operand1 = '%RECPOINTER' then                           //garygary experimental
    begin
      S_RECPOINTER := StrToInt(WORKRIGHT);
      S_STATEFOUNDRECPOINTER := StrToInt(WORKRIGHT);
      GOTO SETEXIT;
    end;
  //
    GOTO SETEXIT;
  //
SETNUMBAD:
  S_STATEERROR := 'T';           //  show that an error occurred
  S_SPERR := 8;                  // for now, we don't have all of the SET logic in place
SETEXIT:
End;







//  this routine will need a lot of work going forward    garygary
procedure Tppreconform.ScriptReport(Const Operand1: String; Const Operand2: String; Const Operand3: String);
Begin
  S_SPERR := 0;
  S_STATEERROR := 'F';         //  assume that no error will occur
  //
  BuildPlus(Operand1, S_ReportRecord);   // use Operand1 info to construct the Report Line
  J_REPORTLINE.Add(S_ReportRecord);  // add an output row to output report now
  //
End;






procedure Tppreconform.ScriptIfgt(Const Operand1: String; Const Operand2: String; Const Operand3: String);
LABEL
 IFGTEXIT;
Begin
  S_SPERR := 0;
  S_STATEERROR := 'F';         //  assume that no error will occur
  if (S_STATEGREATERTHAN = 'T') and (Operand1 = '') then GOTO IFGTEXIT;
  if (S_STATEGREATERTHAN = 'T') then
    begin
      ScriptGoto(Operand1, '', '');       // this just sets field S_GOTOgtXSTMT to the STATEMENT NUMBER that we should bounce to
      GOTO IFGTEXIT;
    end;
  S_STATEERROR := 'T';         //  show that an error occurred
  S_SPERR := 1;                                                       // send back a return code of 1 if the sought condition not met     
IFGTEXIT:
End;     





procedure Tppreconform.ScriptIfne(Const Operand1: String; Const Operand2: String; Const Operand3: String);
//var
 //i: Integer;   del
// WORKRIGHT: AnsiString;

LABEL
 IFNEEXIT;

Begin
  S_SPERR := 0;
  S_STATEERROR := 'F';         //  assume that no error will occur
  if (S_STATEEQUAL = 'F') and (Operand1 = '') then GOTO IFNEEXIT;    // if no goto exists in this command AND if the "IF" passes... then branch
  //
  if (S_STATEEQUAL = 'F') then
    begin
      ScriptGoto(Operand1, '', '');       // this just sets field S_GOTONEXTSTMT to the STATEMENT NUMBER that we should bounce to
      GOTO IFNEEXIT;
    end;
  //
  S_STATEERROR := 'T';         //  show that an error occurred
  S_SPERR := 1;                                                      // send back a return code of 1 if the sought state wasnt found
  //
  if (S_STATEEQUAL = 'T') and (Operand1 <> '') then GOTO IFNEEXIT;   // true would have done the provided goto... but false will just fall thru to next script stmt
  //
  if (S_STATEEQUAL = 'T') then
    begin
      S_GOTONEXTSTMT := S_LASTSTMTNUM;      // no goto was on this stmt... so, the IF is interpreted to just allow fallthrough if true... but, it's false - so jump to end of this script execution now
      GOTO IFNEEXIT;
    end;
  //
  S_STATEERROR := 'T';                                               //  show that an error occurred
  S_SPERR := 7;                                                      // user has tested a State without having done a compare ahead of that
IFNEEXIT:
  //
End;






procedure Tppreconform.ScriptIfFound(Const Operand1: String; Const Operand2: String; Const Operand3: String);
//var
 //i: Integer; del
 //WORKRIGHT: AnsiString;

LABEL
 IFFDEXIT;

Begin
  S_SPERR := 0;
  S_STATEERROR := 'F';         //  assume that no error will occur
  if (S_STATEFOUND = 'T') and (Operand1 = '') then GOTO IFFDEXIT;    // if no goto exists in this command AND if the "IF" passes... then branch
  //
  if (S_STATEFOUND = 'T') then
    begin
      ScriptGoto(Operand1, '', '');       // this just sets field S_GOTONEXTSTMT to the STATEMENT NUMBER that we should bounce to
      GOTO IFFDEXIT;
    end;
  //
  S_STATEERROR := 'T';         //  show that an error occurred
  S_SPERR := 1;                                                      // send back a return code of 1 if the sought state wasnt found
  //
  if (S_STATEFOUND = 'F') and (Operand1 <> '') then GOTO IFFDEXIT;   // true would have done the provided goto... but false will just fall thru to next script stmt
  //
  if (S_STATEFOUND = 'F') then
    begin
      S_GOTONEXTSTMT := S_LASTSTMTNUM;      // no goto was on this stmt... so, the IF is interpreted to just allow fallthrough if true... but, it's false - so jump to end of this script execution now
      GOTO IFFDEXIT;
    end;
  //
  S_STATEERROR := 'T';         //  show that an error occurred
  S_SPERR := 7;                                                      // user has tested a State without having done a compare ahead of that
IFFDEXIT:
  //
End;







procedure Tppreconform.ScriptIfNotFound(Const Operand1: String; Const Operand2: String; Const Operand3: String);
//var
 //i: Integer; del
// WORKRIGHT: AnsiString;

LABEL
 IFNFEXIT;

Begin
  S_SPERR := 0;
  S_STATEERROR := 'F';         //  assume that no error will occur
  if (S_STATEFOUND = 'F') and (Operand1 = '') then GOTO IFNFEXIT;    // if no goto exists in this command AND if the "IF" passes... then branch
  //
  if (S_STATEFOUND = 'F') then
    begin
      ScriptGoto(Operand1, '', '');       // this just sets field S_GOTONEXTSTMT to the STATEMENT NUMBER that we should bounce to
      GOTO IFNFEXIT;
    end;
  //
  S_STATEERROR := 'T';         //  show that an error occurred
  S_SPERR := 1;                                                      // send back a return code of 1 if the sought state wasnt found
  //
  if (S_STATEFOUND = 'T') and (Operand1 <> '') then GOTO IFNFEXIT;   // true would have done the provided goto... but false will just fall thru to next script stmt
  //
  if (S_STATEFOUND = 'T') then
    begin
      S_GOTONEXTSTMT := S_LASTSTMTNUM;      // no goto was on this stmt... so, the IF is interpreted to just allow fallthrough if true... but, it's false - so jump to end of this script execution now
      GOTO IFNFEXIT;
    end;
  //
  S_STATEERROR := 'T';         //  show that an error occurred
  S_SPERR := 7;                                                      // user has tested a State without having done a compare ahead of that
IFNFEXIT:
  //
End;







procedure Tppreconform.ScriptCopyWNC(Const Operand1: String; Const Operand2: String; Const Operand3: String);
var
 //i: Integer; del
 //LI: LongInt;
 selectedopath: AnsiString;
 constructedname: AnsiString;

 Begin
  S_SPERR := 0;
  S_STATEERROR := 'F';         //  assume that no error will occur
  //
  //ISOLATETEXT(Operand1, selectedopath, LI);
  ISOLATETEXT(Operand1, selectedopath);
  BuildPlus(Operand2, constructedname);   // use Operand2 info to construct a value which will be used as a new Filename
  //
  if Assigned(S_REFFILERECORD) then
    begin
      S_REFFILERECORD.SaveToFile(selectedopath + constructedname);
      WaitForABit(100);
    end
  else
    begin
      TFILE.Copy(J_PATHIN + S_REFFILENAME, selectedopath + constructedname);
      WaitForABit(100);
    end;

  //TFILE.Copy(J_PATHIN + S_REFFILENAME, selectedopath + constructedname);
End;







procedure Tppreconform.BuildPlus(Const fieldin: AnsiString; Var fieldout: AnsiString);
var
 i: Integer;
 //LI: LongInt;
 SLsegment: TStringList;
 isolatedresult: AnsiString;

 Begin
  fieldout := '';
  SLsegment := tstringlist.create;
  S_SPERR := 0;
  SLsegment.Text :=  StringReplace(fieldin, '+', #13#10, [rfReplaceAll]);      // note: Use [rfReplaceAll, rfIgnoreCase] if you want to ignore case
  //
  // now, for each of those name 'segments', we need to resolve what each "means":
  //
  for i := 0 to SLsegment.Count-1 do
    begin
      //ISOLATETEXT(SLsegment[i], isolatedresult, LI);
      ISOLATETEXT(SLsegment[i], isolatedresult);
      fieldout := fieldout + isolatedresult;
    end;
  SLsegment.Free;
End;







procedure Tppreconform.ScriptCopyAsis(Const Operand1: String; Const Operand2: String; Const Operand3: String);
var
 //i: Integer; del
 //LI: LongInt;
 selectedopath: AnsiString;
 //pwidechar1: PWideChar;     del
 //pwidechar2: PWideChar;  del

 Begin
  S_SPERR := 0;
  S_STATEERROR := 'F';         //  assume that no error will occur
  //
  //pwidechar1 := S_REFFILENAME;
  //pwidechar2 := S_REFFILENAME;
  //
  selectedopath := J_PATHOUT1;
  //if Operand1 <> '' then ISOLATETEXT(Operand1, selectedopath, LI);
  if Operand1 <> '' then ISOLATETEXT(Operand1, selectedopath);
  //
  if Assigned(S_REFFILERECORD) then
    begin
      S_REFFILERECORD.SaveToFile(selectedopath + S_REFFILENAME);
      WaitForABit(100);
    end
  else
    begin
      TFILE.Copy(J_PATHIN + S_REFFILENAME, selectedopath + S_REFFILENAME);
      WaitForABit(100);
    end;
  ////CopyFile(J_PATHIN + pwidechar1, selectedopath + pwidechar2, False);
  //TFILE.Copy(J_PATHIN + S_REFFILENAME, selectedopath + S_REFFILENAME);
End;





procedure Tppreconform.ScriptDeleteFile(Const Operand1: String; Const Operand2: String; Const Operand3: String);
//var
// i: Integer;

 Begin
  //S_SPERR := 2;
  //if DeleteFile(J_PATHIN + S_REFFILENAME) then S_SPERR := 0;
  TFILE.Delete(J_PATHIN + S_REFFILENAME);
End;




// gary - this one is still in progress
procedure Tppreconform.ScriptRename(Const Operand1: String; Const Operand2: String; Const Operand3: String);
//var
// i: Integer;

 Begin
  //S_SPERR := 2;
  //if DeleteFile(J_PATHIN + S_REFFILENAME) then S_SPERR := 0;
  TFILE.Delete(J_PATHIN + S_REFFILENAME);
End;







procedure Tppreconform.ScriptGoto(Const Operand1: String; Const Operand2: String; Const Operand3: String);
var
 i: Integer;
 //WORKRIGHT: AnsiString;  del
 POSCOLON: Integer;
 SOUGHTLABEL: AnsiString;
 myscriptlinelabelvalue: AnsiString;

Begin
  S_SPERR := 0;
  S_STATEERROR := 'F';         //  assume that no error will occur
  SOUGHTLABEL := Operand1;
  POSCOLON := FindPos(':', Operand1, 1);
  if POSCOLON > 0 then SOUGHTLABEL := TrimLeft(copy(Operand1, POSCOLON+1, Length(Operand1)));
  //
  for i := 0 to StringGrid1.RowCount-1 Do
   begin
     myscriptlinelabelvalue := StringGrid1.Cells[5, i];
     if (StringGrid1.Cells[3, i] = 'LABEL:') and (StringGrid1.Cells[5, i] = SOUGHTLABEL) then
       begin
         S_GOTONEXTSTMT := IntToStr(i);
         Break
       end;
   end;

End;





procedure Tppreconform.ScriptIfeq(Const Operand1: String; Const Operand2: String; Const Operand3: String);
//var
 //i: Integer; del
// WORKRIGHT: AnsiString;

LABEL
 IFEQEXIT;

Begin
  S_SPERR := 0;
  S_STATEERROR := 'F';         //  assume that no error will occur
  if (S_STATEEQUAL = 'T') and (Operand1 = '') then GOTO IFEQEXIT;    // if no goto exists in this command AND if the "IF" passes... then branch
  //
  if (S_STATEEQUAL = 'T') then
    begin
      ScriptGoto(Operand1, '', '');       // this just sets field S_GOTONEXTSTMT to the STATEMENT NUMBER that we should bounce to
      GOTO IFEQEXIT;
    end;
  //
  S_STATEERROR := 'T';         //  show that an error occurred
  S_SPERR := 1;                                                      // send back a return code of 1 if the sought state wasnt found
  //
  if (S_STATEEQUAL = 'F') and (Operand1 <> '') then GOTO IFEQEXIT;   // true would have done the provided goto... but false will just fall thru to next script stmt
  //
  if (S_STATEEQUAL = 'F') then
    begin
      S_GOTONEXTSTMT := S_LASTSTMTNUM;      // no goto was on this stmt... so, the IF is interpreted to just allow fallthrough if true... but, it's false - so jump to end of this script execution now
      GOTO IFEQEXIT;
    end;
  //
  S_STATEERROR := 'T';         //  show that an error occurred
  S_SPERR := 7;                                                      // user has tested a State without having done a compare ahead of that
IFEQEXIT:
  //
End;






procedure Tppreconform.APPLYSCRIPT(const S_REFFILENAME: AnsiString);

var
 i: Integer;
 //CompareResult: Integer;     del
 startstmt: Integer;
 mycommand: AnsiString;

LABEL
 SCRIPTGO;

begin
  startstmt := 0;
  S_ReportNTLSSP := '';                     // next to last script statement processed
  S_ReportLSSP := '';                      // last script statement processed
SCRIPTGO:
  for i := startstmt to StringGrid1.RowCount-1 Do
   begin
     //
     S_GOTONEXTSTMT := '';
     S_ReportNTLSSP := S_ReportLSSP;
     S_ReportLSSP :=  StringGrid1.Cells[3, i] + StringGrid1.Cells[4, i];
     //
     mycommand :=  StringGrid1.Cells[3, i];
     //Showmessage(mycommand + ' ' + StringGrid1.Cells[4, i]);
     //
     if StringGrid1.Cells[3, i] = 'INCREMENT:' then ScriptIncrement(StringGrid1.Cells[5, i], StringGrid1.Cells[6, i], StringGrid1.Cells[7, i]);
     //
     if StringGrid1.Cells[3, i] = 'DECREMENT:' then ScriptDecrement(StringGrid1.Cells[5, i], StringGrid1.Cells[6, i], StringGrid1.Cells[7, i]);
     //
     if StringGrid1.Cells[3, i] = 'IFERROR:' then ScriptIferror(StringGrid1.Cells[5, i], StringGrid1.Cells[6, i], StringGrid1.Cells[7, i]);
     //
     if StringGrid1.Cells[3, i] = 'IFNOERROR:' then ScriptIfnoerror(StringGrid1.Cells[5, i], StringGrid1.Cells[6, i], StringGrid1.Cells[7, i]);
     //
     if StringGrid1.Cells[3, i] = 'COMPARE:' then ScriptCompare(StringGrid1.Cells[5, i], StringGrid1.Cells[6, i], StringGrid1.Cells[7, i]);
     //
     if StringGrid1.Cells[3, i] = 'FINDINFILELAST:' then ScriptUnsupported(StringGrid1.Cells[1, i], StringGrid1.Cells[3, i]);
     //
     //if StringGrid1.Cells[3, i] = 'FINDINFILE01:' then ScriptUnsupported(StringGrid1.Cells[1, i], StringGrid1.Cells[3, i]);
     if StringGrid1.Cells[3, i] = 'FINDINFILE01:' then ScriptFindInFile01(StringGrid1.Cells[5, i], StringGrid1.Cells[6, i], StringGrid1.Cells[7, i]);
     //
     if StringGrid1.Cells[3, i] = 'RENAME:' then ScriptUnsupported(StringGrid1.Cells[1, i], StringGrid1.Cells[3, i]);
     //
     if StringGrid1.Cells[3, i] = 'OPEN:' then ScriptUnsupported(StringGrid1.Cells[1, i], StringGrid1.Cells[3, i]);
     //
     if StringGrid1.Cells[3, i] = 'WRITE:' then ScriptUnsupported(StringGrid1.Cells[1, i], StringGrid1.Cells[3, i]);
     //
     if StringGrid1.Cells[3, i] = 'CLOSE:' then ScriptUnsupported(StringGrid1.Cells[1, i], StringGrid1.Cells[3, i]);
     //
     if StringGrid1.Cells[3, i] = 'APPEND:' then ScriptUnsupported(StringGrid1.Cells[1, i], StringGrid1.Cells[3, i]);
     //
     //if StringGrid1.Cells[3, i] = 'IFGT:' then ScriptUnsupported(StringGrid1.Cells[1, i], StringGrid1.Cells[3, i]);
     if StringGrid1.Cells[3, i] = 'IFGT:' then ScriptIfgt(StringGrid1.Cells[5, i], StringGrid1.Cells[6, i], StringGrid1.Cells[7, i]);
     //
     if StringGrid1.Cells[3, i] = 'IFLT:' then ScriptUnsupported(StringGrid1.Cells[1, i], StringGrid1.Cells[3, i]);
     //
     //if StringGrid1.Cells[3, i] = 'IFEQ:' then ScriptUnsupported(StringGrid1.Cells[1, i], StringGrid1.Cells[3, i]);
     if StringGrid1.Cells[3, i] = 'IFEQ:' then ScriptIfeq(StringGrid1.Cells[5, i], StringGrid1.Cells[6, i], StringGrid1.Cells[7, i]);
     //
     if StringGrid1.Cells[3, i] = 'IFLE:' then ScriptUnsupported(StringGrid1.Cells[1, i], StringGrid1.Cells[3, i]);
     //
     if StringGrid1.Cells[3, i] = 'IFGE:' then ScriptUnsupported(StringGrid1.Cells[1, i], StringGrid1.Cells[3, i]);
     //
     //if StringGrid1.Cells[3, i] = 'IFNE:' then ScriptUnsupported(StringGrid1.Cells[1, i], StringGrid1.Cells[3, i]);
     if StringGrid1.Cells[3, i] = 'IFNE:' then ScriptIfne(StringGrid1.Cells[5, i], StringGrid1.Cells[6, i], StringGrid1.Cells[7, i]);
     //
     //if StringGrid1.Cells[3, i] = 'GOTO:' then ScriptUnsupported(StringGrid1.Cells[1, i], StringGrid1.Cells[3, i]);
     if StringGrid1.Cells[3, i] = 'GOTO:' then ScriptGoto(StringGrid1.Cells[5, i], StringGrid1.Cells[6, i], StringGrid1.Cells[7, i]);
     //
     if StringGrid1.Cells[3, i] = 'MOVEASIS:' then ScriptUnsupported(StringGrid1.Cells[1, i], StringGrid1.Cells[3, i]);
     //
     if StringGrid1.Cells[3, i] = 'MOVEWNC:' then ScriptUnsupported(StringGrid1.Cells[1, i], StringGrid1.Cells[3, i]);
     //
     //if StringGrid1.Cells[3, i] = 'COPYASIS:' then ScriptUnsupported(StringGrid1.Cells[1, i], StringGrid1.Cells[3, i]);
     if StringGrid1.Cells[3, i] = 'COPYASIS:' then ScriptCopyAsis(StringGrid1.Cells[5, i], StringGrid1.Cells[6, i], StringGrid1.Cells[7, i]);
     //
     //if StringGrid1.Cells[3, i] = 'COPYWNC:' then ScriptUnsupported(StringGrid1.Cells[1, i], StringGrid1.Cells[3, i]);
     if StringGrid1.Cells[3, i] = 'COPYWNC:' then ScriptCopyWNC(StringGrid1.Cells[5, i], StringGrid1.Cells[6, i], StringGrid1.Cells[7, i]);
     //
     //if StringGrid1.Cells[3, i] = 'IFFOUND:' then ScriptUnsupported(StringGrid1.Cells[1, i], StringGrid1.Cells[3, i]);
     if StringGrid1.Cells[3, i] = 'IFFOUND:' then ScriptIfFound(StringGrid1.Cells[5, i], StringGrid1.Cells[6, i], StringGrid1.Cells[7, i]);
     //
     //if StringGrid1.Cells[3, i] = 'IFNOTFOUND:' then ScriptUnsupported(StringGrid1.Cells[1, i], StringGrid1.Cells[3, i]);
     if StringGrid1.Cells[3, i] = 'IFNOTFOUND:' then ScriptIfNotFound(StringGrid1.Cells[5, i], StringGrid1.Cells[6, i], StringGrid1.Cells[7, i]);
     //
     //if StringGrid1.Cells[3, i] = 'SET:' then ScriptUnsupported(StringGrid1.Cells[1, i], StringGrid1.Cells[3, i]);
     if StringGrid1.Cells[3, i] = 'SET:' then ScriptSet(StringGrid1.Cells[5, i], StringGrid1.Cells[6, i], StringGrid1.Cells[7, i]);
     //
     if StringGrid1.Cells[3, i] = 'REPORT:' then ScriptReport(StringGrid1.Cells[5, i], StringGrid1.Cells[6, i], StringGrid1.Cells[7, i]);
     //
     // FOr the label command: there is really NOTHING to process on these lines... so, allow it to be skipped over
     //if StringGrid1.Cells[3, i] = 'LABEL:' then ScriptUnsupported(StringGrid1.Cells[1, i], StringGrid1.Cells[3, i]);
     if StringGrid1.Cells[3, i] = 'LABEL:' then S_ReportMRL := StringGrid1.Cells[5, i];
     //
     //if StringGrid1.Cells[3, i] = 'DELETEFILE:' then ScriptUnsupported(StringGrid1.Cells[1, i], StringGrid1.Cells[3, i]);
     if StringGrid1.Cells[3, i] = 'DELETEFILE:' then ScriptDeleteFile(StringGrid1.Cells[5, i], StringGrid1.Cells[6, i], StringGrid1.Cells[7, i]);
     //
     S_LINETRACKER.Add(IntToStr(i));            // add a pair of values here (the stmt number for the curr script line AND the return code value it produced)
     S_LINETRACKER.Add(IntToStr(S_SPERR));
     //
     if S_GOTONEXTSTMT <> '' then Break;
   end;
   //
   if S_GOTONEXTSTMT <> '' then
     begin
       startstmt := StrToInt(S_GOTONEXTSTMT);       // honor the provided "GOTO"
       S_GOTONEXTSTMT := '';
       GOTO SCRIPTGO;
     end;
   //
end;





procedure Split(const ParmValu: string; Delimiter: Char; ListOfStrings: TStrings) ;
begin
   ListOfStrings.Clear;
   ListOfStrings.Delimiter       := Delimiter;
   ListOfStrings.StrictDelimiter := True; // Requires D2006 or newer.
   ListOfStrings.DelimitedText   := ParmValu;
end;





//procedure TForm6.Timer1Timer(Sender: TObject);
//begin
//  Label1.Caption := SecsToHmsStr(SecondsBetween(Now, TimeOut));
//  if Now > Timeout then Timer1.Enabled := False;
//end;



//Procedure DoWaitx(delayseconds: Integer; Delay: Integer; Timeout: TDateTime);
Procedure Tppreconform.DoWaitx(J_RUNDATETIME: String);
var
  Start, Elapsed: DWORD;
Begin
 // sleep for N seconds
  Start := GetTickCount;
  Delay := delayseconds * 1000;
  Elapsed := 0;
  //
  repeat
    // (WAIT_OBJECT_0+nCount) is returned when a message is in the queue.
    // WAIT_TIMEOUT is returned when the timeout elapses.
    //if MsgWaitForMultipleObjects(0, Pointer(nil)^, FALSE, 11000-Elapsed, QS_ALLINPUT) <> WAIT_OBJECT_0 then Break;
    Application.ProcessMessages;
    //Elapsed := GetTickCount - Start;
    if Delay = 0 then          // during the countdown, user may click the button which cancels the auto run
     begin                     // when that is clicked, this delay/wait is canceled and that button is made non-working
      Elapsed := 1;
      Break;
     end
    else
     begin
      Elapsed := GetTickCount - Start;
     end;
  until Elapsed >= Delay;
  //
  //Showmessage('The Delay is complete - continue with processing now, since user did not press RUN.');
  //
 End;




procedure Tppreconform.FillGrid(const EXECPARM: AnsiString; const PPTH: Ansistring;
     const AITOUSE: AnsiString; StringGrid1: TStringGrid; script: TStringList);
var
  F: AnsiString;
  tempStringList: TStringList;
  string1, string2, string3, string4: AnsiString;
  row: integer;
  tblsource: AnsiString;
  tbldesc: AnsiString;
  i: Integer;
  startbyte: Integer;
  myPOS: Integer;
  testint: Integer;
  Operand1: AnsiString;
  Operand2: AnsiString;
  Operand3: AnsiString;
begin
  string1 := 's1';
  string2 := 's2';
  string3 := 's3';
  string4 := 's4';
  //
  tblsource := 'ExecParm';
  tbldesc := 'Exec Path';
  //
  row := 0;
  StringGrid1.Font.Color := clRed;
  StringGrid1.Cells[0, row] := '0';
  StringGrid1.Cells[1, row] := 'ITEM NO';
  StringGrid1.Cells[2, row] := 'SOURCE';
  StringGrid1.Cells[3, row] := 'KEYWORD';
  StringGrid1.Cells[4, row] := 'OPERAND';
  //
  row := row + 1;
  StringGrid1.Cells[0, row] := '0';
  StringGrid1.Cells[1, row] := IntToStr(row);
  StringGrid1.Cells[2, row] := 'ExecParm';
  StringGrid1.Cells[3, row] := 'Exec Path';
  StringGrid1.Cells[4, row] := PPTH;
  //
  row := row + 1;
  StringGrid1.Cells[0, row] := '0';
  StringGrid1.Cells[1, row] := IntToStr(row);
  StringGrid1.Cells[2, row] := 'ExecParm';
  StringGrid1.Cells[3, row] := 'Exec Parameters';
  StringGrid1.Cells[4, row] := EXECPARM;
  //
  //   what statements can be encountered within the ApplicationINI?
  //    1) PATHIN
  //     optional:
  //    2) RPTTITLE:  specifies what value to write as first output line in the primary output report
  //    2) RPTNOTE:   specifies what value to write as second output line in primary output report
  //    2) RPTFILENAME: specifies the filename of the final Output (primary) report
  //    2) OF1FILENAME: specifies filename of OUTFILE1
  //    2) OF2FILENAME: specifies filename of OUTFILE2
  //    2) OF3FILENAME: specifies filename of OUTFILE3
  //    2) DELIMRPT:  A value to use as field delimiter when constructing report line
  //    2) DELIMOTH:  Another Delimiter value that user can set (for use with outputs which are not the primary report)
  //    2) RPTMAX:    A number of maximum report entries to allow written to the output report
  //    2) RPTWHENISAY: Directive to ONLY write to the main output report when script processing encounters "REPORT"
  //    2) REPORT:    used only when RPTWHENISAY is "Y"... encountering this command tells report writer to create and write a report line at this time;
  //    2) REFFILTER: provides a filter/mask to limit "which" REF files within PATHIN are processed
  //    2) PATHOUT1:  (if creating any work files for reports or OUTFILE1 files)
  //    2) PATHOUT2:  (if creating any OUTFILE2 files)
  //    2) PATHOUT3:  (if creating any OUTFILE3 files)
  //    3) RENAME:   (to close+rename the current REF file)
  //    4) OPEN:     (open an output file in PATHOUT)
  //    5) WRITE:    (write something to next output row in an output file that has been Opened)
  //    6) CLOSE:    (close an output file in PATHOUT)
  //    7) APPEND:   (open to append to an existing file in PATHOUT)
  //    8) IFAGREATER: See if first listed data item is greater than the second listed item
  //    9) IFALESS:    See if first listed item is less than second listed item
  //   10) IFEQUAL:    See if first listed item has exact same value as second listed item
  //   11) GOTO:      Jump to a stated Label within the script
  //   12) MOVEASIS:   Copy current REF to PATHOUT, and once that copy is done, Delete the PATHIN instance of the file
  //   12  MOVEWNC:    Copy current REF file to PATHOUT with a special/different name for the PATHOUT file - and then delete the PATHIN instance of the file
  //   12) COPYASIS:  Copy current REF file from PATHIN to PATHOUT
  //   13) COPYWNC:   Copy with filename change
  //   14) FIND01     Find first input REF record in current file that has data as specified
  //   15) FIND03 (etc) See if third FIND for the stated data is successful
  //   16) FINDLAST    Find latest occurring instance within the REF file of the stated data
  //   17) FINDINFILE01 Search exactly ONE time for a given value (optionally, you can indicate which in-record "row" to search in)
  //   18) FINDINFILE03 Search three times (unless first or second search failed) for a given value.  If the third find isnt successful, then NOTFOUND condition is set
  //   19) FINDINFILELAST Search for a given value... if found, keep finding until you've found THE LAST such value in the file.
  //   20) IFFOUND Test only the FOUND condition (set by a prior statement) - and only if that is the case, then do whatever is commanded on this line
  //   21) IFNOTFOUND Test only the NOTFOUND condition (as set by prior statement) - and only if that is the case, then do whatever is commanded on this line
  //   22) SET         Put some or all of an existing data field into another data field
  //   23) LABEL:xxx   to supply a jump-to location within the user's script logic - used via "GOTO" statement
  //
  //
  script := TStringList.Create;
  F := 'X';                    // set up to find EITHER a blank or a colon
  StatementError := TStringList.Create;
  tempStringList := TStringList.Create;
  tempStringList.LoadFromFile(AITOUSE);    {Load string from text file}
  //
  for i := 0 to tempStringList.Count-1 do
    begin
      if i = 0 then
       begin
        testint := tempStringList.Count;
        SetLength(StatementErrorCodes, 14) ;
       end;

      if Copy(tempStringList[i], 1, 1) <> '*' then
       begin
        Operand1 := '';
        Operand2 := '';
        Operand3 := '';
        ErrColl := ScriptLineEdit(tempStringList[i], Operand1, Operand2, Operand3);
        StatementError.Add(IntToStr(ErrColl));
        if (ErrColl = 0) or (ErrColl > 0) then
         begin
           script.Add(tempStringList[i]);
           row := row + 1;
           StringGrid1.Font.Color := clPurple;
           //
           if ErrColl > 0 then
            begin
              StringGrid1.DefaultDrawing := False;
              StringGrid1.Font.Color := clGreen;
            end;
           //
           StringGrid1.Cells[0, row] := IntToStr(ErrColl);
           StringGrid1.Cells[1, row] := IntToStr(row);
           StringGrid1.Cells[2, row] := 'Script Line';
           startbyte := 1;
           myPOS := FindBCX(F, tempStringList[i], startbyte);
           if myPOS = 0 then
             begin
               myPOS := Length(tempStringList[i]);
               StringGrid1.Cells[3, row] := Copy(tempStringList[i], 1, myPOS);
               StringGrid1.Cells[4, row] := '';
               StringGrid1.Cells[5, row] := Operand1;
               StringGrid1.Cells[6, row] := Operand2;
               StringGrid1.Cells[7, row] := Operand3;
             end
            else
             begin
               StringGrid1.Cells[3, row] := Copy(tempStringList[i], 1, myPOS);
               StringGrid1.Cells[4, row] := Copy(tempStringList[i], myPOS+1, Length(tempStringList[i]) - myPOS);
               StringGrid1.Cells[5, row] := Operand1;
               StringGrid1.Cells[6, row] := Operand2;
               StringGrid1.Cells[7, row] := Operand3;
             end;
         end;
         S_LASTSTMTNUM := IntToStr(row);                         // this will end up with value of LAST statement number
         StringGrid1.DefaultDrawing := True;
        end;
    end;
    Application.ProcessMessages;
    StringGrid1.RowCount := row+1;
  //
  //
  //  sample code to FINDFIRST and FINDNEXT and FINDCLOSE
  //
  //
  //var
  //searchResult : TSearchRec;
  //
  //begin
  // if FindFirst('Unit1.d*', faAnyFile, searchResult) = 0 then  // find matches to Unit1.d* in current directory
  //    begin
  //      repeat
  //        ShowMessage('File name = '+searchResult.Name);
  //        ShowMessage('File size = '+IntToStr(searchResult.Size));
  //      until FindNext(searchResult) <> 0;
  //      FindClose(searchResult);
  //    end;
  //end;

end;





//        M A I N L I N E
Procedure Tppreconform.Button1Click(Sender: tObject);
Var
  countofdots: Integer;
  trovedata: AnsiString;
  troverc: Integer;
  //RDIR: AnsiString;
  //S_SPERR: Integer;
  //ParmSegment: Array of String;   del
  //searchvalu: AnsiString;    del
  //Ppath: AnsiString;  del
  XFIELDDELIM: AnsiString;
  //FS: TFormatSettings;   del
  //FileDateTime: TDateTime;    del
  //FormattedDateTime: AnsiString;  del
  i: Integer;
  //fad: TWin32FileAttributeData;   del
  //CurrWidth: Integer;  del
  //MaxWidth: Integer;  del
  //FINALO: TextFile;   del
  //TFile, TTFile: TextFile;  del
  //SFile: TextFile;  del
  //CURRREFFILE: AnsiString;
  //OutpTNam: AnsiString;  del
  FileDateI: TDateTime;
  //RFLMODDT: AnsiString;
  //RFEXT: AnsiString;
  //RFSTEM: AnsiString;
  RFSTEMLENGTH: Integer;
  //RFSIZE: AnsiString;
  //myCvalue: Integer;    del
  //saveWTSLC: Integer; del
  //saveN: Integer;        del
  Q: Integer;
  //openDialog: TOpenDialog;   del
  //FworkTSL: tStringList;     del
  //TTYPESTSL: tStringList;  del
  REFFILESSL: tStringList;
  spac4: AnsiString;
  spac10: AnsiString;
  //tmpltnmI: AnsiString;    del
  //tmpltnmO: AnsiString; del
  InptFNam: AnsiString;
  //FCOL: Integer;  del
  //P1COL, P2COL, P1ROW, P2ROW: Integer;    del
  //SCOL: Integer; del
  today: tDateTime;
  CurDt: String;
  //CURDOCNO: AnsiString;           del
  zros10: AnsiString;
  //COMPANY: AnsiString;    del
  //COTXT: AnsiString;    del
  //wfolder: AnsiString;   del
  //workdir: AnsiString;       del
  //workfield: AnsiString;  del

  SR: TSearchRec;
  tempFile: TextFile;
  line: AnsiString;
  Rpath: AnsiString;
//  Spath: AnsiString;        del
//  Opath: AnsiString;   del
//  Sfilename: AnsiString;  del

  RECMX: AnsiString;
  RECM2: AnsiString;
  RECM1: AnsiString;
  REC0: AnsiString;
  RECPLUS1: AnsiString;
  RECPLUS2: AnsiString;
  Triggered: AnsiString;
  sep: AnsiString;

  qualified: integer;

  GRFresult: boolean;

  //S: String;  del
  Canvass: TCanvas;
  Index: integer;
  countoferrors: integer;

  ATTR: integer;

Label
  NOGO, REFFILESDONE, REFTOP, NEXT, SCRIPTSEVERE, KEEPONX, KEEPON1, GO, NOPOSTPROCESSAUTOREPORT, TROVEACCUMDONE;

Begin
  //
  //  the "RUN" button is only enabled for use if there are no script edit errors.  When user presses RUN button,
  //  this procedure is run.   This procedure is the main "script processor" routine.
  //
  //  This routine processes script instruction after script instruction on EACH Reference file encountered from the "list"
  //  of Reference files (that list is created near the top of this routine).
  //
  //  In processing the script statements from the user, there are TWO main things that the script tries to take care of:
  //   a) it tries to keep a set of available data fields current, based on whatever the user's script statement sought to do; and
  //   b) it reads/writes/moves files, etc - based on user's script commands
  //
  //   Here are the fields that this script processor tries to keep current as it goes:
  //
  //    S_FILESIZE: AnsiString;                // size of the in-focus Ref file
  //    S_LASTMODDT: AnsiString;               // last modified date of the currently-in-focus Ref file
  //    S_ATTRREADONLY: AnsiString;            //  Y in this means it is a READ ONLY file
  //    S_CURRRECORD: AnsiString;              //  the currently-in-focus record from the current Reference file
  //
  //    S_STATEEQUAL: AnsiString;               // F in this means NOT equal    (T means it WAS equal)
  //    S_STATELESSTHAN: AnsiString;            // F in this means NOT less than
  //    S_STATELESSTHANOREQUAL: AnsiString;     // F in this means NOT less than or equal to
  //    S_STATEGREATHERTHAN: AnsiString;        // F in this means NOT greater than
  //    S_STATEGREATERTHANOREQUAL: AnsiString;  // F in this means NOT greater than or equal to
  //    S_STATEFOUND: AnsiString;               // F in this means NOT found
  //
  //    S_STATEFOUNDPOSITION: Integer;          // if FOUND IN RECORD is true, this is the POSITION that it was found at
  //    S_CURRRECORDNUM: Integer;               // the NUMBER of the record that current has focus (within curr Ref file)
  //    S_REFFILENAME: AnsiString;              // the full filename of the in-focus Reference file
  //    S_REFFILESTEM: AnsiString;              // left (STEM) part of the filename for the in-focus Ref file
  //    S_REFFILEEXTENSION: AnsiString;         // right (Extension) part of the filenmae fo rthe in-focus Ref file
  //    S_RUNDATETIME: AnsiString;              // run date and time
  //    S_RUNDATE: AnsiString;                  // run date
  //    S_RUNTIME: AnsiString;                  // run time
  //    S_TEXT0, S_TEXT1, S_TEXT2, S_TEXT3, S_TEXT4, S_TEXT5, S_TEXT6, S_TEXT7, S_TEXT8, S_TEXT9: AnsiString;
  //
  lStatus.Caption := 'PPRECON Run was clicked';
  Application.ProcessMessages;
  Button1.Enabled := False;
  //
  // see if any rows in the stringgrid have show-stopper error codes, still... if some errors are there, we cannot continue
  countoferrors := 0;
  for i := 0 to StringGrid1.RowCount-1 Do
    begin
      if StringGrid1.Cells[0, i] <> '0' then countoferrors := countoferrors + 1;
    end;
  //
  if countoferrors > 0 then
    begin
      ShowMessage('SCRIPT ERROR(S) EXIST - CORRECTIONS NEEDED BEFORE WE CAN RUN THIS. Suggest you screen shot the errored line(s) - and update the script.  Then, try this program again.');
      GOTO NOGO;
    end;
  //
  XFIELDDELIM := ',';                                // default field delimiter value for output files that need it
  zros10 := '0000000000';
  spac4 := AnsiString(stringofchar(' ', 4));
  spac10 := AnsiString(stringofchar(' ', 10));
  //
  DateTimeToString(CurDt, 'yyyymmddhhnnsszz', Now);
  today := Now;
  //
  //
  //  set this group only once at start of the run:       gary - still need to fix these up
  //  S_RUNDATETIME: AnsiString;              // run date and time
  //  S_RUNDATE: AnsiString;                  // run date
  //  S_RUNTIME: AnsiString;                  // run time
  //
  //
 //
 // removing block of exec parameter stuff that involves company=    (might reenable it later)
 //
 // COMPANY := '';
 // If (findcmdlineswitch('company=banner') or findcmdlineswitch('Company=Banner') or findcmdlineswitch('COMPANY=BANNER')) Then
 //   begin
 //     COMPANY := '17';
 //     COTXT := 'Banner';
 //   end;
 // If (findcmdlineswitch('company=penn') or findcmdlineswitch('Company=Penn') or findcmdlineswitch('COMPANY=PENN')) Then
 //   begin
 //     COMPANY := 'WP';
 //     COTXT := 'Penn';
 //   end;
 //
 // if COMPANY = '' then
 //   begin
 //     lStatus.Caption := 'Run parameter for COMPANY is missing (example /company=banner).  ABORTING NOW';
 //     Application.ProcessMessages;
 //     ShowMessage('JOB FAILED WHEN SETTING COMPANY VALUE - CALL SUPPORT');
 //     close;
 //     Halt(0);
 //   end;
 //
 // commenting out MASS stuff for now
 //
 // workdir := LGAIni.ReadString(COTXT, 'Workarea', '') + 'MASS\Control\';
 //
 //If findcmdlineswitch('MASS') Then
 // begin
 //  wfolder := 'MASS';
 //  log := ttextfileout.Create(Format('%sPPRECON_%s.log', [WorkAreaUNC + 'MASS\Log\', CurDt]));
 //  log.Write(DtNow(Now) + 'Begin PPRECON program.');
 //  log.Write(DtNow(Now) + 'Exec parm says to work in folder: MASS\CONTROL');
 //  lStatus.Caption := 'Exec parm says to work in folder: MASS\CONTROL';
 //  Application.ProcessMessages;
 // end;
  //
  //
  //
  //
    //  InputBox('The precise DATA VALUE that I am to search for, please:',
	  //    '(put any value here - but we must have at least one byte of data)', '');
    //  InputBox('In WHAT COLUMN NUMBER (within each input record) should I search to find this data? (enter a FOUR-digit numeric, now).',
	  //    'Note: if your entered value exceeds record length, the SEARCH RESULT within that record will be default to Not Found.', '');
    //  InputBox('Now, must your sought data be EXACTLY in Col nnnn?  Answer YES here if the sought data MUST be in Col nnnn.  Answer EOR here if I should search from Col nnnn through End-of-Record for your sought data.',
	  //   'Alternatively - if you want ONLY a PORTION of the record to be searched for the sought data, enter another (higher) column number as the Search-End-Column value.', '');
    //
 //      InputBox('What is the PATH used to locate your SCRIPT file? (Full path.)  The script file is NOT updated during processing.',
 //	    'Note: More options regarding Script processing will be asked separately.', '');
    //
    //
 //      InputBox('Where should I put your Output File? (Full path.) The output will be like a CSV - but will actually be a PIPE-delimited txt file.).',
 //	     'Note: Output file will have file extension of TXT, and its Filename will be like: PPRECON_YYYYMMDD_TTTTTTT.Txt (so, date and time of run included in filename).', '');
      //
      // might add another user input to further qualify the READ files... maybe by Creation or Modified date or by filesize, or by *xxx* qualifier applied to first part of filename, ec
      // might also put some max-output limit... so, once we reach N "found" conditions, stop searching, etc...
      // might also let user specify some things about the Listbox that filled up as the program runs... maybe indicate whether to ONLY show situations where TRIGGER was found... instead of showing ALL of the data from all files
      // for the listbox that shows the inspected records - might remove that or might make it better show the sets of found data (background colors, or fonts, etc)
  ///
  ///
  ///
  ///
  // HERE, WE WILL ASK THE USER TO POINT DIRECTLY TO WHATEVER SCRIPT WE ARE TO USE.
  //
 //  openDialog := TOpenDialog.Create(self);
 //  openDialog.InitialDir := workdir;
 //  openDialog.Options := [ofFileMustExist];
 //  openDialog.Filter := ' all files|*.*';
 //  //
 //  ShowMessage('Select the SCRIPT file that specifies the processing needed.');
 //  lStatus.Caption := 'SELECT THE SCRIPT FILE, NOW';
 //  Application.ProcessMessages;
 //  //
 //  if openDialog.Execute then
 //    begin
 //     FworkTSL := TStringList.Create;
 //     FworkTSL.Text := StringReplace(openDialog.FileName, '\', #13#10, [rfReplaceAll]);
 //     Sfilename := FworkTSL[FworkTSL.Count - 1];
 //     FworkTSL.free;
 //     // HERE, SET "PATH" TO BE EVERYTHING LEFT OF THE FILESPEC IN WHAT OUR USER JUST SELECTED
 //     Spath := copy(openDialog.FileName, 1, (Length(openDialog.FileName) - (Length(Sfilename))));
 //    end
 //   else
 //    begin
 //     lStatus.Caption := 'User canceled run instead of selecting a Script file.';
 //     log.Write(DtNow(Now) + 'User canceled run instead of selecting Script file.');
 //     Application.ProcessMessages;
 //     ShowMessage('Script file not provided; Run Aborted !');
 //     Halt(0);
 //    end;
 //  //
 //  log.Write(DtNow(Now) + 'User-selected location of SCRIPT file is:' + Sfilename);
 //  lStatus.Caption := 'Selected Script file is:' + Sfilename;
 //  //
 //  //
 //  ///
  ///
  ///
  ///
  // HERE, WE WILL ASK THE USER TO POINT DIRECTLY TO ONE OF THE FILES THAT WE WILL BE INTEROGATING.
  //
 //  openDialog := TOpenDialog.Create(self);
 //  openDialog.InitialDir := workdir;
 //  openDialog.Options := [ofFileMustExist];
 //  openDialog.Filter := ' all files|*.*';
 //  //
 // //
 //  ShowMessage('Select one of the reference files that this program will be interoating, now.');
 //  lStatus.Caption := 'SELECT ONE OF THE FILES TO INTEROGATE, NOW';
 //  Application.ProcessMessages;
 //  //
 //  if openDialog.Execute then
 //    begin
 //     FworkTSL := TStringList.Create;
 //     FworkTSL.Text := StringReplace(openDialog.FileName, '\', #13#10, [rfReplaceAll]);
 //     InptFNam := FworkTSL[FworkTSL.Count - 1];
 //     FworkTSL.free;
 //     // HERE, SET "PATH" TO BE EVERYTHING LEFT OF THE FILESPEC IN WHAT OUR USER JUST SELECTED
 //     Rpath := copy(openDialog.FileName, 1, (Length(openDialog.FileName) - (Length(InptFNam))));
 //    end
 //   else
 //    begin
 //     lStatus.Caption := 'User canceled run instead of selecting a Reference file.';
 //     log.Write(DtNow(Now) + 'User canceled run instead of selecting a Reference file.');
 //     Application.ProcessMessages;
 //    ShowMessage('Reference file not identified; Run Aborted !');
 //     Halt(0);
 //    end;
 // //
 //  log.Write(DtNow(Now) + 'User-selected location of REFERENCE files is:' + InptFNam);
 //  lStatus.Caption := 'Selected Reference file is:' + InptFNam;
 //  //
 //  //
  //RDIR := Rpath;
  //
  //RDIR := 'C:\Temp\';
  //
  //
  //
  //
  //
 //  ShowMessage('Select the folder where I should put OUTPUT, now.');
 //  lStatus.Caption := 'SELECT OUTPUT FOLDER';
 //  Application.ProcessMessages;
 //  //
 //  with TFileOpenDialog.Create(nil) do
 //  try
 //    Options := [fdoPickFolders];
 //    if Execute then
 //     begin
 //      Opath := (FileName);
 //     end
 //   else
 //    begin
 //     lStatus.Caption := 'User canceled run instead of selecting Output folder.';
 //     log.Write(DtNow(Now) + 'User canceled run instead of selecting Output folder.');
 //     Application.ProcessMessages;
 //     ShowMessage('Output folder not provided; Run Aborted !');
 //     Halt(0);
 //    end;
 //  finally
 //    Free;
 //  end;
 //  //ShowMessage(FileName);
 //  //ShowMessage(Opath);
 //  //
  //
  //
  //  THE BELOW BLOCK SHOWS HOW TO NAME OPEN AND ACCESS TXT FILES
  //
  //
  //     Var
  //    FINALO, TFile, SFile, TTFile, OFile, RFile: TextFile;
  //    workdir: AnsiString;
  //    tmpltnmI: AnsiString;
  //    tmpltnmO: AnsiString
  //    InptTnam: AnsiString;
  //    OutpTNam: AnsiString;
  //
  //
  //    //set filenames:
  //    tmpltnmI := Copy(STSL[0], 2, Lcellzero - 1);                         // capture the in-spreadsheet-row template name
  //    tmpltnmO := Copy(tmpltnmI, 1, Length(tmpltnmI) - 4) + '_OUTPUT_' + CurDt + Copy(tmpltnmI, Length(tmpltnmI) - 4 + 1, 4); // set OUTPUT file name for use with this template
  //    //
  //    // set the name of the template that needs to be opened - and open that input fle
  //    InptTNam := workdir + tmpltnmI;
  //    AssignFile(RFile, InptTNam);
  //    Reset(RFile);
  //    //
  //    // set output file name for the above Template and open this output (if file exists, open append)
  //    OutpTNam := workdir + tmpltnmO;
  //    AssignFile(OFile, OutpTNam);
  //    If FileExists(OutpTNam) Then
  //      Append(OFile)
  //    else
  //      ReWrite(OFile);
  //    //
  //:::
  //:::
  //    ReadLn(TFile, Trec);
  //   //
  //    WriteLn(OFile, Trec);
  //:::
  //:::
  //    CloseFile(TFile);
  //    CloseFile(OFile);
  //
  //
  //
  //
  //   AS A REMINDER, EACH ROW OF STRINGGRID1 HAS THESE COLUMNS:
  //    0) the error code that EDIT process developed (note: we could not be executing this script (RUN button) if ANY script row had errors... so these will all be zero)
  //    1) ROW number
  //    2) A value showing "line type" (such as Exec Parm or... Script Line, etc)
  //    3) COMMAND
  //    4) Remaining part of this script line (includes operands)
  //    5) Operand1 (if there was one in this script statement)
  //    6) Operand2 (if there was one in this script statement)
  //    7) Operand3 (if there was one in this script statement)
  //
  //
  //
  //   HERE, WE MUST SET BASIC JOB PARAMETERS SUCH AS PATHIN
  //   (here make an initial loop through the string grid looking for JOB-level items to set).
  //   We need to set items like this here: J_PATHIN, J_RPTFILENAME, J_PATHOUT1, J_FILTER
  //
  S_CAPITALIZEREFDATA := 'N';    // assume that we should use data from REF files exactly as it stands
  //
  J_TEXTFIELDREPORTMAXBYTES := 0;
  //
  for i := 0 to StringGrid1.RowCount-1 Do
   begin
     //
     if StringGrid1.Cells[3, i] = 'CAPITALIZEREFDATA:' then S_CAPITALIZEREFDATA := StringGrid1.Cells[4, i];
     //
     if StringGrid1.Cells[3, i] = 'PATHIN:' then
       begin
         J_PATHIN := StringGrid1.Cells[4, i];
         J_PATHINOPT := 'R';
         countofdots := 0;
         countofdots := OccurrecesOfChar(J_PATHIN, '.');
         if countofdots > 0 then J_PATHINOPT := 'L';    // did user supply a filename (their file contains list of REF files to use, if so)?  If so, indicate it is a List.
       end;
     //
     if StringGrid1.Cells[3, i] = 'FILTER:' then J_FILTER := StringGrid1.Cells[4, i];
     if StringGrid1.Cells[3, i] = 'RPTTITLE:' then J_RPTTITLE := StringGrid1.Cells[4, i];
     if StringGrid1.Cells[3, i] = 'RPTNOTE:' then J_RPTNOTE := StringGrid1.Cells[4, i];
     if StringGrid1.Cells[3, i] = 'RPTFILENAME:' then J_RPTFILENAME := StringGrid1.Cells[4, i];
     if StringGrid1.Cells[3, i] = 'OF1FILENAME:' then J_OF1FILENAME := StringGrid1.Cells[4, i];
     if StringGrid1.Cells[3, i] = 'OF2FILENAME:' then J_OF2FILENAME := StringGrid1.Cells[4, i];
     if StringGrid1.Cells[3, i] = 'OF3FILENAME:' then J_OF3FILENAME := StringGrid1.Cells[4, i];
     if StringGrid1.Cells[3, i] = 'DELIMRPT:' then J_DELIMRPT := StringGrid1.Cells[4, i];
     if StringGrid1.Cells[3, i] = 'DELIM1:' then J_DELIM1 := StringGrid1.Cells[4, i];
     if StringGrid1.Cells[3, i] = 'DELIM2:' then J_DELIM2 := StringGrid1.Cells[4, i];
     if StringGrid1.Cells[3, i] = 'DELIM3:' then J_DELIM3 := StringGrid1.Cells[4, i];
     if StringGrid1.Cells[3, i] = 'LIMITINFILES:' then J_LIMITINFILES := StringGrid1.Cells[4, i];
     if StringGrid1.Cells[3, i] = 'LIMITRPT:' then J_LIMITRPT := StringGrid1.Cells[4, i];
     if StringGrid1.Cells[3, i] = 'RPTWHENISAY:' then J_RPTWHENISAY := StringGrid1.Cells[4, i];
     if StringGrid1.Cells[3, i] = 'LOGFILENAME:' then J_LOGFILENAME := StringGrid1.Cells[4, i];
     if StringGrid1.Cells[3, i] = 'PATHOUT1:' then J_PATHOUT1 := StringGrid1.Cells[4, i];
     if StringGrid1.Cells[3, i] = 'PATHOUT2:' then J_PATHOUT2 := StringGrid1.Cells[4, i];
     if StringGrid1.Cells[3, i] = 'PATHOUT3:' then J_PATHOUT3 := StringGrid1.Cells[4, i];
     if StringGrid1.Cells[3, i] = 'TEXTFIELDREPORTMAXBYTES:' then J_TEXTFIELDREPORTMAXBYTES := StrToInt(Trim(StringGrid1.Cells[4, i]));
     if StringGrid1.Cells[3, i] = 'TROVE1:' then
       begin
         J_TROVE1CHK := StringGrid1.Cells[5, i];
         J_TROVE1RULE := StringGrid1.Cells[6, i];
         J_TROVE1MOV := StringGrid1.Cells[7, i];
         J_TROVE1 := TStringList.Create;
       end;
     if StringGrid1.Cells[3, i] = 'TROVE2:' then
       begin
         J_TROVE2CHK := StringGrid1.Cells[5, i];
         J_TROVE2RULE := StringGrid1.Cells[6, i];
         J_TROVE2MOV := StringGrid1.Cells[7, i];
         J_TROVE2 := TStringList.Create;
       end;
     if StringGrid1.Cells[3, i] = 'TROVE3:' then
       begin
         J_TROVE3CHK := StringGrid1.Cells[5, i];
         J_TROVE3RULE := StringGrid1.Cells[6, i];
         J_TROVE3MOV := StringGrid1.Cells[7, i];
         J_TROVE3 := TStringList.Create;
       end;

   end;
  //
  if J_PATHINOPT <> 'L' then
    begin
      if COPY(J_PATHIN, Length(J_PATHIN) - 1, 1) <> '\' then J_PATHIN := J_PATHIN + '\';
    end;
  if COPY(J_PATHIN, Length(J_PATHIN) - 1, 1) <> '\' then J_PATHIN := J_PATHIN + '\';
  if COPY(J_PATHOUT1, Length(J_PATHOUT1) - 1, 1) <> '\' then J_PATHOUT1 := J_PATHOUT1 + '\';
  if COPY(J_PATHOUT2, Length(J_PATHOUT2) - 1, 1) <> '\' then J_PATHOUT2 := J_PATHOUT2 + '\';
  if COPY(J_PATHOUT3, Length(J_PATHOUT3) - 1, 1) <> '\' then J_PATHOUT3 := J_PATHOUT3 + '\';
  //
  //RDIR := J_PATHIN;
  //if RDIR = '' then RDIR := 'C:\Temp\';      //  gary temp code
  //
  //   GET ANY NEEDED DATA VIA SCREEN BACK-AND-FORTH    (if we really need to....)
  //
  //   MAKE LIST OF ALL QUALIFIED REF FILES: REFFILELIST    // see checked answer: https://stackoverflow.com/questions/11489680/list-all-files-from-a-directory-in-a-string-grid-with-delphi
  //
  REFFILESSL := TStringList.Create;
  GetRFiles(J_PATHIN, REFFILESSL, GRFresult);                                      // set the list of REF filenames we will process
  //
  //  OPEN THE OUTPUT FILE
  // gary - instead of actually working with a "file", change this to add any report line info to a stringlist... and at end of job, put that to an output report file
  //
 // if J_RPTFILENAME <> '' then
 //   begin
 //     tmpltnmO := J_RPTFILENAME;
 //     OutpTNam := J_PATHOUT1 + tmpltnmO;
 //     AssignFile(OFile, OutpTNam);
 //    try
 //     If FileExists(OutpTNam) Then
 //      Append(OFile)
 //     else
 //      ReWrite(OFile);
 //    except
 //     ShowMessage('Specified output location is invalid: ' + J_PATHOUT1 + tmpltnmO + '.  Job stopped now.');
 //     Halt(0);
 //    end;
 //
 //   end;
 //
 //
//  tmpltnmO := 'GARYOUT.TXT';                                           // set OUTPUT file name for use with this template
//  OutpTNam := J_PATHOUT1 + tmpltnmO;
//  AssignFile(OFile, OutpTNam);
//  try
//    If FileExists(OutpTNam) Then
//     Append(OFile)
//    else
//     ReWrite(OFile);
//  except
//    ShowMessage('Specified output location is invalid: ' + J_PATHOUT1 + tmpltnmO + '.  Job stopped now.');
//    Halt(0);
//  end;
  //WriteLn(OFile, 'test 2');
  //CloseFile(OFile);
  //ShowMessage('file is updated, now');
  //
  //
  J_REPORTLINE := TStringList.Create;
  if J_RPTTITLE <> '' then J_REPORTLINE.Add(J_RPTTITLE);
  if J_RPTNOTE <> '' then J_REPORTLINE.Add(J_RPTNOTE);
  //
  //
REFTOP:
  //
  //  IF NO MORE REF FILES TO PROCESS, BRANCH
  //
  if REFFILESSL.Count < 1 then goto REFFILESDONE;
  //
  //  SET NEXT REF FILENAME SO WE CAN BEGIN WORKING WITH THAT FILE
  //
  //
  // garygarygary - most of the pathinopt changes are below this point:
  //
  //
  //CURRREFFILE := REFFILESSL[0];                                        // set this field to FIRST filenmame that is on the list
  S_REFFILENAME := REFFILESSL[0];                                        // set this field to FIRST filenmame that is on the list
  //
  // garygarygary note: the mod for J_PATHINOPT called for us to error out at script-edit time if user specified a FILTER and also we
  //  are using J_PATHINOPT = L...  but for now, I'm just leaving it where the J_PATHINOPT = L processing will simply IGNORE user-specified
  //   FILTER (whenever J_PATHINOPT is L)
  //
  if J_PATHINOPT = 'L' then                                              // for J_PATHINOPT = L  (where user has provided fully qualifed list of REF files)
    begin                                                                //  entire data from the PATHIN filelist was put into REFFILESSL... so,
      J_PATHIN := ExtactFilePath(REFFILESSL[0]);                         //   we now need to split the  filename away from the path name
      S_REFFILENAME := ExtractFileName(REFFILESSL[0]);
    end;
  //
  //
  //  GET ANY NEEDED DATA FROM THE FILENAME
  //
  S_REFFILEEXTENSION := ExtractFileExt(S_REFFILENAME);                     // set file extension
  //RFEXT := ExtractFileExt(S_REFFILENAME);                                // set file extension for this REF file
  RFSTEMLENGTH := Length(S_REFFILENAME) - Length(S_REFFILEEXTENSION);      // calc length of file stem for this REF file
  //RFSTEM := Copy(S_REFFILENAME, 1, RFSTEMLENGTH);                        // set the value of the stem
  S_REFFILESTEM := Copy(S_REFFILENAME, 1, RFSTEMLENGTH);                   // set stem value
  //
  //  GET DATA FROM FILE ATTRIBUTES
  //
  //RFSIZE := FileSizestr(RDIR+CURRREFFILE);
  //RFSIZE := FileSizestr(J_PATHIN+S_REFFILENAME);
  S_FILESIZE := FileSizestr(J_PATHIN+S_REFFILENAME);
  //
  //FileAge(RDIR + CURRREFFILE, FileDateI);                              // set FileDateI as the last modified date for this REF file
  FileAge(J_PATHIN + S_REFFILENAME, FileDateI);                          // set FileDateI as the last modified date for this REF file
  //RFLMODDT := SysUtils.DateTimeToStr(FileDateI);                       // get a displayable version of last modified date
  S_LASTMODDT := SysUtils.DateTimeToStr(FileDateI);                       // get a displayable version of last modified date
  //
  //
  ATTR := FileGetAttr(J_PATHIN + S_REFFILENAME);
  if ATTR and faReadOnly > 0 then S_ATTRREADONLY := 'Y' else S_ATTRREADONLY := 'N';
  //
  //
  //
  //  set proper internal fiels to zero now that we have moved to another REF file
  S_STATEFOUNDPOSITION := 0;                   // if FOUND IN RECORD is true, this is the POSITION that it was found at
  S_STATEFOUNDRECPOINTER := 0;                 // if FOUND is True, this is rec num of the recd where the Found was noted
  S_RECPOINTER := 0;                           // the NUMBER of the record that current has focus (within curr Ref file)
  //
  S_RECPOINTERFIF01 := 0;
  S_RECPOSITIONFIF01 := 0;
  S_STATEFOUNDFIF01 := 'N'
  S_SPERRFIF01 := 1;
  //
  S_PCKD0 := 0;
  S_PCKD1 := 0;
  S_PCKD2 := 0;
  S_PCKD3 := 0;
  S_PCKD4 := 0;
  S_PCKD5 := 0;
  S_PCKD6 := 0;
  S_PCKD7 := 0;
  S_PCKD8 := 0;
  S_PCKD9 := 0;
  //
  //      set these to null now that we are starting with a new REF file
  S_TEXT0 := '';
  S_TEXT1 := '';
  S_TEXT2 := '';
  S_TEXT3 := '';
  S_TEXT4 := '';
  S_TEXT5 := '';
  S_TEXT6 := '';
  S_TEXT7 := '';
  S_TEXT8 := '';
  S_TEXT9 := '';
  //
  //
  //
  //
  // gary - here, update the caption so user has progress info
  lStatus.Caption := IntToStr(REFFILESSL.Count) + ' files to go; working on:' + S_REFFILENAME + '; ';
 //     log.Write(DtNow(Now) + 'User canceled run instead of selecting Output folder.');
  Application.ProcessMessages;
  //
  //
  //
  //
  //
  //  HERE, DO ALL SCRIPT PROCESSING TO THIS REF FILE, BEFORE MOVING ON TO THE NEXT REF FILE
  //
  S_LINETRACKER := TStringList.Create;
  //
  //
  S_SPERR := 0;
  APPLYSCRIPT(S_REFFILENAME);                                           //  Apply script commands to current REF file
  //
  // gary - might be good to provide an easy way to call a DLL
  // gary  - might want to provide a GOTO which could force the job to halt after the current REF file examination is complete
  //
  //  DO TROVE ACCUMULATION AT THIS POINT
  //
  if J_TROVE1RULE <> '' then
    begin
      trovedata := '';
      gettrovedata(J_TROVE1CHK, J_TROVE1RULE, J_TROVE1MOV, trovedata, troverc);   //  set TROVEDATA to be whatever we are to add into this trove
      //if (trovedata <> '') and (troverc = 0) then J_TROVE1.Add(trovedata);
      if troverc = 0 then J_TROVE1.Add(trovedata);
    end;
  //
  if J_TROVE2RULE <> '' then
    begin
      trovedata := '';
      gettrovedata(J_TROVE2CHK, J_TROVE2RULE, J_TROVE2MOV, trovedata, troverc);   //  set TROVEDATA to be whatever we are to add into this trove
      //if (trovedata <> '') and (troverc = 0) then J_TROVE2.Add(trovedata);
      if troverc = 0 then J_TROVE2.Add(trovedata);
    end;
  //
  if J_TROVE3RULE <> '' then
    begin
      trovedata := '';
      gettrovedata(J_TROVE3CHK, J_TROVE3RULE, J_TROVE3MOV, trovedata, troverc);   //  set TROVEDATA to be whatever we are to add into this trove
      //if (trovedata <> '') and (troverc = 0) then J_TROVE3.Add(trovedata);
      if troverc = 0 then J_TROVE3.Add(trovedata);
    end;
  //
TROVEACCUMDONE:
  if (J_RPTWHENISAY = 'Y') or (J_RPTWHENISAY = '-') then goto NOPOSTPROCESSAUTOREPORT;
  //
  // At this point, check REPORTWHENISAY and if it allows, then create a post-file-processing "report" record (now that examination of this REF file is complete).
  // The output row will include these things:
  //  a) statement flow info (series of stmt numbers along with the return code that the execution of that stmt produced (S_SPERR))
  //  b) a capture of the up-to-J_TEXTFIELDREPORTMAXBYTES for EACH non-null %TEXT field (this is not included if NO %TEXT fields were used at all)
  //  c) a capture of text version of the field content for all %Pckd fields (this is not included if NO %Pckd fields were used at all)
  //  d) the name of the LABEL that was most recently engaged (
while script lines were being processed)
  //  e) full content of the LAST script statement processed as this REF file was being examined/handled
  //  f) full content of the NEXT TO LAST script statement processed as this REF file was being examined/handled
  //  g) a copy of CURRENT value of all the "STATE" switches
  //  h) date and time of this report record's creation
  //  i) full path and filename of the REF file that was considered/examined by the script
  //
  // fulfillment notes for the above requierments are here:
  // for 'a' - these values are recorded in S_LINETRACKER as script is being processed, so just make it a report record segment, here:
  S_ReportRecord := '';
  //
  S_LINETRACKER.Delimiter := '~';
  S_ReportLT := 'LINETRACKER:' + S_LINETRACKER.DelimitedText;
  //
  S_ReportTF := 'TEXTFIELDS:';
  if S_TEXT0 <> '' then S_ReportTF := S_ReportTF + '%TEXT0=' + S_TEXT0;
  if S_TEXT1 <> '' then S_ReportTF := S_ReportTF + '~' + '%TEXT1=' + S_TEXT1;
  if S_TEXT2 <> '' then S_ReportTF := S_ReportTF + '~' + '%TEXT2=' + S_TEXT2;
  if S_TEXT3 <> '' then S_ReportTF := S_ReportTF + '~' + '%TEXT3=' + S_TEXT3;
  if S_TEXT4 <> '' then S_ReportTF := S_ReportTF + '~' + '%TEXT4=' + S_TEXT4;
  if S_TEXT5 <> '' then S_ReportTF := S_ReportTF + '~' + '%TEXT5=' + S_TEXT5;
  if S_TEXT6 <> '' then S_ReportTF := S_ReportTF + '~' + '%TEXT6=' + S_TEXT6;
  if S_TEXT7 <> '' then S_ReportTF := S_ReportTF + '~' + '%TEXT7=' + S_TEXT7;
  if S_TEXT8 <> '' then S_ReportTF := S_ReportTF + '~' + '%TEXT8=' + S_TEXT8;
  if S_TEXT9 <> '' then S_ReportTF := S_ReportTF + '~' + '%TEXT9=' + S_TEXT9;
  //
  //fieldtype := FieldDefs.Find(S_PCKD0).DataType;
  //
  S_ReportMRL := 'LASTLABEL:'+S_ReportMRL;
  //
  S_ReportNTLSSP := 'NEXTtoLASTstatement:' + S_ReportNTLSSP;
  S_ReportLSSP := 'LastStatement:' + S_ReportLSSP;
  //
  S_ReportStates := 'STATES:StateEqual=' + S_STATEEQUAL;
  S_ReportStates := S_ReportStates + '~' + 'StateLessThan=' + S_STATELESSTHAN;
  S_ReportStates := S_ReportStates + '~' + 'StateLessThanOrEqual=' + S_STATELESSTHANOREQUAL;
  S_ReportStates := S_ReportStates + '~' + 'StateGreaterThan=' + S_STATEGREATERTHAN;
  S_ReportStates := S_ReportStates + '~' + 'StateGreaterThanOrEqual=' + S_STATEGREATERTHANOREQUAL;
  S_ReportStates := S_ReportStates + '~' + 'StateFound=' + S_STATEFOUND;
  //
  S_ReportRecord := S_ReportLT + J_DELIMRPT + S_ReportTF + J_DELIMRPT + S_ReportMRL + J_DELIMRPT + S_ReportLSSP + J_DELIMRPT;
  S_ReportRecord := S_ReportRecord + S_ReportNTLSSP + J_DELIMRPT + S_ReportStates + J_DELIMRPT + 'REF FILE:' + J_PATHIN + S_REFFILENAME;
  //
  J_REPORTLINE.Add(S_ReportRecord);  // add an output row to output report now
  //
  //
NOPOSTPROCESSAUTOREPORT:
  //
  //
  if S_SPERR < 7 then
   begin
    GOTO KEEPON1;
   end;
     //                                                                // here - we have encountered a severe script error - need to shut down entire job
  GOTO SCRIPTSEVERE;
  //
KEEPON1:
  if S_SPERR < 1 then GOTO KEEPONX;
  //                                                                   // here, we handle script errs that arent severe enough to call for immediate shutdown
KEEPONX:
  //
  // REMOVE TOP ENTRY FROM REFFILELIST:       (to destroy only the first item in a stringlist, making the second one now be the first:
  try
    REFFILESSL.Delete(0);                               //remove the in-focus file from the list so we can move on to the next REF file
  except
    ShowMessage('Job failed when removing item from REF files list.');
  end;
  //
  S_LINETRACKER.Free;
  //
  goto REFTOP;
  //
  //
REFFILESDONE:
  lStatus.Caption := 'REF files done!';
  Application.ProcessMessages;
  //
  //
  // HAVE FINISHED LOOKING AT ALL THE REF FILES - SO, NOW HANDLE ANY POST PROCESSING THAT IS NEEDED
  //
  // SUMMARIZE AS NEEDED
  //
  //
  J_REPORTLINE.SaveToFile(J_PATHOUT1 + J_RPTFILENAME + '.TXT');
  J_REPORTLINE.Free;
  //
  if Assigned(J_TROVE1) then
    begin
    J_TROVE1.SaveToFile(J_PATHOUT1 + 'TROVE1' + '.TXT');
    J_TROVE1.Free;
    end;
  //
  if Assigned(J_TROVE2) then
    begin
    J_TROVE2.SaveToFile(J_PATHOUT1 + 'TROVE2' + '.TXT');
    J_TROVE2.Free;
    end;
  //
  if Assigned(J_TROVE3) then
    begin
    J_TROVE3.SaveToFile(J_PATHOUT1 + 'TROVE3' + '.TXT');
    J_TROVE3.Free;
    end;
  //
  //
  //
  //
  //
  //
  //  THIS INFO IS TO DOC HOW THE PROCESS WILL WORK:
  //
  //   OPEN EXTRACT FILE
  //    //set filenames:
  //    tmpltnmI := Copy(STSL[0], 2, Lcellzero - 1);                         // capture the in-spreadsheet-row template name
  //
  // REFTOP:
  //
  //   IF REFFILELIST HAS NO ENTRIES IN IT, GO TO REFFILESDONE:  // if MyStringList.Count = 0 then goto REFFILESDONE
  //
  //   SET S_REFFILENAME TO FIRST FILENAME IN REFFILELIST
  //
  //   PERFORM REFFILENAMEDISECTION
  //                            // get file extension and filename_sans_extension: https://docwiki.embarcadero.com/Libraries/Sydney/en/System.SysUtils.ExtractFileName
  //                            // if requested, disect the filename_sans_extension based on a filename_node_separator, and set any user sought data fields based on result
  //
  //   PERFORM REFFILEATTRIBS   // to get attribs like READONLY, etc: http://www.delphibasics.co.uk/RTL.php?Name=filegetattr
  //                            // to get last modified date: http://www.delphibasics.co.uk/RTL.php?Name=FileAge
  //                            // to get filesize: see checked solution at: https://stackoverflow.com/questions/6066896/why-do-i-get-an-invalid-handle-error-using-getfilesizeex-with-files-marked-r
  //
  //   IF REFCONTENTNEEDED, PERFORM REFINSIDE                       (can construct this later)
  //
  //   IF CUSTOMEXTRACTISNEEDED PERFORM BUILDCUSTOMEXTRACT           (can construct this later - just do BUILDEXTRACT for now)
  //    ELSE PEFORM BUILDEXTRACT
  //
  //   WRITE EXTRACT
  //
  //   REMOVE TOP ENTRY FROM REFFILELIST      (to destroy only the first item in a stringlist, making the second one now be the first:
  //                                         try
  //                                            MyStringList.Delete(0);
  //                                         finally
  //                                            ShowMessage('All done removing the REF list entry.');
  //                                         end;
  //
  //   GO TO REFTOP:
  //
  // REFFILESDONE:
  //
  //
  //
  line := spac10;
  RECMX := spac10;
  RECM2 := spac10;
  RECM1 := spac10;
  REC0 := spac10;
  RECPLUS1 := spac10;
  RECPLUS2 := spac10;
  sep := '======';
  Triggered := 'N';

  qualified := 0;

  if FindFirst(Rpath + '*.txt', faAnyFile, SR) = 0 then
  begin
    repeat
      if (SR.Attr <> faDirectory) then
      begin
        AssignFile(tempFile, Rpath + SR.Name);
        Reset(tempFile);
        while not Eof(tempFile) do
        begin
          Readln(tempFile, line);
          //
          if Triggered = 'Y' then
            begin

              if RECPLUS1 = spac10 then
                 begin
                   RECPLUS1 := line;
                   GOTO NEXT;
                 end;

              RECPLUS2 := line;


             // Canvass := ListBox1.Canvas;
             // Canvass.Brush.Color := TColor(ListBox1.Items[Index]);
             // Canvass.FillRect(Rect);
             // S := ListBox.Items[Index];




              // write the whole enchilada output record at this point   (this is a CSV record, but is delimited by PIPE)

              // To the listbox, add RECM2, RECM1, REC0, RECPLUS1, RECPLUS2 (add them in standout font or backgrnd color)
              self.Font.Color := clBlue;
              //ListBox1.Canvas.TextOut( Rect.Left, Rect.Top, ListBox1.Items[Index] );
              ListBox1.Canvas.Font.Color := clGreen;
              self.ListBox1.Font.Style := [fsBold];








              //Form1.Font.Color := clRed;     // this changed message at bottom of form to be red
              self.ListBox1.Canvas.Font.Color := clRed;



              self.ListBox1.Canvas.Pen.Color := clWhite;


              //Form1.Font.Name := 'Times New Roman';   //This changed the Status message at bottom to be T N R
              //Form1.ListBox1.Font.Name := 'Times New Roman';    // This changed ALL rows in listbox to be T N R
              ListBox1.Items.Add(sep);
              ListBox1.Items.Add(RECM2);


              Canvass := ListBox1.Canvas;
              Canvass.Brush.Color := TColor(ListBox1.Items[Index]);

              ListBox1.Canvas.Brush.Color := clGreen;

              //Canvass.FillRect(Rect);
              //S := ListBox.Items[Index];





              ListBox1.Items.Add(RECM1);
              ListBox1.Items.Add(REC0);
              ListBox1.Items.Add(RECPLUS1);
              ListBox1.Items.Add(RECPLUS2);
              ListBox1.Items.Add(spac10);
              ListBox1.Font.Color := clBlack;
              self.ListBox1.Font.Style := [];
              Application.ProcessMessages;
              //
              RECPLUS1 := spac10;
              RECPLUS2 := spac10;
              RECM2 := '';
              RECM1 := '';
              REC0 := '';
              //
              Triggered := 'N';
              //
              GOTO NEXT;
              //
            end;
          RECMX := RECM2;
          RECM2 := RECM1;
          RECM1 := REC0;
          REC0 := line;
          Triggered := 'N';
          ///
          ///    have not coded up the ChkTrig routine yet - so, these lines are just to have something we could set TRIGGERED sw with
          ///
          //P := Pos('00577976S20220412_0000000003W                   AI            18P', line);               // TEMP CODE
          //if P > 0 then Triggered := 'Y';    // TEMP CODE
          //P := Pos('00577976F20220412_0000000011X                   AI            18P', line);
          //if P > 0 then Triggered := 'Y';
          Q := Pos('C1301', line);
          if Q = 1 then Triggered := 'Y';            // find any record with C1301 in col 1 ... if find it, then mark this as one we want

          if Triggered = 'Y' then
           begin
            qualified := qualified + 1;
            if qualified > 39103 then
             begin
              log.Write(DtNow(Now) + copy(line, 1, 25));  // write it to log for now
              Application.ProcessMessages;
             end;
           end;

          ///
          ///
          //ChkTrig for REC0 now //(see if 'line' has proper stuff to cause a data catpure now... if so, set Triggered to Y)
          ///
          ///
          if RECMX <> '' then
            begin
              ListBox1.Items.Add(RECMX);
              Application.ProcessMessages;
            end;
          //
        NEXT:
          //
        end;
        lStatus.Caption := 'Reached end of file:' + InptFNam;
        //   when each of the read files runs out of records, we do the following:
          if Triggered = 'Y' then
            begin
              //
              log.Write(DtNow(Now) + copy(line, 1, 25));
              // write the whole enchilada output record at this point   (this is a CSV record, but is delimited by PIPE)
              //
              // To the listbox, add RECM2, RECM1, REC0, RECPLUS1, RECPLUS2 (add them in standout font or backgrnd color)
              ListBox1.Items.Add(sep);
              ListBox1.Items.Add(RECM2);
              ListBox1.Items.Add(RECM1);
              ListBox1.Items.Add(REC0);
              ListBox1.Items.Add(RECPLUS1);
              ListBox1.Items.Add(RECPLUS2);
            end
          else
            begin
              ListBox1.Items.Add(RECM2);
              ListBox1.Items.Add(RECM1);
              ListBox1.Items.Add(REC0);
            end;
        //
      end;
      //
    until FindNext(SR) <> 0;
    // once we get to this spot, it means that we've finished looking at ALL of the files that we were to consider
    FindClose(SR);
  end;
  //  here, we should LOG the overall results
NOGO:
    //ShowMessage('Arrived at NOGO label.');
    //Button1.Enabled := True;         // electing to leave button enabled and leave script showing on screen (so user can see what stuff to fix)
    GOTO GO;
    //
SCRIPTSEVERE:
    ShowMessage('Arrived at SCRIPTSEVERE label.');
    //
    GOTO GO;
    //
GO:
 End;




procedure Tppreconform.FormCreate(Sender: TObject);
var
 //CurDt: String;    del
  result: Integer;
  //delayseconds: Integer;
  i: Integer;
  //ExecParm: AnsiString;
  //
begin
  FCount := 10;
  Randomize;
  //
  CancelAUTORUN.Enabled := False;            // assume that auto-run is not enabled
  AutoContinue := 'N';                       // assume that auto-run is not enabled
  //
  StringGrid1.DefaultDrawing := True;
  //
  //StringGrid1.DefaultDrawing := False;
  //
  //
  //
  //Ppath := ExtractFilePath(ParamStr(0));              // pick up the location where we are running from
  //
  delayseconds := 0;                                  // assume that our auto-run delay amount will be zero seconds
  AITOUSE := '';                                      // no DEFAULT application ini will be in use... so, user must supply it (via exec parameter)
  //
  //
 // here, determine which Application INI to run with - by looking at run parameters
 //
 //
 // here, set number of DELAY seconds (based on exec parm) - and this will num secnds will give user chance to halt/modify setup when job starts
 //
  EXECPARM := '';
  ParmData := TStringList.Create;         // use this to split an execu parameter into segment-before-equal-sign and segment after
  for i := 0 to ParamCount do
   begin
    //ShowMessage('Parameter '+IntToStr(i)+' = '+ParamStr(i));
    if i = 0 then PPTH := ParamStr(i);
    if i <> 0 then
     begin
      //
      EXECPARM := EXECPARM + ParamStr(i) + ' ';
      //
      Split(ParamStr(i), '=', ParmData) ;  //split an execu parameter into segment-before-equal-sign and segment after
      //
      result := AnsiCompareText('/runafterdelay', ParmData[0]);   // Case INsensitive string compare
      if result = 0 then
       begin
        delayseconds := strtoint(ParmData[1]);   // Set DelaySeconds based on the provided execution parm
        CancelAUTORUN.Enabled := True;
        AutoContinue := 'Y';
       end;
      //
      result := AnsiCompareText('/applini', ParmData[0]);   // Case INsensitive string compare
      if result = 0 then AITOUSE := ParmData[1];            // Set location to get Application INI file from
     end;
   end;
  //
  if FileExists(AITOUSE) then
     begin
     end
   else
     begin
      ShowMessage('JOB FAILED. Application INI is required, but provided location not valid or not accessable: ' + AITOUSE);
      close;
      Halt(0);
     end;
  //
   TimeOut := IncSecond(Now, delayseconds);
   Timer1.Enabled := True;
   Label1.Caption := SecsToHmsStr(SecondsBetween(Now, TimeOut));
   //
   //Showmessage('made it here');
  //
  //
end;






procedure Tppreconform.FormDestroy(Sender: TObject);
begin
    log.Free;
end;






Procedure Tppreconform.FormShow(Sender: tObject);
Begin
  Button1.Enabled := True;
 //
End;




procedure Tppreconform.OnActivate(Sender: TObject);
//var
//S: AnsiString; del
//i: Integer; del
//NativeI: NativeInt; del
//NativeS: String;  del
//testdata: String;

begin
 DateTimeToString(J_RUNDATETIME, 'yyyymmddhhnnsszz', Now);
 S_RUNDATETIME := (DtNow(Now) + '');
 S_RUNDATE := (DtNow(Now) + '');
 S_RUNTIME := (DtNow(Now) + '');
 //
 DoWaitx(J_RUNDATETIME);
 //
 FillGrid(EXECPARM, PPTH, AITOUSE, StringGrid1, script);
 //
 if (AutoContinue = 'Y') then
   begin
      CancelAUTORUN.Enabled := False;            // turn this off now that it has done it's job
      AutoContinue := 'N';                       // turn this off now that it has done it's job
      Button1Click(Self.Button1);                // CLICK THE RUN BUTTON AUTOMATICALLY
   end;
 //
 //StringGrid1.Font.Color := clGreen;
 //StringGrid1.Tag := 22;
 // for i := 0 to StringGrid1.RowCount-5 Do     // GARY MINUS 5?
 //   begin
 //       //NativeS := IntToStr(StatementErrorCodes[i]);
 //       //NativeI := NativeInt(StatementErrorCodes[i]);
 //       //StringGrid1.Tag := NativeInt(StatementErrorCodes[i]);
 //       if StrToInt(StatementError[i]) <> 0 then showmessage('row ' + IntToStr(i) + ' has error per OnActivate');
 //       StringGrid1.Tag := NativeInt(StrToInt(StatementError[i]));
 //       //StringGrid1.InvalidateRow(i);
 //       StringGrid1.Invalidate;
 //       //TStringGridAccess(StringGrid1).InvalidateRow(i);
 //       //testdata := StringGrid1[1];
 //       //if StringGrid1.Tag <> 0 then ShowMessage('tag is nonzero:'+S);
 //       //StringGrid1.Tag := StatementErrorCodes[i];
 //       //
 //       //
 //       //
 //       //
 //       //S := StringGrid1.Cells[1, i];
 //       //if StringGrid1.Tag <> 0 then ShowMessage('tag is nonzero:'+S);
 //       //
 //  //      // gary, the below line did NOT cause a refresh on the stringgrid...
 //       //StringGrid1.Cells[1, i] := S;
 //       //
 //       //
 //  //StringGrid1.Canvas.Font.Color := FG[ACol, ARow];
 //  //StringGrid1.TextOut(Rect.Left + 2, Rect.Top + 2, S);
 //  end;


 //FillGrid(StringGrid1, ExecParm, ppth, aitouse, script);
 //
 //StringGrid1.DefaultDrawing := False;
 //
end;




//procedure Tppreconform.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;  Rect: TRect; State: TGridDrawState; ErrColl: Integer);
procedure Tppreconform.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
 Rect: TRect; State: TGridDrawState);

var
mycolor: Tcolor;
targetrow: Integer;
targetcollumn: Integer;
RectForText: TRect;
S: String;
RC: String;

begin
  //targetrow := 2;
  //targetcollumn := 3;
  targetrow := 0;
  targetcollumn := 0;
  //if (myBooleanState) and (ACol = 3) and (ARow = 2) then
  mycolor := clWebKhaki;
  S := StringGrid1.Cells[ACol, ARow];
  RC := StringGrid1.Cells[0, ARow];
  //if StringGrid1.Font.Color = clGreen then
  //begin
  // targetrow := 9;
  //end;
  //
  //showmessage('about to check Tag value within SGDC');
  //if (StringGrid1.Tag <> 0) then showmessage('row ' + IntToStr(ARow) + ' has error per SGDC');
  //
  //if (StringGrid1.Tag = ARow) and (ARow <> 0) then
  if (ACol > 2) and (RC <> '0') then
   begin
    targetrow := ARow;
   end;
  //if (ACol = targetcollumn) and (ARow = targetrow) then
  if (ARow = targetrow) and (Length(StringGrid1.Cells[1, ARow]) <> 0) then
   begin
    mycolor := clred;
    if ARow = 0 then mycolor := clMoneyGreen;
   end;
  //if StringGrid1.Tag = ARow then targetrow := ARow;

  //if (ErrColl > 0) then
  // begin
  //  mycolor := clblue;
  // end;
  //if (ARow > 27) then
  // begin
  //  mycolor := clgreen;
  // end;

  //if (ACol = 3) and (ARow = 2) then
 // if (ARow = 2) then
  if (ACol >= 0) then
    with TStringGrid(Sender) do
   begin
      //paint the background red
      Canvas.Brush.Color := mycolor;
      Canvas.FillRect(Rect);
    //
 //     Canvas.Font.Color := clAqua;
      RectForText := Rect;
    // Make the rectangle where the text will be displayed a bit smaller than the cell
    // so the text is not "glued" to the grid lines
      InflateRect(RectForText, -2, -2);
    // Edit: using TextRect instead of TextOut to prevent overflowing of text
      Canvas.TextRect(RectForText, S);
    //
      //FG[ACol, ARow] := clAqua;
   //Canvas.Font.Color := clAqua;
      //Canvas.Font.Color := clOrange;
      //if StringGrid1.Font.Color = clGreen then targetrow := 9;Canvas.Font.Color := clWhite;
   //Canvas.TextOut(Rect.Left+2,Rect.Top+2,Cells[ACol, ARow]);




   end;
  //
  //if Canvas.Brush.Color <> clRed then
   // begin
    //  //paint the background blue
     // Canvas.Brush.Color := clblue;
      //Canvas.FillRect(Rect);
      //Canvas.TextOut(Rect.Left+2,Rect.Top+2,Cells[ACol, ARow]);
    //end;
 //StringGrid1.Invalidate;
end;

//procedure Tppreconform.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
//  Rect: TRect; State: TGridDrawState);
//begin
  //Canvas.font.Color := TAlphaColorRec.Green;
  //Canvas.FillText(Bounds, (Value.AsString),
  //  false, 100, [], TTextAlign.taLeading, TTextAlign.taCenter);
//  Rect := Bounds;
//  Rect.Left := Rect.Left + 2;
//  Canvas.Font.Style := [TFontStyle.fsBold];
//  Canvas.Fill.Color := TAlphaColorRec.Black;
//  Canvas.FillText(Rect, (Value.AsString), false, 100, [], TTextAlign.taLeading, TTextAlign.taCenter);

//end;

procedure Tppreconform.Timer1Timer(Sender: TObject);
begin
  Label1.Caption := SecsToHmsStr(SecondsBetween(Now, TimeOut));
  if Now > Timeout then Timer1.Enabled := False;
end;

End.
