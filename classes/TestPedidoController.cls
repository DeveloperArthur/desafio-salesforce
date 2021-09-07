@isTest
private class TestPedidoController {

    @isTest 
    private static void deveInserirPedido() {
        String idConta = setup();

        String dataDeInicio = String.valueOf(Date.today() + 10);
        String pedidoJson = PedidoController.salvaPedido(idConta, 'Pedido Teste', dataDeInicio);

        PedidoDto pedidoDto = converteJsonEmPedidoDto(pedidoJson);

        System.assert(pedidoDto.Id != null);
        System.assertEquals(pedidoDto.nome, 'Pedido Teste');
    }

    private static String setup(){
        RestRequest request = new RestRequest();
        request.requestUri = 'multiedro-1d-dev-ed.my.salesforce.com/services/apexrest/Pedido/';
        request.httpMethod = 'POST';
        RestContext.request = request;

        Pais__c pais = new Pais__c();
        pais.Name = 'Teste Pais';
        pais.Sigla__c = 'SI';
        pais.Moeda__c = 'GLA';
        pais.Idioma__c = 'idioma';
        insert pais;

        Account conta = new Account(Name = 'Teste Conta', Pais__c = pais.Id);
        insert conta;

        return String.valueOf(conta.Id);
    }

    private static PedidoDto converteJsonEmPedidoDto(String jsonPedido){
        return (PedidoDto) JSON.deserialize(jsonPedido, PedidoDto.class);
    }
}