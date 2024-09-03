unit uFormularioBaseRTTI;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type

  TComponentInfo = class
  public
    ComponentClass: TComponentClass;
    PropertyName: string;
    Caption: string;
  end;

 TFormStructure = class
  public
    ButtonInfo: TComponentInfo;
    LabelInfo: TComponentInfo;
  end;

  ComponentClassAttribute = class(TCustomAttribute)
  private
    FComponentClass: TComponentClass;
    FName: string;
    FCaption: string;
  public
    constructor Create(AComponentClass: TComponentClass;AName,ACaption: string);
    property ComponentClass: TComponentClass read FComponentClass;
    property Name: string read FName;
    property Caption: string read FCaption;
  end;

  TFormBase = class
  private
    FButtonInfo: TComponentInfo;
    FLabelInfo: TComponentInfo;
  public
    [ComponentClass(TButton,'Button1','Clicar aqui')]
    property ButtonInfo: TComponentInfo read FButtonInfo write FButtonInfo;
    [ComponentClass(TLabel, 'Label1', 'Meu Label')]
    property LabelInfo: TComponentInfo read FLabelInfo write FLabelInfo;
  end;

implementation

{ ComponentClassAttribute }

constructor ComponentClassAttribute.Create(AComponentClass: TComponentClass;
  AName, ACaption: string);
begin
  FComponentClass := AComponentClass;
  FName := AName;
  FCaption := ACaption;
end;

end.
