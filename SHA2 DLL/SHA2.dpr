library SHA2;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
 ShareMem,
  System.SysUtils,
  System.Hash,
  System.Classes;

function GetStrHashMD5(Str: String): String;    stdcall;
var
  HashMD5: THashMD5;
begin
    HashMD5 := THashMD5.Create;
    HashMD5.GetHashString(Str);
    result := HashMD5.GetHashString(Str);
end;

function GetStrHashSHA1(Str: String): String;     stdcall;
var
  HashSHA: THashSHA1;
begin
    HashSHA := THashSHA1.Create;
    HashSHA.GetHashString(Str);
    result := HashSHA.GetHashString(Str);
end;

function GetStrHashSHA224(Str: String): String;    stdcall;
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

function GetStrHashSHA384(Str: String): String;    stdcall;
var
  HashSHA: THashSHA2;
begin
    HashSHA := THashSHA2.Create;
    HashSHA.GetHashString(Str);
    result := HashSHA.GetHashString(Str,SHA384);
end;

function GetStrHashSHA512(Str: String): String;  stdcall;
var
  HashSHA: THashSHA2;
begin
    HashSHA := THashSHA2.Create;
    HashSHA.GetHashString(Str);
    Result := HashSHA.GetHashString(Str,SHA512);
end;

function GetStrHashSHA512_224(Str: String): String;  stdcall;
var
  HashSHA: THashSHA2;
begin
    HashSHA := THashSHA2.Create;
    HashSHA.GetHashString(Str);
    Result := HashSHA.GetHashString(Str,SHA512_224);
end;

function GetStrHashSHA512_256(Str: String): String;     stdcall;
var
  HashSHA: THashSHA2;
begin
    HashSHA := THashSHA2.Create;
    HashSHA.GetHashString(Str);
    Result := HashSHA.GetHashString(Str,SHA512_256);
end;


exports GetStrHashSHA512_256;

{$R *.res}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
{$WEAKLINKRTTI ON}

begin
end.
