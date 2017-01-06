program AppServerRest;
{$APPTYPE GUI}

{$R *.dres}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  uWM in 'uWM.pas' {WM: TWebModule},
  uMetadados in 'uMetadados.pas',
  uConection in 'uConection.pas',
  ufrmPrincipal in 'ufrmPrincipal.pas' {frmPrincipal},
  uSMCadastros in 'uSMCadastros.pas' {SMCadastros: TDSServerModule},
  uPessoaDao in '..\Classes\Dao\uPessoaDao.pas',
  uPessoa in '..\Classes\Cadastros\uPessoa.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
