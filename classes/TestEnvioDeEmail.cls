@isTest
public class TestEnvioDeEmail {

    @isTest
    private static void test(){
        Test.startTest();

        try {
            System.enqueueJob(new EmailSalesforceClient('ellapinto@yahoo.fr'));
            System.assert(true);
        } catch (Exception e) {
            System.assert(false);
        }

        Test.stopTest();
    }
    
}