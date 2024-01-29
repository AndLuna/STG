public with sharing class OpportunityHandler {
    public static void handleOpportunityChanges(List<Opportunity> newOpportunities, Map<Id, Opportunity> oldOpportunitiesMap) {
        if (Trigger.isBefore) {
            if (Trigger.isUpdate) {
                Opp_ChecarClienteRecorrente.run(newOpportunities);
                Opp_AtualizaFase.run(newOpportunities, oldOpportunitiesMap);
                OpportunityScoreController.calculateOppScore(Trigger.new);
            }
            if (Trigger.isInsert) {
                Opp_ChecarClienteRecorrente.run(newOpportunities);
                Opp_AtualizaFase.run(newOpportunities, new Map<Id, Opportunity>());
                OpportunityScoreController.calculateOppScore(Trigger.new);
            }
        } else if (Trigger.isAfter) {
            if (Trigger.isUpdate) {
           
            } else if (Trigger.isInsert) {
          
            }
        }
    }
}
