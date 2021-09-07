public class BatchDeletaPedidos implements Database.Batchable<SObject> {
    private static final String NUMERO_DE_MESES = '3';

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('Select Id From Order Where LastModifiedDate >= LAST_N_MONTHS:'+NUMERO_DE_MESES);
    }
    
    public void execute(Database.BatchableContext bc, List<Order> scope){
        Database.delete(scope, false);
    }
    
    public void finish(Database.BatchableContext bc){
        System.debug('Concluido!');
    }
}