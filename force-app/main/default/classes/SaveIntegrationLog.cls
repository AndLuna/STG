/* 
Objetivo: Salvar logs de integração no Salesforce.
Descrição: Esta classe implementa a interface Queueable e é utilizada para inserir registros de log de integração no Salesforce.
Criado por: contato.andreluna@gmail.om
*/
public class SaveIntegrationLog implements Queueable {
    IntegrationLogs__c logToSave;

    public SaveIntegrationLog(IntegrationLogs__c log) {
        this.logToSave = log;
    }

    public void execute(QueueableContext context) {
        insert logToSave;
    }
}