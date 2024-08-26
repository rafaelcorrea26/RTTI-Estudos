unit uMensagem;

interface

type
  TMensagem = class
  private
    FDescription: string;
  public
    constructor Create(const ADescricao: string);
    property Descricao: string read FDescription write FDescription;
  end;

implementation

constructor TMensagem.Create(const ADescricao: string);
begin
  FDescription := ADescricao;
end;

end.

