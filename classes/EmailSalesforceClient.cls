public class EmailSalesforceClient implements Queueable {
    private String destinatario;
    private String TITULO = 'Desafio Salesforce - Envio de Email';
    private String CORPO = 'Você recebeu o email!';
    private String POLITICA = 'FILTER';

    public EmailSalesforceClient(String destinatario){
        this.destinatario = destinatario;
    }

    public void execute(QueueableContext context){
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new String[] { this.destinatario };
		message.optOutPolicy = POLITICA;
        message.subject = TITULO;
        message.setPlainTextBody(CORPO);
        
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
        
		Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
    }
}