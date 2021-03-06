{$M+}
unit PanamahSDK;

interface

uses
  Classes, Windows, SysUtils, Messages, DateUtils, SyncObjs, PanamahSDK.Enums, PanamahSDK.Operation, PanamahSDK.Types,
  PanamahSDK.Client, PanamahSDK.Batch, PanamahSDK.Models.Acesso, PanamahSDK.Models.Assinante, PanamahSDK.Models.Cliente,
  PanamahSDK.Models.Compra, PanamahSDK.Models.Ean, PanamahSDK.Models.EstoqueMovimentacao, PanamahSDK.Models.EventoCaixa,
  PanamahSDK.Models.FormaPagamento, PanamahSDK.Models.Fornecedor, PanamahSDK.Models.Funcionario,
  PanamahSDK.Models.Grupo, PanamahSDK.Models.Holding, PanamahSDK.Models.LocalEstoque, PanamahSDK.Models.Loja,
  PanamahSDK.Models.Meta, PanamahSDK.Models.Produto, PanamahSDK.Models.Revenda, PanamahSDK.Models.Secao,
  PanamahSDK.Models.Subgrupo, PanamahSDK.Models.TituloPagar, PanamahSDK.Models.TituloReceber,
  PanamahSDK.Models.TrocaDevolucao, PanamahSDK.Models.TrocaFormaPagamento, PanamahSDK.Models.Venda, PanamahSDK.Processor,
  PanamahSDK.NFe, PanamahSDK.Consts, PanamahSDK.PendingResources;

