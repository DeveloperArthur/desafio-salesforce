@isTest
private class TestPaisController {
    @isTest 
    private static void deveConverterListaDePaisEmDto(){
        criaPaises();

        String jsonPaises = PaisController.buscaPaises();
        System.assert(jsonPaises.contains('Brasil'));
        System.assert(jsonPaises.contains('Estados Unidos'));
    }

    private static void criaPaises(){
        Pais__c pais = new Pais__c();
        pais.Name = 'Brasil';
        pais.Sigla__c = 'BR';
        pais.Moeda__c = 'BRL';
        pais.Idioma__c = 'Português';
        insert pais;

        Pais__c pais2 = new Pais__c();
        pais2.Name = 'Estados Unidos';
        pais2.Sigla__c = 'US';
        pais2.Moeda__c = 'USD';
        pais2.Idioma__c = 'Inglês';
        insert pais2;
    }
}