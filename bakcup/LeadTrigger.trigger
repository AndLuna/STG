trigger LeadTrigger on Lead (after insert, after update) {
    List<Id> leadIds = new List<Id>();

    for (Lead leadRecord : Trigger.new) {
        if (Trigger.isUpdate && leadRecord.TXT_CNPJ__c != Trigger.oldMap.get(leadRecord.Id).TXT_CNPJ__c) {
            leadIds.add(leadRecord.Id);
        } else if (Trigger.isInsert) {
            leadIds.add(leadRecord.Id);
            System.enqueueJob(new ProcessLeads(leadIds));
        }
    }

    // Call the method directly for each Lead updated in the event
    if (Trigger.isUpdate && !leadIds.isEmpty()) {
        for (Id leadId : leadIds) {
            Lead lead = [SELECT TXT_CNPJ__c FROM Lead WHERE Id = :leadId];
            CNPJ_Lead.get(lead.TXT_CNPJ__c, leadId);
        }
    }
}
