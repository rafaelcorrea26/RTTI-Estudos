unit uProdutoDinamico;

interface

uses
  System.Generics.Collections, System.SysUtils, System.Variants;

type
  TProdutoDinamico = class
  private
    FNome: string;
    FPreco: Double;
    FDicionario: TDictionary<string, Variant>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AdicionarPropriedade(const Nome: string; Valor: Variant);
    function ObterPropriedade(const Nome: string): Variant;
    function Propriedades: TDictionary<string, Variant>;
    property Nome: string read FNome write FNome;
    property Preco: Double read FPreco write FPreco;
    procedure ListarPropriedadesDinamicas(Dicionario: TDictionary<string, Variant>);
  end;

implementation

constructor TProdutoDinamico.Create;
begin
  FDicionario := TDictionary<string, Variant>.Create;
end;

destructor TProdutoDinamico.Destroy;
begin
  FDicionario.Free;
  inherited;
end;

procedure TProdutoDinamico.ListarPropriedadesDinamicas(Dicionario: TDictionary<string, Variant>);
var
  Chave: string;
begin
  Writeln('Propriedades dinâmicas:');
  for Chave in Dicionario.Keys do
  begin
    Writeln('  Nome: ', Chave, ' | Valor: ', Dicionario[Chave]);
  end;
end;

procedure TProdutoDinamico.AdicionarPropriedade(const Nome: string; Valor: Variant);
begin
  FDicionario.AddOrSetValue(Nome, Valor);
end;

function TProdutoDinamico.ObterPropriedade(const Nome: string): Variant;
begin
  if not FDicionario.TryGetValue(Nome, Result) then
    raise Exception.CreateFmt('Propriedade "%s" não encontrada.', [Nome]);
end;

function TProdutoDinamico.Propriedades: TDictionary<string, Variant>;
begin
  Result := FDicionario;
end;

end.