type

  TPanamahStreamConfig = class(TInterfacedObject, IPanamahStreamConfig)
  private
    FAssinanteId: string;
    FSecret: string;
    FAuthorizationToken: string;
    FBaseDirectory: string;
    FBatchTTL: Integer;
    FBatchMaxSize: Integer;
    FBatchMaxCount: Integer;
    function GetBaseDirectory: string;
    function GetBatchTTL: Integer;
    function GetBatchMaxSize: Integer;
    function GetBatchMaxCount: Integer;
    function GetAssinanteId: string;
    function GetSecret: string;
    function GetAuthorizationToken: string;
    procedure SetAuthorizationToken(const AAuthorizationToken: string);
    procedure SetBaseDirectory(const ABaseDirectory: string);
    procedure SetAssinanteId(const AAssinanteId: string);
    procedure SetSecret(const ASecret: string);
  published
    constructor Create; reintroduce;
    property BaseDirectory: string read GetBaseDirectory write SetBaseDirectory;
    property BatchTTL: Integer read GetBatchTTL;
    property BatchMaxSize: Integer read GetBatchMaxSize;
    property BatchMaxCount: Integer read GetBatchMaxCount;
    property AssinanteId: string read GetAssinanteId write SetAssinanteId;
    property Secret: string read GetSecret write SetSecret;
    property AuthorizationToken: string read GetAuthorizationToken write SetAuthorizationToken;
  end;

  TPanamahAdminConfig = class(TInterfacedObject, IPanamahAdminConfig)
  private
    FAuthorizationToken: string;
    function GetAuthorizationToken: string;
    procedure SetAuthorizationToken(const AAuthorizationToken: string);
  published
    constructor Create; reintroduce;
    property AuthorizationToken: string read GetAuthorizationToken write SetAuthorizationToken;
  end;

  TPanamahAdmin = class
  private
    FConfig: IPanamahAdminConfig;
    FClient: IPanamahClient;
  public
    procedure Init(AConfig: IPanamahAdminConfig); overload;
    procedure Init(const AAuthorizationToken: string); overload;
    function GetAssinante(const AAssinanteId: string): IPanamahAssinante;
    function SaveAssinante(AAssinante: IPanamahAssinante): Boolean;
    constructor Create; reintroduce;
    class function GetInstance: TPanamahAdmin;
    class procedure Free;
  end;

  TPanamahStream = class
  private
    FConfig: IPanamahStreamConfig;
    FProcessor: TPanamahBatchProcessor;
    function GetOnCurrentBatchExpired: TPanamahBatchEvent;
    function GetOnBeforeObjectAddedToBatch: TPanamahModelEvent;
    function GetOnBeforeOperationtSent: TPanamahOperationEvent;
    function GetOnBeforeBatchSent: TPanamahBatchEvent;
    function GetOnBeforeSave: TPanamahCancelableModelEvent;
    function GetOnBeforeDelete: TPanamahCancelableModelEvent;
    function GetOnError: TPanamahErrorEvent;
    procedure SetOnBeforeSave(AEvent: TPanamahCancelableModelEvent);
    procedure SetOnBeforeDelete(AEvent: TPanamahCancelableModelEvent);
    procedure SetOnError(AEvent: TPanamahErrorEvent);
    procedure SetOnCurrentBatchExpired(AEvent: TPanamahBatchEvent);
    procedure SetOnBeforeObjectAddedToBatch(AEvent: TPanamahModelEvent);
    procedure SetOnBeforeBatchSent(AEvent: TPanamahBatchEvent);
    procedure SetOnBeforeOperationSent(AEvent: TPanamahOperationEvent);
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    class procedure Free;
    class function GetInstance: TPanamahStream;
    function ReadNFeDirectory(const ADirectory: string): IPanamahNFeDocumentList; overload;
    function ReadNFe(const AFilename: string): IPanamahNFeDocument; overload;
    function ReadNFe(ADocumentType: TPanamahNFeDocumentType; const AFilename: string): IPanamahNFeDocument; overload;
    function GetPendingResources: IPanamahPendingResourcesList;
    procedure Init; overload;
    procedure Init(AConfig: IPanamahStreamConfig); overload;
    procedure Init(const AAuthorizationToken, ASecret, AAssinanteId: string); overload;
    procedure Flush;
    procedure Save(ANFeDocumentList: IPanamahNFeDocumentList); overload;
    procedure Save(ANFeDocument: IPanamahNFeDocument); overload;
    procedure Save(AAcesso: IPanamahAcesso); overload;
    procedure Save(ACliente: IPanamahCliente); overload;
    procedure Save(ACompra: IPanamahCompra); overload;
    procedure Save(AEan: IPanamahEan); overload;
    procedure Save(AEstoqueMovimentacao: IPanamahEstoqueMovimentacao); overload;
    procedure Save(AEventoCaixa: IPanamahEventoCaixa); overload;
    procedure Save(AFormaPagamento: IPanamahFormaPagamento); overload;
    procedure Save(AFornecedor: IPanamahFornecedor); overload;
    procedure Save(AFuncionario: IPanamahFuncionario); overload;
    procedure Save(AGrupo: IPanamahGrupo); overload;
    procedure Save(AHolding: IPanamahHolding); overload;
    procedure Save(ALocalEstoque: IPanamahLocalEstoque); overload;
    procedure Save(ALoja: IPanamahLoja); overload;
    procedure Save(AMeta: IPanamahMeta); overload;
    procedure Save(AProduto: IPanamahProduto); overload;
    procedure Save(ARevenda: IPanamahRevenda); overload;
    procedure Save(ASecao: IPanamahSecao); overload;
    procedure Save(ASubgrupo: IPanamahSubgrupo); overload;
    procedure Save(ATituloPagar: IPanamahTituloPagar); overload;
    procedure Save(ATituloReceber: IPanamahTituloReceber); overload;
    procedure Save(ATrocaDevolucao: IPanamahTrocaDevolucao); overload;
    procedure Save(ATrocaFormaPagamento: IPanamahTrocaFormaPagamento); overload;
    procedure Save(AVenda: IPanamahVenda); overload;
    procedure Delete(AAcesso: IPanamahAcesso); overload;
    procedure Delete(ACliente: IPanamahCliente); overload;
    procedure Delete(ACompra: IPanamahCompra); overload;
    procedure Delete(AEan: IPanamahEan); overload;
    procedure Delete(AEstoqueMovimentacao: IPanamahEstoqueMovimentacao); overload;
    procedure Delete(AEventoCaixa: IPanamahEventoCaixa); overload;
    procedure Delete(AFormaPagamento: IPanamahFormaPagamento); overload;
    procedure Delete(AFornecedor: IPanamahFornecedor); overload;
    procedure Delete(AFuncionario: IPanamahFuncionario); overload;
    procedure Delete(AGrupo: IPanamahGrupo); overload;
    procedure Delete(AHolding: IPanamahHolding); overload;
    procedure Delete(ALocalEstoque: IPanamahLocalEstoque); overload;
    procedure Delete(ALoja: IPanamahLoja); overload;
    procedure Delete(AMeta: IPanamahMeta); overload;
    procedure Delete(AProduto: IPanamahProduto); overload;
    procedure Delete(ARevenda: IPanamahRevenda); overload;
    procedure Delete(ASecao: IPanamahSecao); overload;
    procedure Delete(ASubgrupo: IPanamahSubgrupo); overload;
    procedure Delete(ATituloPagar: IPanamahTituloPagar); overload;
    procedure Delete(ATituloReceber: IPanamahTituloReceber); overload;
    procedure Delete(ATrocaDevolucao: IPanamahTrocaDevolucao); overload;
    procedure Delete(ATrocaFormaPagamento: IPanamahTrocaFormaPagamento); overload;
    procedure Delete(AVenda: IPanamahVenda); overload;
    property OnCurrentBatchExpired: TPanamahBatchEvent read GetOnCurrentBatchExpired write SetOnCurrentBatchExpired;
    property OnBeforeObjectAddedToBatch: TPanamahModelEvent read GetOnBeforeObjectAddedToBatch write SetOnBeforeObjectAddedToBatch;
    property OnBeforeBatchSent: TPanamahBatchEvent read GetOnBeforeBatchSent write SetOnBeforeBatchSent;
    property OnBeforeOperationSent: TPanamahOperationEvent read GetOnBeforeOperationtSent write SetOnBeforeOperationSent;
    property OnBeforeSave: TPanamahCancelableModelEvent read GetOnBeforeSave write SetOnBeforeSave;
    property OnBeforeDelete: TPanamahCancelableModelEvent read GetOnBeforeDelete write SetOnBeforeDelete;
    property OnError: TPanamahErrorEvent read GetOnError write SetOnError;
  end;

