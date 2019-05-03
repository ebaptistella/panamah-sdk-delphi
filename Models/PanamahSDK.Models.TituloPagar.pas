{$M+}
unit PanamahSDK.Models.TituloPagar;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.JsonUtils, PanamahSDK.Enums, Variants, uLkJSON;

type
  
  IPanamahTituloPagarPagamento = interface(IModel)
    ['{0F20B6A2-6DAE-11E9-88EA-EB5361679635}']
    function GetDataHora: TDateTime;
    function GetValor: Double;
    procedure SetDataHora(const ADataHora: TDateTime);
    procedure SetValor(const AValor: Double);
    property DataHora: TDateTime read GetDataHora write SetDataHora;
    property Valor: Double read GetValor write SetValor;
  end;
  
  IPanamahTituloPagarPagamentoList = interface(IJSONSerializable)
    ['{0F20B6A3-6DAE-11E9-88EA-EB5361679635}']
    function GetItem(AIndex: Integer): IPanamahTituloPagarPagamento;
    procedure SetItem(AIndex: Integer; const Value: IPanamahTituloPagarPagamento);
    procedure Add(const AItem: IPanamahTituloPagarPagamento);
    procedure Clear;
    function Count: Integer;
    property Items[AIndex: Integer]: IPanamahTituloPagarPagamento read GetItem write SetItem; default;
  end;
  
  IPanamahTituloPagar = interface(IModel)
    ['{0F20B694-6DAE-11E9-88EA-EB5361679635}']
    function GetId: string;
    function GetLojaId: string;
    function GetFornecedorId: string;
    function GetDocumento: string;
    function GetValorNominal: Double;
    function GetValorJuros: Double;
    function GetValorMulta: Double;
    function GetValorDevido: Double;
    function GetValorPago: Double;
    function GetDataEmissao: TDateTime;
    function GetDataVencimento: TDateTime;
    function GetPagamentos: IPanamahTituloPagarPagamentoList;
    procedure SetId(const AId: string);
    procedure SetLojaId(const ALojaId: string);
    procedure SetFornecedorId(const AFornecedorId: string);
    procedure SetDocumento(const ADocumento: string);
    procedure SetValorNominal(const AValorNominal: Double);
    procedure SetValorJuros(const AValorJuros: Double);
    procedure SetValorMulta(const AValorMulta: Double);
    procedure SetValorDevido(const AValorDevido: Double);
    procedure SetValorPago(const AValorPago: Double);
    procedure SetDataEmissao(const ADataEmissao: TDateTime);
    procedure SetDataVencimento(const ADataVencimento: TDateTime);
    procedure SetPagamentos(const APagamentos: IPanamahTituloPagarPagamentoList);
    property Id: string read GetId write SetId;
    property LojaId: string read GetLojaId write SetLojaId;
    property FornecedorId: string read GetFornecedorId write SetFornecedorId;
    property Documento: string read GetDocumento write SetDocumento;
    property ValorNominal: Double read GetValorNominal write SetValorNominal;
    property ValorJuros: Double read GetValorJuros write SetValorJuros;
    property ValorMulta: Double read GetValorMulta write SetValorMulta;
    property ValorDevido: Double read GetValorDevido write SetValorDevido;
    property ValorPago: Double read GetValorPago write SetValorPago;
    property DataEmissao: TDateTime read GetDataEmissao write SetDataEmissao;
    property DataVencimento: TDateTime read GetDataVencimento write SetDataVencimento;
    property Pagamentos: IPanamahTituloPagarPagamentoList read GetPagamentos write SetPagamentos;
  end;
  
  IPanamahTituloPagarList = interface(IJSONSerializable)
    ['{0F20B695-6DAE-11E9-88EA-EB5361679635}']
    function GetItem(AIndex: Integer): IPanamahTituloPagar;
    procedure SetItem(AIndex: Integer; const Value: IPanamahTituloPagar);
    procedure Add(const AItem: IPanamahTituloPagar);
    procedure Clear;
    function Count: Integer;
    property Items[AIndex: Integer]: IPanamahTituloPagar read GetItem write SetItem; default;
  end;
  
  TPanamahTituloPagarPagamento = class(TInterfacedObject, IPanamahTituloPagarPagamento)
  private
    FDataHora: TDateTime;
    FValor: Double;
    function GetDataHora: TDateTime;
    function GetValor: Double;
    procedure SetDataHora(const ADataHora: TDateTime);
    procedure SetValor(const AValor: Double);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahTituloPagarPagamento;
  published
    property DataHora: TDateTime read GetDataHora write SetDataHora;
    property Valor: Double read GetValor write SetValor;
  end;

  TPanamahTituloPagarPagamentoList = class(TInterfacedObject, IPanamahTituloPagarPagamentoList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahTituloPagarPagamento;
    procedure SetItem(AIndex: Integer; const Value: IPanamahTituloPagarPagamento);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahTituloPagarPagamentoList;
    constructor Create;
    procedure Add(const AItem: IPanamahTituloPagarPagamento);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahTituloPagarPagamento read GetItem write SetItem; default;
  end;
  
  TPanamahTituloPagar = class(TInterfacedObject, IPanamahTituloPagar)
  private
    FId: string;
    FLojaId: string;
    FFornecedorId: string;
    FDocumento: string;
    FValorNominal: Double;
    FValorJuros: Double;
    FValorMulta: Double;
    FValorDevido: Double;
    FValorPago: Double;
    FDataEmissao: TDateTime;
    FDataVencimento: TDateTime;
    FPagamentos: IPanamahTituloPagarPagamentoList;
    function GetId: string;
    function GetLojaId: string;
    function GetFornecedorId: string;
    function GetDocumento: string;
    function GetValorNominal: Double;
    function GetValorJuros: Double;
    function GetValorMulta: Double;
    function GetValorDevido: Double;
    function GetValorPago: Double;
    function GetDataEmissao: TDateTime;
    function GetDataVencimento: TDateTime;
    function GetPagamentos: IPanamahTituloPagarPagamentoList;
    procedure SetId(const AId: string);
    procedure SetLojaId(const ALojaId: string);
    procedure SetFornecedorId(const AFornecedorId: string);
    procedure SetDocumento(const ADocumento: string);
    procedure SetValorNominal(const AValorNominal: Double);
    procedure SetValorJuros(const AValorJuros: Double);
    procedure SetValorMulta(const AValorMulta: Double);
    procedure SetValorDevido(const AValorDevido: Double);
    procedure SetValorPago(const AValorPago: Double);
    procedure SetDataEmissao(const ADataEmissao: TDateTime);
    procedure SetDataVencimento(const ADataVencimento: TDateTime);
    procedure SetPagamentos(const APagamentos: IPanamahTituloPagarPagamentoList);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahTituloPagar;
  published
    property Id: string read GetId write SetId;
    property LojaId: string read GetLojaId write SetLojaId;
    property FornecedorId: string read GetFornecedorId write SetFornecedorId;
    property Documento: string read GetDocumento write SetDocumento;
    property ValorNominal: Double read GetValorNominal write SetValorNominal;
    property ValorJuros: Double read GetValorJuros write SetValorJuros;
    property ValorMulta: Double read GetValorMulta write SetValorMulta;
    property ValorDevido: Double read GetValorDevido write SetValorDevido;
    property ValorPago: Double read GetValorPago write SetValorPago;
    property DataEmissao: TDateTime read GetDataEmissao write SetDataEmissao;
    property DataVencimento: TDateTime read GetDataVencimento write SetDataVencimento;
    property Pagamentos: IPanamahTituloPagarPagamentoList read GetPagamentos write SetPagamentos;
  end;

  TPanamahTituloPagarList = class(TInterfacedObject, IPanamahTituloPagarList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahTituloPagar;
    procedure SetItem(AIndex: Integer; const Value: IPanamahTituloPagar);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahTituloPagarList;
    constructor Create;
    procedure Add(const AItem: IPanamahTituloPagar);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahTituloPagar read GetItem write SetItem; default;
  end;
  
implementation

{ TPanamahTituloPagarPagamento }

function TPanamahTituloPagarPagamento.GetDataHora: TDateTime;
begin
  Result := FDataHora;
end;

procedure TPanamahTituloPagarPagamento.SetDataHora(const ADataHora: TDateTime);
begin
  FDataHora := ADataHora;
end;

function TPanamahTituloPagarPagamento.GetValor: Double;
begin
  Result := FValor;
end;

procedure TPanamahTituloPagarPagamento.SetValor(const AValor: Double);
begin
  FValor := AValor;
end;

procedure TPanamahTituloPagarPagamento.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FDataHora := GetFieldValueAsDatetime(JSONObject, 'dataHora');
    FValor := GetFieldValueAsDouble(JSONObject, 'valor');
  finally
    JSONObject.Free;
  end;
end;

function TPanamahTituloPagarPagamento.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'dataHora', FDataHora);    
    SetFieldValue(JSONObject, 'valor', FValor);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahTituloPagarPagamento.FromJSON(const AJSON: string): IPanamahTituloPagarPagamento;
begin
  Result := TPanamahTituloPagarPagamento.Create;
  Result.DeserializeFromJSON(AJSON);
end;

{ TPanamahTituloPagarPagamentoList }

constructor TPanamahTituloPagarPagamentoList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahTituloPagarPagamentoList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

class function TPanamahTituloPagarPagamentoList.FromJSON(const AJSON: string): IPanamahTituloPagarPagamentoList;
begin
  Result := TPanamahTituloPagarPagamentoList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

procedure TPanamahTituloPagarPagamentoList.Add(const AItem: IPanamahTituloPagarPagamento);
begin
  FList.Add(AItem);
end;

procedure TPanamahTituloPagarPagamentoList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahTituloPagarPagamento;
begin
  Item := TPanamahTituloPagarPagamento.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahTituloPagarPagamentoList.Clear;
begin
  FList.Clear;
end;

function TPanamahTituloPagarPagamentoList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahTituloPagarPagamentoList.GetItem(AIndex: Integer): IPanamahTituloPagarPagamento;
begin
  Result := FList.Items[AIndex] as IPanamahTituloPagarPagamento;
end;

procedure TPanamahTituloPagarPagamentoList.SetItem(AIndex: Integer;
  const Value: IPanamahTituloPagarPagamento);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahTituloPagarPagamentoList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahTituloPagarPagamentoList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahTituloPagarPagamento).SerializeToJSON));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

