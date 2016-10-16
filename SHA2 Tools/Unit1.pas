unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Hash, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    FileOpenDialog1: TFileOpenDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    MemoFile: TMemo;
    Button1: TButton;
    MemoStr: TMemo;
    EditStr: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure EditStrChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

const Enter = #13#10;

Var
  Lokasix : WideString;

/// STRING =========================================================================================================
function GetStrHashMD5(Str: String): String;
var
  HashMD5: THashMD5;
begin
    HashMD5 := THashMD5.Create;
    HashMD5.GetHashString(Str);
    result := HashMD5.GetHashString(Str);
end;

function GetStrHashSHA1(Str: String): String;
var
  HashSHA: THashSHA1;
begin
    HashSHA := THashSHA1.Create;
    HashSHA.GetHashString(Str);
    result := HashSHA.GetHashString(Str);
end;

function GetStrHashSHA224(Str: String): String;
var
  HashSHA: THashSHA2;
begin
    HashSHA := THashSHA2.Create;
    HashSHA.GetHashString(Str);
    result := HashSHA.GetHashString(Str,SHA224);
end;

function GetStrHashSHA256(Str: String): String;
var
  HashSHA: THashSHA2;
begin
    HashSHA := THashSHA2.Create;
    HashSHA.GetHashString(Str);
    result := HashSHA.GetHashString(Str,SHA256);
end;

function GetStrHashSHA384(Str: String): String;
var
  HashSHA: THashSHA2;
begin
    HashSHA := THashSHA2.Create;
    HashSHA.GetHashString(Str);
    result := HashSHA.GetHashString(Str,SHA384);
end;

function GetStrHashSHA512(Str: String): String;
var
  HashSHA: THashSHA2;
begin
    HashSHA := THashSHA2.Create;
    HashSHA.GetHashString(Str);
    Result := HashSHA.GetHashString(Str,SHA512);
end;

function GetStrHashSHA512_224(Str: String): String;
var
  HashSHA: THashSHA2;
begin
    HashSHA := THashSHA2.Create;
    HashSHA.GetHashString(Str);
    Result := HashSHA.GetHashString(Str,SHA512_224);
end;

function GetStrHashSHA512_256(Str: String): String;
var
  HashSHA: THashSHA2;
begin
    HashSHA := THashSHA2.Create;
    HashSHA.GetHashString(Str);
    Result := HashSHA.GetHashString(Str,SHA512_256);
end;

function GetStrHashBobJenkins(Str: String): String;
var
  Hash: THashBobJenkins;
begin
    Hash := THashBobJenkins.Create;
    Hash.GetHashString(Str);
    Result := Hash.GetHashString(Str);
end;

/// FILE =========================================================================================================

function GetFileHashMD5(FileName: WideString): String;
var
  HashMD5: THashMD5;
  Stream: TStream;
  Readed: Integer;
  Buffer: PByte;
  BufLen: Integer;
begin
  HashMD5 := THashMD5.Create;
  BufLen := 16 * 1024;
  Buffer := AllocMem(BufLen);
  try
    Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    try
      while Stream.Position < Stream.Size do
      begin
        Readed := Stream.Read(Buffer^, BufLen);
        if Readed > 0 then
        begin
          HashMD5.update(Buffer^, Readed);
        end;
      end;
    finally
      Stream.Free;
    end;
  finally
    FreeMem(Buffer)
  end;
  result := HashMD5.HashAsString;
end;

function GetFileHashSHA1(FileName: WideString): String;
var
  HashSHA: THashSHA1;
  Stream: TStream;
  Readed: Integer;
  Buffer: PByte;
  BufLen: Integer;
begin
  HashSHA := THashSHA1.Create;
  BufLen := 16 * 1024;
  Buffer := AllocMem(BufLen);
  try
    Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    try
      while Stream.Position < Stream.Size do
      begin
        Readed := Stream.Read(Buffer^, BufLen);
        if Readed > 0 then
        begin
          HashSHA.update(Buffer^, Readed);
        end;
      end;
    finally
      Stream.Free;
    end;
  finally
    FreeMem(Buffer)
  end;
  result := HashSHA.HashAsString;
