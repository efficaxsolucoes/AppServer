unit uMetadados;

interface

// Metadados
   resourcestring
     // Tabela de Cliente --------------------------------------------------
     tbl_Cliente  = 'Cliente (Cliente_ID             INT(10)    , ' +
                             'Cliente_Nome           VARCHAR(60), ' +
                             'Cliente_DataNascimento DATE       , ' +
                             'Cliente_Telefone       VARCHAR(12), ' +
                             'Cliente_Email          VARCHAR(60), ' +
                             'Cliente_DataCadastro   DATE         ' +
                             ')                                   ' ;

     // Tabela de Produto --------------------------------------------------
     tbl_Produtos = 'Produto (Produto_ID      INT        ,' +
                             'Produto_Codigo  VARCHAR(12),' +
                             'Produto_Nome    VARCHAR(60),' +
                             'Produto_preco   REAL        ' +
                             ')                           ' ;


     // Tabela de Venda ----------------------------------------------------
     tbl_Venda    = 'Venda (Venda_ID   INT ,' +
                           'Cliente_ID INT ,' +
                           'Venda_Data DATE ' +
                           ')               ' ;

     // Tabela de VendaItens -----------------------------------------------
     tbl_VendaItens = 'VendaItens (VendaItens_ID  INT  ,' +
                                  'Venda_ID       INT  ,' +
                                  'Produto_ID     INT  ,' +
                                  'Quantidade     INT  ,' +
                                  'Preco          FLOAT,' +
                                  'Desconto       FLOAT ' +
                                  ')                    ' ;

implementation

end.
