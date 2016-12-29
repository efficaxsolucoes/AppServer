unit uSM;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth;

type
{$METHODINFO ON}
  TSM = class(TComponent)
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function Ping:string;
  end;
{$METHODINFO OFF}

implementation


uses System.StrUtils;

function TSM.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TSM.Ping: string;
begin
  Result := 'ok';
end;

function TSM.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;
end.

