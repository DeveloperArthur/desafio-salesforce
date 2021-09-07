public with sharing class PaisDto {
    private String id;
    private String nome;
    
    public PaisDto(Pais__c pais) {
        this.id = pais.Id;
        this.nome = pais.Name;
    }

    public static List<PaisDto> converteLista(List<Pais__c> paises){
        List<PaisDto> paisesDto = new List<PaisDto>();
        for(Pais__c pais : paises) paisesDto.add(new PaisDto(pais));
        return paisesDto;
    }

}