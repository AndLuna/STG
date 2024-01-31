/* 
Objetivo: Gerenciar informações de leads com base na API de CNPJ.
Descrição: Esta classe contém métodos para realizar chamadas à API, atualizar leads com os dados obtidos e lidar com erros, como CNPJ inválido.
Criado por: contato.andreluna@gmail.om
*/
public with sharing class CNPJ_Lead {

    @future(callout=true)
    public static void get(String CNPJ, ID leadId) {
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();
        IntegrationLogs__c integrationLog = new IntegrationLogs__c();

        req.setEndpoint('https://brasilapi.com.br/api/cnpj/v1/' + CNPJ);
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/json; charset=utf-8');

        try {
            res = http.send(req);
            String text = res.getBody();

            integrationLog.Integration__c = 'getCNPJ';
            integrationLog.Result__c = text;
            integrationLog.ExecutionDate__c = Datetime.now();
            System.enqueueJob(new SaveIntegrationLog(integrationLog));

            System.debug('API Response Status Code: ' + res.getStatusCode());
            System.debug('API Response Body: ' + text);

            // Adiciona verificação para erro 400 (Bad Request)
            if (res.getStatusCode() == 400) {
                Lead leadToUpdate = new Lead(Id = leadId, 
                    TXT_situacaoCadastral__c = 'O CNPJ não está ativo na base da Receita Federal.',
                    TXT_Nome_Fantasia__c = null,
                    TXT_Razao_Social__c = null

                );

                update leadToUpdate;
                return; 
            }

            BrasilAPIResponse response = BrasilAPIResponse.parse(text);

            Lead lead = [SELECT TXT_CNPJ__c, TXT_Nome_Fantasia__c, TXT_Razao_Social__c, TXT_situacaoCadastral__c FROM Lead WHERE Id = :leadId];
            lead.TXT_CNPJ__c = response.cnpj;
            lead.TXT_Nome_Fantasia__c = response.nome_fantasia;
            lead.TXT_Razao_Social__c = response.razao_social;
            lead.TXT_situacaoCadastral__c = 'CNPJ ok na base da Receita Federal';

            System.debug('Lead fields before update: ' + lead);

            update lead;

            System.debug('Lead fields after update: ' + lead);

        } catch (Exception e) {
            System.debug('Exception Message: ' + e.getMessage());
            System.debug('Exception Line: ' + e.getLineNumber());

            Lead leadToUpdateOnError = new Lead(Id = leadId, 
                TXT_situacaoCadastral__c = 'CNPJ não disponivel no banco de dados da API.'
            );

            update leadToUpdateOnError;
        }
    }

    public static void processLeadAfterInsert(List<Id> leadIds) {
        for (Id leadId : leadIds) {
            Lead lead = [SELECT TXT_CNPJ__c FROM Lead WHERE Id = :leadId];
            get(lead.TXT_CNPJ__c, leadId);
        }
    }

}