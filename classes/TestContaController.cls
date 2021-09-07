@isTest
private class TestContaController {
    
    @isTest 
    private static void deveInserirConta() {
        String idPais = setup();

        String contaJson = ContaController.upsertConta(null, 'Arthur', idPais, false, null);

        ContaDto contaDto = converteJsonEmContaDto(contaJson);
        System.assert(contaDto.Id != null);
        System.assertEquals(contaDto.nome, 'Arthur');
    }

    private static String setup(){
        RestRequest request = new RestRequest();
        request.requestUri = 'multiedro-1d-dev-ed.my.salesforce.com/services/apexrest/Conta/';
        request.httpMethod = 'PUT';
        RestContext.request = request;

        Pais__c pais = new Pais__c();
        pais.Name = 'Teste';
        pais.Sigla__c = 'SI';
        pais.Moeda__c = 'GLA';
        pais.Idioma__c = 'idioma';
        insert pais;
        return String.valueOf(pais.Id);
    }

    private static ContaDto converteJsonEmContaDto(String jsonConta){
        return (ContaDto) JSON.deserialize(jsonConta, ContaDto.class);
    }

    @isTest 
    private static void deveAtualizarContaExistente() {
        String idPais = setup();
        String idConta = criaConta(idPais);

        String contaJson = ContaController.upsertConta(idConta, 'Arthur Santos', idPais, false, null);

        ContaDto contaDto = converteJsonEmContaDto(contaJson);
        System.assertEquals(contaDto.id, idConta);
        System.assertEquals(contaDto.nome, 'Arthur Santos');
    }

    private static String criaConta(String idPais){
        Account conta = new Account();
        conta.Name = 'Arthur Almeida';
        conta.Pais__c = idPais;
        insert conta;
        return String.valueOf(conta.Id);
    }
}