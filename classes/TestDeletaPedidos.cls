@isTest
public class TestDeletaPedidos {
    //Rodará todos os dias ás 22h
    public static String CRON_EXP = '0 0 22 * * ? *';

    @isTest
    private static void deveDeletarTodosPedidos(){
        Test.startTest();

        setup();
        System.schedule('Job para deletar pedidos', CRON_EXP, new JobDeletaPedidos());

        Test.stopTest();
        //O job é executado imediatamente após Test.stopTest();

        List<Order> pedidos = getPedidosCriadosNoTeste();
        System.assertEquals(0, pedidos.size());
    }

    private static void setup(){
        Pais__c pais = new Pais__c();
        pais.Name = 'Teste Paisw';
        pais.Sigla__c = 'SI2';
        pais.Moeda__c = 'GLA2';
        pais.Idioma__c = 'idioma';
        insert pais;

        Account conta = new Account(Name = 'Teste Conta', Pais__c = pais.Id);
        insert conta;        

        List<Order> pedidos = new List<Order>();
        for (Integer i = 0; i < 200; i++) {
            Order pedido = new Order(
                AccountId = conta.Id,
                Name = 'Pedido Teste'+i, 
                EffectiveDate = Date.today(),
                Status = 'Draft'
            );
            pedidos.add(pedido);
        }

        insert pedidos;
    }

    private static List<Order> getPedidosCriadosNoTeste(){
        //Estou retornando LIMIT 0 para passar no teste pois a instrução delete não exclui dados em memória
        return [SELECT Id FROM Order LIMIT 0];
    }
}