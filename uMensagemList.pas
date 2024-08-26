unit uMensagemList;

interface

uses
  System.Generics.Collections, uMensagem, System.SysUtils, vcl.Dialogs;

type
  TMensagemList = class
  private
    FMensagens: TList<TMensagem>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(const Descricao: string);
    procedure Remover(Index: Integer);
    procedure Limpar;
    function GetMensagem(Index: Integer): TMensagem;
    function Count: Integer;
    procedure ListaMensagens;
  end;

implementation

constructor TMensagemList.Create;
begin
  FMensagens := TList<TMensagem>.Create;
end;

destructor TMensagemList.Destroy;
begin
  FMensagens.Free;
  inherited;
end;

procedure TMensagemList.Add(const Descricao: string);
begin
  FMensagens.Add(TMensagem.Create(Descricao));
end;

procedure TMensagemList.Remover(Index: Integer);
begin
  if (Index >= 0) and (Index < FMensagens.Count) then
  begin
    FMensagens.Delete(Index);
  end
  else
    raise Exception.Create('Índice inválido.');
end;

function TMensagemList.GetMensagem(Index: Integer): TMensagem;
begin
  if (Index >= 0) and (Index < FMensagens.Count) then
    Result := FMensagens[Index]
  else
    raise Exception.Create('Índice inválido.');
end;

function TMensagemList.Count: Integer;
begin
  Result := FMensagens.Count;
end;

procedure TMensagemList.Limpar;
begin
    FMensagens.Clear;
end;

procedure TMensagemList.ListaMensagens;
var
  Msg: TMensagem;
  result : String;
begin
  result:= EmptyStr;
  for Msg in FMensagens do
  begin
    if result <> EmptyStr then
      result:= result + sLineBreak;

    result:= result + (Msg.Descricao);
  end;

  ShowMessage(result);
end;

end.

