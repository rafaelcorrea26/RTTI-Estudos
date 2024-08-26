unit uProduto;

interface

uses
  System.Rtti, System.SysUtils, System.Classes, Generics.Collections;

type
  TProduto = class
  private
    FNome: string;
    FPreco: Double;
    FCor: string;
  public
    constructor Create;
    property Nome: string read FNome write FNome;
    property Preco: Double read FPreco write FPreco;
    property Cor: string read FCor write FCor;
    procedure IssoEhUmTeste;
  end;

implementation

constructor TProduto.Create;
begin
  // Inicialização, se necessário
end;

procedure TProduto.IssoEhUmTeste;
begin
//
end;

end.

