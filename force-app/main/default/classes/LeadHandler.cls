public class LeadHandler {
    public static void handleLeadChanges(List<Lead> newLeads, Map<Id, Lead> oldLeadMap) {
        List<Id> leadIds = new List<Id>();

        for (Lead leadRecord : newLeads) {
            if (oldLeadMap != null && leadRecord.TXT_CNPJ__c != oldLeadMap.get(leadRecord.Id).TXT_CNPJ__c) {
                leadIds.add(leadRecord.Id);
            } else if (Trigger.isInsert) {
                leadIds.add(leadRecord.Id);
                System.enqueueJob(new ProcessLeads(leadIds));
            }
        }

        if (!leadIds.isEmpty()) {
            for (Id leadId : leadIds) {
                Lead lead = [SELECT TXT_CNPJ__c FROM Lead WHERE Id = :leadId];
                CNPJ_Lead.get(lead.TXT_CNPJ__c, leadId);
            }
        }

        if (Trigger.isInsert && Trigger.isBefore) {

        }

        if (Trigger.isInsert && Trigger.isAfter) {
            Lead_createTask.createTask([SELECT Id, OwnerId FROM Lead WHERE Id IN :leadIds]);
        }
    }
}
