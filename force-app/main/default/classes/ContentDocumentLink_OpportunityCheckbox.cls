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
}
