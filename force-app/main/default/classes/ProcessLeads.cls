/* 
Objetivo: Processar leads no Salesforce e atualizar informações com base em consulta à API de CNPJ.
Descrição: Esta classe implementa a interface Queueable e é usada para processar leads após inserção, chamando o método 'get' na classe CNPJ_Lead.
           A principal funcionalidade é terceirizar a função para evitar erros de callout nos acionadores.
Criado por: contato.andreluna@gmail.om
*/

public class ProcessLeads implements Queueable {
    List<Id> leadIds;

    public ProcessLeads(List<Id> leadIds) {
        this.leadIds = leadIds;
    }

    public void execute(QueueableContext context) {
        for (Id leadId : leadIds) {
            Lead lead = [SELECT TXT_CNPJ__c FROM Lead WHERE Id = :leadId];
            CNPJ_Lead.get(lead.TXT_CNPJ__c, leadId);
        }
    }
}