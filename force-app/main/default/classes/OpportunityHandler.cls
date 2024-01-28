public with sharing class OpportunityHandler {
    public static void handleOpportunityChanges(List<Opportunity> newOpportunities, Map<Id, Opportunity> oldOpportunitiesMap) {
        if (Trigger.isBefore) {
            if (Trigger.isUpdate) {
                Opp_ChecarClienteRecorrente.run(newOpportunities);
                Opp_AtualizaFase.run(newOpportunities, oldOpportunitiesMap);
            }
            if (Trigger.isInsert) {
                Opp_ChecarClienteRecorrente.run(newOpportunities);
                Opp_AtualizaFase.run(newOpportunities, new Map<Id, Opportunity>());
            }
        } else if (Trigger.isAfter) {
            if (Trigger.isUpdate) {
                // Adicione a lógica de pós-atualização se necessário
            } else if (Trigger.isInsert) {
                // Adicione a lógica de pós-inserção se necessário
            }
        }
    }
}
