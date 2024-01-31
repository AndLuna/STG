public class UpdateLeadSituacaoCadastral implements Queueable {
    ID leadId;

    public UpdateLeadSituacaoCadastral(ID leadId) {
        this.leadId = leadId;
    }

    public void execute(QueueableContext context) {
        Lead lead = [SELECT TXT_CNPJ__c, TXT_Nome_Fantasia__c, TXT_Razao_Social__c, TXT_situacaoCadastral__c FROM Lead WHERE Id = :leadId];
        lead.TXT_situacaoCadastral__c = 'CNPJ nao ativo na Receita federal';
        update lead;
    }
}