end;


function GetFileHashSHA224(FileName: WideString): String;
var
  HashSHA: THashSHA2;
  Stream: TStream;
  Readed: Integer;
  Buffer: PByte;
  BufLen: Integer;
begin
  HashSHA := THashSHA2.Create(SHA224);
  BufLen := 16 * 1024;
  Buffer := AllocMem(BufLen);
  try
    Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    try
      while Stream.Position < Stream.Size do
      begin
        Readed := Stream.Read(Buffer^, BufLen);
        if Readed > 0 then
        begin
          HashSHA.update(Buffer^, Readed);
        end;
      end;
    finally
      Stream.Free;
    end;
  finally
    FreeMem(Buffer)
  end;
  result := HashSHA.HashAsString;
end;

function GetFileHashSHA256(FileName: WideString): String;
var
  HashSHA: THashSHA2;
  Stream: TStream;
  Readed: Integer;
  Buffer: PByte;
  BufLen: Integer;
begin
  HashSHA := THashSHA2.Create(SHA256);
  BufLen := 16 * 1024;
  Buffer := AllocMem(BufLen);
  try
    Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    try
      while Stream.Position < Stream.Size do
      begin
        Readed := Stream.Read(Buffer^, BufLen);
        if Readed > 0 then
        begin
          HashSHA.update(Buffer^, Readed);
        end;
      end;
    finally
      Stream.Free;
    end;
  finally
    FreeMem(Buffer)
  end;
  result := HashSHA.HashAsString;
end;

function GetFileHashSHA384(FileName: WideString): String;
var
  HashSHA: THashSHA2;
  Stream: TStream;
  Readed: Integer;
  Buffer: PByte;
  BufLen: Integer;
begin
  HashSHA := THashSHA2.Create(SHA384);
  BufLen := 16 * 1024;
  Buffer := AllocMem(BufLen);
  try
    Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    try
      while Stream.Position < Stream.Size do
      begin
        Readed := Stream.Read(Buffer^, BufLen);
        if Readed > 0 then
        begin
          HashSHA.update(Buffer^, Readed);
        end;
      end;
    finally
      Stream.Free;
    end;
  finally
    FreeMem(Buffer)
  end;
  result := HashSHA.HashAsString;
end;

function GetFileHashSHA512(FileName: WideString): String;
var
  HashSHA: THashSHA2;
  Stream: TStream;
  Readed: Integer;
  Buffer: PByte;
  BufLen: Integer;
begin
  HashSHA := THashSHA2.Create(SHA512);
  BufLen := 16 * 1024;
  Buffer := AllocMem(BufLen);
  try
    Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    try
      while Stream.Position < Stream.Size do
      begin
        Readed := Stream.Read(Buffer^, BufLen);
        if Readed > 0 then
        begin
          HashSHA.update(Buffer^, Readed);
        end;
      end;
    finally
      Stream.Free;
    end;
  finally
    FreeMem(Buffer)
  end;
  result := HashSHA.HashAsString;
end;

function GetFileHashSHA512_224(FileName: WideString): String;
var
  HashSHA: THashSHA2;
  Stream: TStream;
  Readed: Integer;
  Buffer: PByte;
  BufLen: Integer;
begin
  HashSHA := THashSHA2.Create(SHA512_224);
  BufLen := 16 * 1024;
  Buffer := AllocMem(BufLen);
  try
    Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    try
      while Stream.Position < Stream.Size do
      begin
        Readed := Stream.Read(Buffer^, BufLen);
        if Readed > 0 then
        begin
          HashSHA.update(Buffer^, Readed);
        end;
      end;
    finally
      Stream.Free;
    end;
  finally
    FreeMem(Buffer)
  end;
  result := HashSHA.HashAsString;
end;

