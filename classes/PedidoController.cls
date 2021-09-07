@RestResource(urlMapping='/Pedido/')
global with sharing class PedidoController {

    @HttpPost
    global static String salvaPedido(String idConta, String nome, String dataDeInicio){
        Order pedido = pedidoFactory(idConta, nome, dataDeInicio);
        insert pedido;
        return JSON.serialize(new PedidoDto(pedido));
    }

    private static Order pedidoFactory(String idConta, String nome, String dataDeInicio){
        return new Order(
            AccountId = idConta,
            Name = nome, 
            EffectiveDate = Date.valueOf(dataDeInicio),
            Status = 'Draft'
        );
    }
}