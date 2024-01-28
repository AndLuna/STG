public with sharing class ContentDocumentLink_OppAfterDelete {
    public static void updateOpportunityCheckbox(List<Id> deletedContentDocumentLinkIds) {
        Set<Id> opportunityIdsWithDocument = new Set<Id>();
        List<Opportunity> opportunitiesToUpdate = new List<Opportunity>();

        // Identifica oportunidades com documentos anexados
        for (Id cdlId : deletedContentDocumentLinkIds) {
            if (cdlId != null && String.valueOf(cdlId).startsWith('006')) {
                opportunityIdsWithDocument.add(String.valueOf(cdlId).substring(0, 15));
            }
        }

        // Busca todas as oportunidades relacionadas às oportunidades com documentos
        Map<Id, Opportunity> opportunitiesWithDocumentMap = new Map<Id, Opportunity>([
            SELECT Id, CHK_temDocumento__c
            FROM Opportunity
            WHERE Id IN :opportunityIdsWithDocument
        ]);

        // Atualiza as oportunidades com base na presença de documentos
        for (Opportunity opp : opportunitiesWithDocumentMap.values()) {
            opp.CHK_temDocumento__c = true;
            opportunitiesToUpdate.add(opp);
        }

        // Atualiza oportunidades que não possuem documentos
        for (Opportunity opp : [SELECT Id, CHK_temDocumento__c FROM Opportunity WHERE Id NOT IN :opportunityIdsWithDocument]) {
            opp.CHK_temDocumento__c = false;
            opportunitiesToUpdate.add(opp);
        }

        // Executa a atualização no banco de dados
        if (!opportunitiesToUpdate.isEmpty()) {
            update opportunitiesToUpdate;
        }
    }
}