var
  _PanamahStreamInstance: TPanamahStream;
  _PanamahAdminInstance: TPanamahAdmin;

implementation

uses
  PanamahSDK.ValidationUtils;

{ TPanamahStream }

procedure TPanamahStream.Init(AConfig: IPanamahStreamConfig);
begin
  FConfig := AConfig;
  if not {$IFDEF UNICODE}FProcessor.Started{$ELSE}not FProcessor.Suspended{$ENDIF} then
    FProcessor.Start(FConfig);
end;

procedure TPanamahStream.Init(const AAuthorizationToken, ASecret, AAssinanteId: string);
var
  Config: IPanamahStreamConfig;
begin
  Config := TPanamahStreamConfig.Create;
  Config.AssinanteId := AAssinanteId;
  Config.Secret := ASecret;
  Config.AuthorizationToken := AAuthorizationToken;
  Init(Config);
end;

function TPanamahStream.ReadNFe(ADocumentType: TPanamahNFeDocumentType; const AFilename: string): IPanamahNFeDocument;
begin
  Result := TPanamahNFeDocument.FromFile(ADocumentType, AFilename);
end;

function TPanamahStream.ReadNFeDirectory(const ADirectory: string): IPanamahNFeDocumentList;
begin
  Result := TPanamahNFeDocumentList.Create;
  Result.LoadFromDirectory(ADirectory);