function GetFileHashSHA512_256(FileName: WideString): String;
var
  HashSHA: THashSHA2;
  Stream: TStream;
  Readed: Integer;
  Buffer: PByte;
  BufLen: Integer;
begin
  HashSHA := THashSHA2.Create(SHA512_256);
  BufLen := 16 * 1024;
  Buffer := AllocMem(BufLen);
  try
    Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    try
      while Stream.Position < Stream.Size do
      begin
        Readed := Stream.Read(Buffer^, BufLen);
        if Readed > 0 then
        begin
          HashSHA.update(Buffer^, Readed);
        end;
      end;
    finally
      Stream.Free;
    end;
  finally
    FreeMem(Buffer)
  end;
  result := HashSHA.HashAsString;
end;

function GetFileHashBobJenkins(FileName: WideString): String;
var
  Hash: THashBobJenkins;
  Stream: TStream;
  Readed: Integer;
  Buffer: PByte;
  BufLen: Integer;
begin
  Hash := THashBobJenkins.Create;
  BufLen := 16 * 1024;
  Buffer := AllocMem(BufLen);
  try
    Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    try
      while Stream.Position < Stream.Size do
      begin
        Readed := Stream.Read(Buffer^, BufLen);
        if Readed > 0 then
        begin
          Hash.update(Buffer^, Readed);
        end;
      end;
    finally
      Stream.Free;
    end;
  finally
    FreeMem(Buffer)
  end;
  result := Hash.HashAsString;
end;




procedure TForm1.Button1Click(Sender: TObject);
begin
      if FileOpenDialog1.Execute(handle) then
      begin
            Lokasix := FileOpenDialog1.FileName;
            if FileExists(Lokasix) = true then
            begin
                  with MemoFile do
                  begin
                      clear;
                      Lines.Add(ExtractFileName(Lokasix)+Enter);
                      Lines.Add('MD5 :'+Enter+GetFileHashMD5(Lokasix)+Enter);
                      Lines.Add('SHA1 :'+Enter+GetFileHashSHA1(Lokasix)+Enter);
                      Lines.Add('SHA224 :'+Enter+GetFileHashSHA224(Lokasix)+Enter);
                      Lines.Add('SHA256 :'+Enter+GetFileHashSHA256(Lokasix)+Enter);
                      Lines.Add('SHA384 :'+Enter+GetFileHashSHA384(Lokasix)+Enter);
                      Lines.Add('SHA512 :'+Enter+GetFileHashSHA512(Lokasix)+Enter);
                      Lines.Add('SHA512_224 :'+Enter+GetFileHashSHA512_224(Lokasix)+Enter);
                      Lines.Add('SHA512_256 :'+Enter+GetFileHashSHA512_256(Lokasix)+Enter);
                      Lines.Add('BobJenkins :'+Enter+GetFileHashBobJenkins(Lokasix));
                  end;
            end;

      end;
end;

procedure TForm1.EditStrChange(Sender: TObject);
var
  strx : string;
begin
      with MemoStr do
      begin
          strx := EditStr.Text;
          clear;
          Lines.Add('Text : '+strx+Enter);
          Lines.Add('MD5 :'+Enter+GetStrHashMD5(strx)+Enter);
          Lines.Add('SHA1 :'+Enter+GetStrHashSHA1(strx)+Enter);
          Lines.Add('SHA224 :'+Enter+GetStrHashSHA224(strx)+Enter);
          Lines.Add('SHA256 :'+Enter+GetStrHashSHA256(strx)+Enter);
          Lines.Add('SHA384 :'+Enter+GetStrHashSHA384(strx)+Enter);
          Lines.Add('SHA512 :'+Enter+GetStrHashSHA512(strx)+Enter);
          Lines.Add('SHA512_224 :'+Enter+GetStrHashSHA512_224(strx)+Enter);
          Lines.Add('SHA512_256 :'+Enter+GetStrHashSHA512_256(strx)+Enter);
          Lines.Add('BobJenkins :'+Enter+GetStrHashBobJenkins(strx));
      end;
end;

end.
