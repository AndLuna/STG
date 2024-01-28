trigger ContentDocumentLinkTrigger on ContentDocumentLink (after insert, after delete) {
   if(trigger.isInsert){
    ContentDocumentLink_OpportunityCheckbox.updateOpportunityCheckbox(Trigger.new);
   } 
}