end;

function TPanamahStream.ReadNFe(const AFilename: string): IPanamahNFeDocument;
begin
  Result := ReadNFe(ndtDESCONHECIDO, AFilename);
end;

procedure TPanamahStream.Init;
begin
  Init(GetEnvironmentVariable('PANAMAH_AUTHORIZATION_TOKEN'), GetEnvironmentVariable('PANAMAH_ASSINANTE_ID'), GetEnvironmentVariable('PANAMAH_SECRET'));
end;

procedure TPanamahStream.SetOnBeforeBatchSent(AEvent: TPanamahBatchEvent);
begin
  FProcessor.OnBeforeBatchSent := AEvent;
end;

procedure TPanamahStream.SetOnBeforeDelete(
  AEvent: TPanamahCancelableModelEvent);
begin
  FProcessor.OnBeforeDelete := AEvent;
end;

procedure TPanamahStream.SetOnBeforeObjectAddedToBatch(AEvent: TPanamahModelEvent);
begin
  FProcessor.OnBeforeObjectAddedToBatch := AEvent;
end;

procedure TPanamahStream.SetOnBeforeOperationSent(AEvent: TPanamahOperationEvent);
begin
  FProcessor.OnBeforeOperationSent := AEvent;
end;

procedure TPanamahStream.SetOnBeforeSave(AEvent: TPanamahCancelableModelEvent);
begin
  FProcessor.OnBeforeSave := AEvent;
end;

procedure TPanamahStream.SetOnCurrentBatchExpired(AEvent: TPanamahBatchEvent);
begin
  FProcessor.OnCurrentBatchExpired := AEvent;
end;

procedure TPanamahStream.SetOnError(AEvent: TPanamahErrorEvent);
begin
  FProcessor.OnError := AEvent;
end;

procedure TPanamahStream.Save(AFormaPagamento: IPanamahFormaPagamento);
begin
  FProcessor.Save(AFormaPagamento);
end;

procedure TPanamahStream.Save(AEventoCaixa: IPanamahEventoCaixa);
begin
  FProcessor.Save(AEventoCaixa);
end;

procedure TPanamahStream.Save(AEstoqueMovimentacao: IPanamahEstoqueMovimentacao);
begin
  FProcessor.Save(AEstoqueMovimentacao);
end;

procedure TPanamahStream.Save(AGrupo: IPanamahGrupo);
begin
  FProcessor.Save(AGrupo);
end;

procedure TPanamahStream.Save(AFuncionario: IPanamahFuncionario);
begin
  FProcessor.Save(AFuncionario);
end;

procedure TPanamahStream.Save(AFornecedor: IPanamahFornecedor);
begin
  FProcessor.Save(AFornecedor);
end;

procedure TPanamahStream.Save(AAcesso: IPanamahAcesso);
begin
  FProcessor.Save(AAcesso);
end;

procedure TPanamahStream.Save(AEan: IPanamahEan);
begin
  FProcessor.Save(AEan);
end;

procedure TPanamahStream.Save(ACompra: IPanamahCompra);
begin
  FProcessor.Save(ACompra);
end;

procedure TPanamahStream.Save(ACliente: IPanamahCliente);
begin
  FProcessor.Save(ACliente);
end;

procedure TPanamahStream.Save(AHolding: IPanamahHolding);
begin
  FProcessor.Save(AHolding);
end;

procedure TPanamahStream.Save(ATituloReceber: IPanamahTituloReceber);
begin
  FProcessor.Save(ATituloReceber);
end;

procedure TPanamahStream.Save(ATituloPagar: IPanamahTituloPagar);
begin
  FProcessor.Save(ATituloPagar);
end;

procedure TPanamahStream.Save(ASubgrupo: IPanamahSubgrupo);
begin
  FProcessor.Save(ASubgrupo);
end;

