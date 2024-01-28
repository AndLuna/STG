public with sharing class Opp_AtualizaFase {
    public static void run(List<Opportunity> newOpportunities, Map<Id, Opportunity> oldOpportunitiesMap) {
        for (Opportunity opp : newOpportunities) {
            Opportunity oldOpp = oldOpportunitiesMap.get(opp.Id);

            if (opp.DAT_Data_Fim__c != null && opp.DAT_Data_Inicio__c != null && opp.TXTL_Detalhamento_do_projeto__c != null) {
                // Define a fase como "Negotiation/Review" apenas se o valor antigo for igual a "Prospecting"
                if (oldOpp.StageName == 'Prospecting') {
                    opp.StageName = 'Negotiation/Review';
                }
            }
        }
    }
}