{ TPanamahTituloPagar }

function TPanamahTituloPagar.GetId: string;
begin
  Result := FId;
end;

procedure TPanamahTituloPagar.SetId(const AId: string);
begin
  FId := AId;
end;

function TPanamahTituloPagar.GetLojaId: string;
begin
  Result := FLojaId;
end;

procedure TPanamahTituloPagar.SetLojaId(const ALojaId: string);
begin
  FLojaId := ALojaId;
end;

function TPanamahTituloPagar.GetFornecedorId: string;
begin
  Result := FFornecedorId;
end;

procedure TPanamahTituloPagar.SetFornecedorId(const AFornecedorId: string);
begin
  FFornecedorId := AFornecedorId;
end;

function TPanamahTituloPagar.GetDocumento: string;
begin
  Result := FDocumento;
end;

procedure TPanamahTituloPagar.SetDocumento(const ADocumento: string);
begin
  FDocumento := ADocumento;
end;

function TPanamahTituloPagar.GetValorNominal: Double;
begin
  Result := FValorNominal;
end;

procedure TPanamahTituloPagar.SetValorNominal(const AValorNominal: Double);
begin
  FValorNominal := AValorNominal;
end;

function TPanamahTituloPagar.GetValorJuros: Double;
begin
  Result := FValorJuros;