procedure TPanamahStream.Save(AVenda: IPanamahVenda);
begin
  FProcessor.Save(AVenda);
end;

procedure TPanamahStream.Save(ANFeDocumentList: IPanamahNFeDocumentList);
var
  I: Integer;
begin
  for I := 0 to ANFeDocumentList.Count - 1 do
    Save(ANFeDocumentList[I]);
end;

procedure TPanamahStream.Save(ANFeDocument: IPanamahNFeDocument);
var
  I: Integer;
begin
  for I := 0 to ANFeDocument.Count - 1 do
    FProcessor.Save(ANFeDocument[I]);
end;

procedure TPanamahStream.Save(ATrocaFormaPagamento: IPanamahTrocaFormaPagamento);
begin
  FProcessor.Save(ATrocaFormaPagamento);
end;

procedure TPanamahStream.Save(ATrocaDevolucao: IPanamahTrocaDevolucao);
begin
  FProcessor.Save(ATrocaDevolucao);
end;

procedure TPanamahStream.Save(AMeta: IPanamahMeta);
begin
  FProcessor.Save(AMeta);
end;

procedure TPanamahStream.Save(ALoja: IPanamahLoja);
begin
  FProcessor.Save(ALoja);
end;

procedure TPanamahStream.Save(ALocalEstoque: IPanamahLocalEstoque);
begin
  FProcessor.Save(ALocalEstoque);
end;

procedure TPanamahStream.Save(ASecao: IPanamahSecao);
begin
  FProcessor.Save(ASecao);
end;

procedure TPanamahStream.Save(ARevenda: IPanamahRevenda);
begin
  FProcessor.Save(ARevenda);
end;

procedure TPanamahStream.Save(AProduto: IPanamahProduto);
begin
  FProcessor.Save(AProduto);
end;

procedure TPanamahStream.Delete(AFormaPagamento: IPanamahFormaPagamento);
begin
  FProcessor.Delete(AFormaPagamento);
end;

procedure TPanamahStream.Delete(AEventoCaixa: IPanamahEventoCaixa);
begin
  FProcessor.Delete(AEventoCaixa);
end;

procedure TPanamahStream.Delete(AEstoqueMovimentacao: IPanamahEstoqueMovimentacao);
begin
  FProcessor.Delete(AEstoqueMovimentacao);
end;

procedure TPanamahStream.Delete(AGrupo: IPanamahGrupo);
begin
  FProcessor.Delete(AGrupo);
end;

procedure TPanamahStream.Delete(AFuncionario: IPanamahFuncionario);
begin
  FProcessor.Delete(AFuncionario);
end;

procedure TPanamahStream.Delete(AFornecedor: IPanamahFornecedor);
begin
  FProcessor.Delete(AFornecedor);
end;

procedure TPanamahStream.Delete(AAcesso: IPanamahAcesso);
begin
  FProcessor.Delete(AAcesso);
end;

procedure TPanamahStream.Delete(AEan: IPanamahEan);
begin
  FProcessor.Delete(AEan);
end;

procedure TPanamahStream.Delete(ACompra: IPanamahCompra);
begin
  FProcessor.Delete(ACompra);
end;

procedure TPanamahStream.Delete(ACliente: IPanamahCliente);
begin
  FProcessor.Delete(ACliente);
end;

procedure TPanamahStream.Delete(AHolding: IPanamahHolding);
begin
  FProcessor.Delete(AHolding);
end;

procedure TPanamahStream.Delete(ATituloReceber: IPanamahTituloReceber);
begin
  FProcessor.Delete(ATituloReceber);
end;

procedure TPanamahStream.Delete(ATituloPagar: IPanamahTituloPagar);
begin
  FProcessor.Delete(ATituloPagar);
end;

procedure TPanamahStream.Delete(ASubgrupo: IPanamahSubgrupo);
begin
  FProcessor.Delete(ASubgrupo);
end;

