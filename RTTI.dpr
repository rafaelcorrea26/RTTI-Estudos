program RTTI;

uses
  Vcl.Forms,
  View.Principal in 'View.Principal.pas' {Principal},
  uProduto in 'uProduto.pas',
  uProdutoDinamico in 'uProdutoDinamico.pas',
  uMensagem in 'uMensagem.pas',
  uMensagemList in 'uMensagemList.pas',
  uFormularioBaseRTTI in 'uFormularioBaseRTTI.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TPrincipal, Principal);
  Application.Run;
end.
