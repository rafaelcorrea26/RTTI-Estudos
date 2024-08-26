unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Rtti, System.TypInfo,
  Vcl.StdCtrls, uProduto, uMensagemList;

type
  TPrincipal = class(TForm)
    Teste: TButton;
    procedure TesteClick(Sender: TObject);
  private
    { Private declarations }
    procedure ListarPropriedades(AObjeto: TObject);
    procedure ListarMetodos(AObjeto: TObject);
  public
    { Public declarations }
  end;

var
  Principal: TPrincipal;

implementation

{$R *.dfm}

procedure TPrincipal.TesteClick(Sender: TObject);
var
  Produto: TProduto;
begin
  Produto := TProduto.Create;
  try
    // Define propriedades conhecidas
    Produto.Nome := 'Produto Exemplo';
    Produto.Preco := 19.99;

    ListarPropriedades(Produto);
    ListarMetodos(Produto);
  finally
    Produto.Free;
  end;
end;

procedure TPrincipal.ListarMetodos(AObjeto: TObject);
var
  RttiContext: TRttiContext;
  RttiType: TRttiType;
  RttiMethod: TRttiMethod;
  Mensagens: TMensagemList;
begin
  Mensagens := TMensagemList.Create;
  RttiContext := TRttiContext.Create;
  try
    RttiType := RttiContext.GetType(AObjeto.ClassType);
    Mensagens.Limpar;
    Mensagens.Add('Métodos da classe :'+AObjeto.ClassName);
    Mensagens.Add(' ');
    for RttiMethod in RttiType.GetMethods do
    begin
      if RttiMethod.Visibility = mvPublic then
      begin
        Mensagens.Add('Nome: '+RttiMethod.Name);
      end;
    end;

    Mensagens.ListaMensagens;
  finally
    RttiContext.Free;
    Mensagens.Free;
  end;
end;

procedure TPrincipal.ListarPropriedades(AObjeto: TObject);
var
  RttiContext: TRttiContext;
  RttiType: TRttiType;
  RttiProp: TRttiProperty;
  Mensagens: TMensagemList;
begin

  Mensagens := TMensagemList.Create;
  RttiContext := TRttiContext.Create;
  try
    RttiType := RttiContext.GetType(AObjeto.ClassType);
    Mensagens.Limpar;
    Mensagens.Add('Métodos da classe :'+AObjeto.ClassName);
    Mensagens.Add(' ');
    for RttiProp in RttiType.GetProperties do
    begin
      Mensagens.Add('Nome: '+ RttiProp.Name + ' | Tipo: '+ RttiProp.PropertyType.Name);
    end;

    Mensagens.ListaMensagens;
  finally
    Mensagens.Free;
    RttiContext.Free;
  end;
end;

end.
