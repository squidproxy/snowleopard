library listen;
{ listen Module}
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
  IdHTTPServer, IdContext, IdTCPServer, IdCustomHTTPServer, Classes, SysUtils;

Type
  TCommandHandler = class
  protected
    procedure DoCommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);

  end;

var
  Server: TIdHTTPServer;
  CH: TCommandHandler;
  listencontext: string;

function LoadFileToStr(const FileName: TFileName): String;
var
  FileStream: TFileStream;
  Bytes: TBytes;

begin
  Result := '';
  FileStream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    if FileStream.Size > 0 then
    begin
      SetLength(Bytes, FileStream.Size);
      FileStream.Read(Bytes[0], FileStream.Size);
    end;
    Result := TEncoding.ASCII.GetString(Bytes);
  finally
    FileStream.Free;
  end;
end;

procedure TCommandHandler.DoCommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  AResponseInfo.ContentText := listencontext;
  AResponseInfo.ContentType := 'text/plain';
end;

procedure ReadPacContext(ServerIPAandPort: string);
var
  tempfolder: string;
  sList: TStringList;

  before, after: string;

begin
  before := LoadFileToStr(GetCurrentDir+'\pac.txt');

  listencontext := StringReplace(before, 'Squidproxyproject:port', ServerIPAandPort,
    [rfReplaceAll, rfIgnoreCase]);

end;

procedure listenport(port: integer);
begin
  Server := TIdHTTPServer.Create(nil);
  CH := TCommandHandler.Create;
  Server.OnCommandGet := CH.DoCommandGet;
  Server.DefaultPort := port;
  Server.Active := True;

end;

exports ReadPacContext;

exports listenport;

{$R *.res}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
{$WEAKLINKRTTI ON}

begin

end.
