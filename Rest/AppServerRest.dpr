program AppServerRest;
{$APPTYPE GUI}

{$R *.dres}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  ufrmMain in 'ufrmMain.pas' {frmMain},
  uSM in 'uSM.pas',
  uWM in 'uWM.pas' {WM: TWebModule},
  uMetadados in 'uMetadados.pas',
  uConection in 'uConection.pas',
  uPessoa in '..\Classes\uPessoa.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