end;

procedure TPanamahTituloPagar.SetValorJuros(const AValorJuros: Double);
begin
  FValorJuros := AValorJuros;
end;

function TPanamahTituloPagar.GetValorMulta: Double;
begin
  Result := FValorMulta;
end;

procedure TPanamahTituloPagar.SetValorMulta(const AValorMulta: Double);
begin
  FValorMulta := AValorMulta;
end;

function TPanamahTituloPagar.GetValorDevido: Double;
begin
  Result := FValorDevido;
end;

procedure TPanamahTituloPagar.SetValorDevido(const AValorDevido: Double);
begin
  FValorDevido := AValorDevido;
end;

function TPanamahTituloPagar.GetValorPago: Double;
begin
  Result := FValorPago;
end;

procedure TPanamahTituloPagar.SetValorPago(const AValorPago: Double);
begin
  FValorPago := AValorPago;
end;

function TPanamahTituloPagar.GetDataEmissao: TDateTime;
begin
  Result := FDataEmissao;
end;

procedure TPanamahTituloPagar.SetDataEmissao(const ADataEmissao: TDateTime);
begin
  FDataEmissao := ADataEmissao;
end;

function TPanamahTituloPagar.GetDataVencimento: TDateTime;
begin
  Result := FDataVencimento;
end;

