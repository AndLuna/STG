trigger ContentDocumentLinkTrigger on ContentDocumentLink (before insert, after insert, after delete) {
   if(trigger.isBefore && trigger.isInsert){

      ContentDocumentLink_OpportunityCheckbox.updateOpportunityCheckboxBeforeInsert(Trigger.new);
   }
      if(trigger.isInsert){
   
         ContentDocumentLink_OpportunityCheckbox.updateOpportunityCheckbox(Trigger.new);
         ContentDocumentLink_ProductsImg.updateProductImageId(Trigger.new);
         
   } 
}
