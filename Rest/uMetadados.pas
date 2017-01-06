unit uMetadados;

interface

// Metadados
   resourcestring
     // Tabela de Cliente --------------------------------------------------
     tbl_Cliente  = 'Pessoas (ID             INT    , ' +
                             'Nome           VARCHAR(100), ' +
                             'Fantasia           VARCHAR(100), ' +
                             'DataNascimento DATE       , ' +
                             'DataCadastro   DATE         ' +
                             ')                                   ' ;

     // Tabela de Produto --------------------------------------------------
     tbl_Produtos = 'Produto (ID      INT        ,' +
                             'Codigo  VARCHAR(12),' +
                             'Nome    VARCHAR(60),' +
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