procedure TPanamahTituloPagar.SetDataVencimento(const ADataVencimento: TDateTime);
begin
  FDataVencimento := ADataVencimento;
end;

function TPanamahTituloPagar.GetPagamentos: IPanamahTituloPagarPagamentoList;
begin
  Result := FPagamentos;
end;

procedure TPanamahTituloPagar.SetPagamentos(const APagamentos: IPanamahTituloPagarPagamentoList);
begin
  FPagamentos := APagamentos;
end;

procedure TPanamahTituloPagar.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FId := GetFieldValueAsString(JSONObject, 'id');
    FLojaId := GetFieldValueAsString(JSONObject, 'lojaId');
    FFornecedorId := GetFieldValueAsString(JSONObject, 'fornecedorId');
    FDocumento := GetFieldValueAsString(JSONObject, 'documento');
    FValorNominal := GetFieldValueAsDouble(JSONObject, 'valorNominal');
    FValorJuros := GetFieldValueAsDouble(JSONObject, 'valorJuros');
    FValorMulta := GetFieldValueAsDouble(JSONObject, 'valorMulta');
    FValorDevido := GetFieldValueAsDouble(JSONObject, 'valorDevido');
    FValorPago := GetFieldValueAsDouble(JSONObject, 'valorPago');
    FDataEmissao := GetFieldValueAsDatetime(JSONObject, 'dataEmissao');
    FDataVencimento := GetFieldValueAsDatetime(JSONObject, 'dataVencimento');
    if JSONObject.Field['pagamentos'] is TlkJSONlist then
      FPagamentos := TPanamahTituloPagarPagamentoList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['pagamentos']));
  finally
    JSONObject.Free;
  end;
end;

function TPanamahTituloPagar.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'id', FId);    
    SetFieldValue(JSONObject, 'lojaId', FLojaId);    
    SetFieldValue(JSONObject, 'fornecedorId', FFornecedorId);    
    SetFieldValue(JSONObject, 'documento', FDocumento);    
    SetFieldValue(JSONObject, 'valorNominal', FValorNominal);    
    SetFieldValue(JSONObject, 'valorJuros', FValorJuros);    
    SetFieldValue(JSONObject, 'valorMulta', FValorMulta);    
    SetFieldValue(JSONObject, 'valorDevido', FValorDevido);    
    SetFieldValue(JSONObject, 'valorPago', FValorPago);    
    SetFieldValue(JSONObject, 'dataEmissao', FDataEmissao);    
    SetFieldValue(JSONObject, 'dataVencimento', FDataVencimento);    
    SetFieldValue(JSONObject, 'pagamentos', FPagamentos);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahTituloPagar.FromJSON(const AJSON: string): IPanamahTituloPagar;
begin
  Result := TPanamahTituloPagar.Create;
  Result.DeserializeFromJSON(AJSON);
end;

{ TPanamahTituloPagarList }

constructor TPanamahTituloPagarList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahTituloPagarList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

class function TPanamahTituloPagarList.FromJSON(const AJSON: string): IPanamahTituloPagarList;
begin
  Result := TPanamahTituloPagarList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

procedure TPanamahTituloPagarList.Add(const AItem: IPanamahTituloPagar);
begin
  FList.Add(AItem);
end;

procedure TPanamahTituloPagarList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahTituloPagar;
begin
  Item := TPanamahTituloPagar.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahTituloPagarList.Clear;
begin
  FList.Clear;
end;

function TPanamahTituloPagarList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahTituloPagarList.GetItem(AIndex: Integer): IPanamahTituloPagar;
begin
  Result := FList.Items[AIndex] as IPanamahTituloPagar;
end;

procedure TPanamahTituloPagarList.SetItem(AIndex: Integer;
  const Value: IPanamahTituloPagar);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahTituloPagarList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahTituloPagarList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahTituloPagar).SerializeToJSON));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

end.