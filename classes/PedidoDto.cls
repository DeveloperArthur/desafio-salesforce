public with sharing class PedidoDto {
    public String id {get;set;}
    public String idConta {get;set;}
    public String nome {get;set;}
    private String dataDeInicio;

    public PedidoDto(Order pedido) {
        this.id = pedido.Id;
        this.idConta = pedido.AccountId;
        this.nome = pedido.Name;
        this.dataDeInicio = String.valueOf(pedido.EffectiveDate);
    }
}