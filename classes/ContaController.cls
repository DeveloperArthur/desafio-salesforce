@RestResource(urlMapping='/Conta/')
global with sharing class ContaController {
    
    @HttpPut @AuraEnabled
    global static String upsertConta(String id, String nome, 
        String idPais, Boolean podeEnviarEmail, String email){

        Account conta = new Account(Id = id, Name = nome, Pais__c = idPais);
        upsert conta;

        if(podeEnviarEmail) System.enqueueJob(new EmailSalesforceClient(email));

        return JSON.serialize(new ContaDto(conta));
    }
}