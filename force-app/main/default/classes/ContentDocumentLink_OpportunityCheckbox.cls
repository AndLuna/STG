public class ContentDocumentLink_OpportunityCheckbox {
    public static void updateOpportunityCheckbox(List<ContentDocumentLink> newContentDocumentLinks) {
        List<Opportunity> opportunitiesToUpdate = new List<Opportunity>();

        for (ContentDocumentLink cdl : newContentDocumentLinks) {
            if (cdl.LinkedEntityId != null && String.valueOf(cdl.LinkedEntityId).startsWith('006')) {
                String opportunityId = String.valueOf(cdl.LinkedEntityId).substring(0, 15);

                Opportunity opp = [SELECT Id, CHK_temDocumento__c FROM Opportunity WHERE Id = :opportunityId LIMIT 1];
                opp.CHK_temDocumento__c = true;

                opportunitiesToUpdate.add(opp);
            }
        }

        if (!opportunitiesToUpdate.isEmpty()) {
            update opportunitiesToUpdate;
        }
    }
    public static void updateOpportunityCheckboxBeforeInsert(List<ContentDocumentLink> newContentDocumentLinks) {
        for (ContentDocumentLink cdl : newContentDocumentLinks) {
            if (cdl.LinkedEntityId != null && String.valueOf(cdl.LinkedEntityId).startsWith('006')) {
                // Consultar o Opportunity
                Opportunity opp = [SELECT Id, CHK_temDocumento__c FROM Opportunity WHERE Id = :cdl.LinkedEntityId LIMIT 1];

                // Verificar se o documento está relacionado ao Opportunity
                if (opp != null) {
                    // Consultar o ContentVersion associado ao ContentDocumentLink
                    List<ContentVersion> contentVersions = [SELECT Id, Title, FileExtension FROM ContentVersion WHERE ContentDocumentId = :cdl.ContentDocumentId LIMIT 1];

                    // Verificar se há uma versão válida e se o título é "contrato" e a extensão é PDF
                    if (!contentVersions.isEmpty() && (contentVersions[0].Title.equalsIgnoreCase('contrato') || (contentVersions[0].Title.equalsIgnoreCase('Cotação') ) && contentVersions[0].FileExtension.equalsIgnoreCase('pdf'))) {
                        opp.CHK_temDocumento__c = true;
                    } else {
                        // Se não for contrato ou não for PDF, enviar mensagem de erro
                        cdl.addError('O documento deve ter o título "contrato" e a extensão PDF.');
                    }
                }
            }
        }
    }
}