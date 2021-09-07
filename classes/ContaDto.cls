public with sharing class ContaDto {
    public String id {get;set;}
    public String nome {get;set;}
    private String idPais;

    public ContaDto(Account conta) {
        this.id = conta.Id;
        this.nome = conta.Name;
        this.idPais = conta.Pais__c;
    }
}