procedure TPanamahStream.Delete(AVenda: IPanamahVenda);
begin
  FProcessor.Delete(AVenda);
end;

procedure TPanamahStream.Delete(ATrocaFormaPagamento: IPanamahTrocaFormaPagamento);
begin
  FProcessor.Delete(ATrocaFormaPagamento);
end;

procedure TPanamahStream.Delete(ATrocaDevolucao: IPanamahTrocaDevolucao);
begin
  FProcessor.Delete(ATrocaDevolucao);
end;

procedure TPanamahStream.Delete(AMeta: IPanamahMeta);
begin
  FProcessor.Delete(AMeta);
end;

procedure TPanamahStream.Delete(ALoja: IPanamahLoja);
begin
  FProcessor.Delete(ALoja);
end;

procedure TPanamahStream.Delete(ALocalEstoque: IPanamahLocalEstoque);
begin
  FProcessor.Delete(ALocalEstoque);
end;

procedure TPanamahStream.Delete(ASecao: IPanamahSecao);
begin
  FProcessor.Delete(ASecao);
end;

procedure TPanamahStream.Delete(ARevenda: IPanamahRevenda);
begin
  FProcessor.Delete(ARevenda);
end;

procedure TPanamahStream.Delete(AProduto: IPanamahProduto);
begin
  FProcessor.Delete(AProduto);
end;

constructor TPanamahStream.Create;
begin
  inherited;
  FProcessor := TPanamahBatchProcessor.Create;
end;

destructor TPanamahStream.Destroy;
begin
  FProcessor.Stop;
  FProcessor.Free;
  inherited;
end;

procedure TPanamahStream.Flush;
begin
  FProcessor.Flush;
end;

class procedure TPanamahStream.Free;
begin
  if Assigned(_PanamahStreamInstance) then
    _PanamahStreamInstance.Destroy;
end;

class function TPanamahStream.GetInstance: TPanamahStream;
begin
  if not Assigned(_PanamahStreamInstance) then
    _PanamahStreamInstance := TPanamahStream.Create;
  Result := _PanamahStreamInstance;
end;

function TPanamahStream.GetOnBeforeBatchSent: TPanamahBatchEvent;
begin
  Result := FProcessor.OnBeforeBatchSent;
end;

function TPanamahStream.GetOnBeforeDelete: TPanamahCancelableModelEvent;
begin
  Result := FProcessor.OnBeforeDelete;
end;

function TPanamahStream.GetOnBeforeObjectAddedToBatch: TPanamahModelEvent;
begin
  Result := FProcessor.OnBeforeObjectAddedToBatch;
end;

function TPanamahStream.GetOnBeforeOperationtSent: TPanamahOperationEvent;
begin
  Result := FProcessor.OnBeforeOperationSent;
end;

function TPanamahStream.GetOnBeforeSave: TPanamahCancelableModelEvent;
begin
  Result := FProcessor.OnBeforeSave;
end;

function TPanamahStream.GetOnCurrentBatchExpired: TPanamahBatchEvent;
begin
  Result := FProcessor.OnCurrentBatchExpired;
end;

function TPanamahStream.GetOnError: TPanamahErrorEvent;
begin
  Result := FProcessor.OnError;
end;

function TPanamahStream.GetPendingResources: IPanamahPendingResourcesList;
begin
  Result := FProcessor.GetPendingResources;
end;

{ TPanamahSDKConfig }

constructor TPanamahStreamConfig.Create;
begin
  inherited Create;
  FBatchTTL := 5 * 60 * 1000;
  FBatchMaxSize := 5 * 1024;
  FBatchMaxCount := 500;
  FBaseDirectory := GetCurrentDir + '\.panamah';
end;

function TPanamahStreamConfig.GetAssinanteId: string;
begin
  Result := FAssinanteId;
end;

function TPanamahStreamConfig.GetAuthorizationToken: string;
begin
  Result := FAuthorizationToken;
end;

