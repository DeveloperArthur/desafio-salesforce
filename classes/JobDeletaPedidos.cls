global class JobDeletaPedidos implements Schedulable {
    global void execute(SchedulableContext ctx){
        Database.executeBatch(new BatchDeletaPedidos());
    }
}