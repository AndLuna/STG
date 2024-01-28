trigger OpportunityTrigger on Opportunity (before insert, before update, after insert, after update) {
        OpportunityHandler.handleOpportunityChanges(Trigger.new, Trigger.oldMap);
    } 