function TPanamahStreamConfig.GetBaseDirectory: string;
begin
  Result := FBaseDirectory;
end;

function TPanamahStreamConfig.GetBatchMaxCount: Integer;
begin
  Result := FBatchMaxCount;
end;

function TPanamahStreamConfig.GetBatchMaxSize: Integer;
begin
  Result := FBatchMaxSize;
end;

function TPanamahStreamConfig.GetBatchTTL: Integer;
begin
  Result := FBatchTTL;
end;

function TPanamahStreamConfig.GetSecret: string;
begin
  Result := FSecret;
end;

procedure TPanamahStreamConfig.SetBaseDirectory(const ABaseDirectory: string);
begin
  FBaseDirectory := ABaseDirectory;
end;

procedure TPanamahStreamConfig.SetSecret(const ASecret: string);
begin
  FSecret := ASecret;
end;

procedure TPanamahStreamConfig.SetAssinanteId(const AAssinanteId: string);
begin
  FAssinanteId := AAssinanteId;
end;

procedure TPanamahStreamConfig.SetAuthorizationToken(const AAuthorizationToken: string);
begin
  FAuthorizationToken := AAuthorizationToken;
end;

{ TPanamahAdminConfig }

constructor TPanamahAdminConfig.Create;
begin
  inherited Create;
end;

function TPanamahAdminConfig.GetAuthorizationToken: string;
begin
  Result := FAuthorizationToken;
end;

procedure TPanamahAdminConfig.SetAuthorizationToken(const AAuthorizationToken: string);
begin
  FAuthorizationToken := AAuthorizationToken;
end;

{ TPanamahAdmin }

constructor TPanamahAdmin.Create;
begin
  inherited Create;
end;

class procedure TPanamahAdmin.Free;
begin
  if Assigned(_PanamahAdminInstance) then
    FreeAndNil(_PanamahAdminInstance);
end;

function TPanamahAdmin.GetAssinante(const AAssinanteId: string): IPanamahAssinante;
var
  Response: IPanamahResponse;
begin
  Response := FClient.Get(Format('/admin/assinantes/%s', [AAssinanteId]), nil, nil);
  case Response.Status of
    200: Result := TPanamahAssinante.FromJSON(Response.Content);
    404: raise EPanamahSDKNotFoundException.Create('Assinante n�o encontrado');
    else
      raise EPanamahSDKUnknownException.Create(Response.Content);
  end;
end;

function TPanamahAdmin.SaveAssinante(AAssinante: IPanamahAssinante): Boolean;
var
  Response: IPanamahResponse;
begin
  Response := FClient.Post('/admin/assinantes', AAssinante.SerializeToJSON, nil);
  case Response.Status of
    201: Result := True;
    422: raise EPanamahSDKUnprocessableEntityException.Create(Response.Content);
    400: raise EPanamahSDKBadRequestException.Create(Response.Content);
    409: raise EPanamahSDKConflictException.Create(Response.Content);
    else
      Result := False;
  end;
end;

class function TPanamahAdmin.GetInstance: TPanamahAdmin;
begin
  if not Assigned(_PanamahAdminInstance) then
    _PanamahAdminInstance := TPanamahAdmin.Create;
  Result := _PanamahAdminInstance;
end;

procedure TPanamahAdmin.Init(const AAuthorizationToken: string);
var
  Config: IPanamahAdminConfig;
begin
  Config := TPanamahAdminConfig.Create;
  Config.AuthorizationToken := AAuthorizationToken;
  Init(Config);
end;

procedure TPanamahAdmin.Init(AConfig: IPanamahAdminConfig);
begin
  FConfig := AConfig;
  FClient := TPanamahAdminClient.Create(API_BASE_URL, FConfig.AuthorizationToken);
end;

initialization
  TPanamahStream.GetInstance;
  TPanamahAdmin.GetInstance;
  
finalization
  TPanamahStream.Free;
  TPanamahAdmin.Free;

end.
