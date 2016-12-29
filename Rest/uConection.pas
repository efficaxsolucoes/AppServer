unit uConection;

interface

uses FireDAC.Comp.Client;

  Type
     TConexaoDB = class
       private
         fConnection : TFDConnection;
       protected
         procedure ConfigurarDB;
         procedure ConfigurarTabelas;
         procedure CriarTabela(sTabela : String);
       public
         constructor Create;
         destructor Destroy;

         function NovoID(psTabela, psId : String) : Integer;
       published
         property Connection : TFDConnection read fConnection;
     end;
implementation

uses
  System.SysUtils, Vcl.Forms;

{ TConexaoDB }

procedure TConexaoDB.ConfigurarDB;
Const
 sNameDB = 'db\DB_AppREST.s3db';
Var
 sDbPath          : String;
 configuraTabelas : Boolean;
 handleFile       : Integer;
begin
 sDbPath := ExtractFilePath(Application.ExeName) + sNameDB ;

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

procedure TConexaoDB.ConfigurarTabelas;
begin
  CriarTabela('tbl_Cliente'   );
  CriarTabela('tbl_Produtos'  );
  CriarTabela('tbl_Venda'     );
  CriarTabela('tbl_VendaItens');
end;

constructor TConexaoDB.Create;
begin

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
  fConnection.Free;
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
