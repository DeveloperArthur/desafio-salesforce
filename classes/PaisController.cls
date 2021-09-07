public with sharing class PaisController {
    @AuraEnabled
    public static String buscaPaises(){
        List<Pais__c> paises = [Select Id, Name From Pais__c];
        return JSON.serialize(PaisDto.converteLista(paises));
    }
}