unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Rtti, System.TypInfo,
  Vcl.StdCtrls, uProduto, uMensagemList, uFormularioBaseRTTI, System.JSON;

type
  TPrincipal = class(TForm)
    Teste: TButton;
    Button1: TButton;
    procedure TesteClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure ListarPropriedades(AObjeto: TObject);
    procedure ListarMetodos(AObjeto: TObject);

    function CriarPopularForm(const FormStructure: TFormStructure): TForm;
    function SerializarObjeto(obj: TObject): string;
    function DeserializarObjeto(jsonData: string; objClass: TClass): TObject;
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

procedure TPrincipal.Button1Click(Sender: TObject);
var
  MyFormStructure: TFormStructure;
  MyForm: TForm;
  RttiContext: TRttiContext;
  RttiType: TRttiType;
  Prop: TRttiProperty;
  Attr: TCustomAttribute;
begin
  MyFormStructure := TFormStructure.Create;
  RttiContext := TRttiContext.Create;
  try
    RttiType := RttiContext.GetType(TFormBase);
    for Prop in RttiType.GetProperties do
    begin
      for Attr in Prop.GetAttributes do
      begin
        if Attr is ComponentClassAttribute then
        begin
          if ComponentClassAttribute(Attr).ComponentClass = TButton then
          begin
            MyFormStructure.ButtonInfo := TComponentInfo.Create;
            MyFormStructure.ButtonInfo.ComponentClass := ComponentClassAttribute(Attr).ComponentClass;
            MyFormStructure.ButtonInfo.PropertyName := ComponentClassAttribute(Attr).Name;
            MyFormStructure.ButtonInfo.Caption := ComponentClassAttribute(Attr).Caption;
          end;

          if ComponentClassAttribute(Attr).ComponentClass = TLabel then
          begin
            MyFormStructure.LabelInfo := TComponentInfo.Create;
            MyFormStructure.LabelInfo.ComponentClass := ComponentClassAttribute(Attr).ComponentClass;
            MyFormStructure.LabelInfo.PropertyName := ComponentClassAttribute(Attr).Name;
            MyFormStructure.LabelInfo.Caption := ComponentClassAttribute(Attr).Caption;
          end;
        end;
      end;
    end;
   MyForm := CriarPopularForm(MyFormStructure);
   MyForm.Show;
  finally
    RttiContext.Free;
  end;
end;

function TPrincipal.CriarPopularForm(const FormStructure: TFormStructure): TForm;
var
  Form: TForm;
  Button: TButton;
  LabelCtrl: TLabel;
  Ctx: TRttiContext;
  Tp: TRttiType;
  rttMeuField: TRttiField;
begin
  Form := TForm.Create(nil);
  Form.Caption := 'Form Dinamico';
  Form.Width := 800;
  Form.Height := 600;
  Form.Position := poDesktopCenter;

  Ctx := TRttiContext.Create;
  Tp := Ctx.GetType(FormStructure.ClassType);
  try
    rttMeuField := Tp.GetField('ButtonInfo');
    if Assigned(rttMeuField)  then
    begin
      Button := TButton.Create(Form);
      Button.Left:= 2;
      Button.Parent := Form;
      Button.Caption := FormStructure.ButtonInfo.Caption;
    end;

    rttMeuField := Tp.GetField('LabelInfo');
    if Assigned(rttMeuField)  then
    begin
      LabelCtrl := TLabel.Create(Form);
      LabelCtrl.Left := 100;
      LabelCtrl.Parent := Form;
      LabelCtrl.Caption := FormStructure.LabelInfo.Caption;
    end;
  finally
    Ctx.Free;
  end;
  Result := Form;
end;

function TPrincipal.DeserializarObjeto(jsonData: string; objClass: TClass): TObject;
var
  ctx: TRttiContext;
  prop: TRttiProperty;
  jsonObject: TJSONObject;
  obj: TObject;
  Nome: string;
begin
  ctx := TRttiContext.Create;
  try
    jsonObject := TJSONObject.ParseJSONValue(jsonData) as TJSONObject;
    obj := objClass.Create;

    for prop in ctx.GetType(obj.ClassType).GetProperties do
    begin
      if jsonObject.TryGetValue<string>(prop.Name, Nome) then
      begin
        prop.SetValue(obj, TValue(Nome));
      end;
    end;

    Result := obj;
  finally
    ctx.Free;
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

function TPrincipal.SerializarObjeto(obj: TObject): string;
var
  ctx: TRttiContext;
  prop: TRttiProperty;
  jsonObject: TJSONObject;
begin
  ctx := TRttiContext.Create;
  try
    jsonObject := TJSONObject.Create;

    for prop in ctx.GetType(obj.ClassType).GetProperties do
    begin
      jsonObject.AddPair(prop.Name, prop.GetValue(obj).ToString);
    end;

    Result := jsonObject.ToJSON;
  finally
    ctx.Free;
  end;
end;

end.
