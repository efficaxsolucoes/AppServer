unit uConection;

interface

Uses
  System.Types, System.UITypes, System.Classes, System.Variants,
  System.IOUtils, uMetadados, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Comp.UI, FireDAC.DApt,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Comp.Client,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLite, FireDAC.FMXUI.Wait, Vcl.Forms,
  FireDAC.Phys.MSSQLDef, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL;

  Type
     TConexaoDB = class
       private
         fConnection : TFDConnection;
       protected

         function Existe(xSql: string): boolean;

         procedure ConfigurarDB;
         procedure ConfigurarDBMSSQL;
         procedure ConfigurarTabelas;
         procedure CriarBancoMSSQL(script: string);
         procedure CriarTabela(sTabela : String);
       public
         constructor Create;
         destructor Destroy;
         function Execute(const Qry: TFDQuery): boolean;
         function NovoID(psTabela, psId : String) : Integer;
       published
         property Connection : TFDConnection read fConnection;
     end;

Var
  ConexaoDB : TConexaoDB;


implementation

uses
  System.SysUtils;



{ TConexaoDB }

procedure TConexaoDB.ConfigurarDB;
Const
  sNameDB = 'Efficax.s3db';
Var
  DIR             : String;
 sDbPath          : String;
 configuraTabelas : Boolean;
 handleFile       : Integer;
begin
  dir     := ExtractFilePath(Application.ExeName) + 'DB\';
  sDbPath := Dir +  sNameDB ;

  if not DirectoryExists(DIR) then
    forceDirectories(DIR);

  if Not(FileExists(sDbPath)) then
  Begin
    handleFile := FileCreate(sDbPath);
    FileClose(handleFile);
    configuraTabelas := True;
  End;

  // Passa os parametros de Conexão e Conecta ao Banco de Dados
  Connection.LoginPrompt := False;
  Connection.Params.Clear;
  Connection.Params.Values['Database']     := sDbPath;
  Connection.Params.Values['DriverID']     := 'SQLite';
  Connection.Params.Values['CharacterSet'] := 'utf8';
  Connection.Connected := True;

  // Verifica Tabelas
  if configuraTabelas then
    ConfigurarTabelas;
end;

procedure TConexaoDB.ConfigurarDBMSSQL;
begin
  // Passa os parametros de Conexão e Conecta ao Banco de Dados
  Connection.LoginPrompt := False;
  Connection.Params.Clear;
  Connection.Params.Values['DriverID']      := 'MSSQL';
  Connection.Params.Values['DATABASE']      := 'master';
  Connection.Params.Values['CharacterSet']  := 'utf8';
  Connection.Params.Values['SERVER']        := 'localhost';
  Connection.Params.Values['user_name']     := 'sa';
  Connection.Params.Values['Password']      := '1234';

  Connection.Connected := True;

  CriarBancoMSSQL('');

end;

procedure TConexaoDB.ConfigurarTabelas;
begin
  CriarTabela(tbl_Cliente);
  CriarTabela(tbl_Produtos  );
  CriarTabela(tbl_Venda     );
  CriarTabela(tbl_VendaItens);
end;

constructor TConexaoDB.Create;
begin
  fConnection := TFDConnection.Create(Nil);
  ConfigurarDBMSSQL;
//  ConfigurarDB;
end;

procedure TConexaoDB.CriarBancoMSSQL(script: string);
const
  xBanco = 'efficax';
Var
  DIR             : String;
  QueryValid : TFDQuery;
begin
  dir := ExtractFilePath(Application.ExeName) + 'DB';
  if not DirectoryExists(DIR) then
    forceDirectories(DIR);

  dir := dir + '\' + xBanco ;
  if not FileExists(dir+'.mdf') then
  begin

    QueryValid := TFDQuery.Create(Connection);
    try
     QueryValid.Connection := Connection;
     QueryValid.SQL.Clear;
     QueryValid.SQL.Add('CREATE DATABASE [' + xBanco +']');
     QueryValid.SQL.Add('CONTAINMENT = NONE');
     QueryValid.SQL.Add('ON  PRIMARY');
     QueryValid.SQL.Add('( NAME = N' + QuotedStr(xBanco) + ', FILENAME = N' + QuotedStr(dir +'.mdf') +  ',');
     QueryValid.SQL.Add('SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )');
     QueryValid.SQL.Add('LOG ON');
     QueryValid.SQL.Add('( NAME = N' + QuotedStr(xBanco + '_log')+', FILENAME = N' + QuotedStr(dir + '_log.ldf') +', SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)');
     QueryValid.ExecSQL;
     Connection.Connected := false;
     Connection.Params.Values['DATABASE']      := xBanco;
     Connection.Connected := True;

     ConfigurarTabelas;
    finally
     FreeAndNil(QueryValid);
    end;
  end;
end;

procedure TConexaoDB.CriarTabela(sTabela: String);
Var
  QueryValid : TFDQuery;
begin
  QueryValid := TFDQuery.Create(Connection);
  try
   QueryValid.Connection := Connection;
   QueryValid.SQL.Clear;
   QueryValid.SQL.Text := 'CREATE TABLE ' + sTabela;
   QueryValid.ExecSQL;
  finally
   FreeAndNil(QueryValid);
  end;
end;

destructor TConexaoDB.Destroy;
begin
  FreeAndNil(fConnection);
end;

function TConexaoDB.Execute(const Qry: TFDQuery): boolean;
begin
  Qry.Connection := Connection;
  Qry.Open;
  Result := true;
end;

function TConexaoDB.Existe(xSql: string): boolean;
Var
  QueryValid : TFDQuery;
begin
  Result := False;
  QueryValid := TFDQuery.Create(Connection);
  try
   QueryValid.Connection := Connection;
   QueryValid.SQL.Clear;
   QueryValid.SQL.Text := xSql;
   QueryValid.ExecSQL;
   Result := QueryValid.RecordCount > 0;
  finally
   FreeAndNil(QueryValid);
  end;
end;

function TConexaoDB.NovoID(psTabela, psId: String): Integer;
Var
  oQuery : TFDQuery;
begin
  oQuery := TFDQuery.Create(Connection);
  try
    oQuery.Connection := Connection;

    oQuery.SQL.Clear;
    oQuery.SQL.Text := 'Select coalesce(Max('+psId+'),0) id From ' +  psTabela;
    oQuery.Open;

    Result := oQuery.FieldByName('id').AsInteger + 1;
  finally
    FreeAndNil(oQuery);
  end;
end;

end.
