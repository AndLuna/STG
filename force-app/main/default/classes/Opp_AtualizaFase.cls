public with sharing class Opp_AtualizaFase {

    public static void run(List<Opportunity> newOpportunities, Map<Id, Opportunity> oldOpportunitiesMap) {
        for (Opportunity opp : newOpportunities) {
            Opportunity oldOpp = oldOpportunitiesMap.get(opp.Id);

            if (opp.DAT_Data_Fim__c != null && opp.DAT_Data_Inicio__c != null && opp.TXTL_Detalhamento_do_projeto__c != null) {
                if (oldOpp != null && oldOpp.StageName == 'Prospecting') {
                    opp.StageName = 'Negotiation/Review';
                }
            }

            if (oldOpp != null && oldOpp.StageName == 'Negotiation/Review' && opp.CHK_temDocumento__c) {
                opp.StageName = 'Formalização';
            }

            if (opp.StageName == 'Formalização' && !opp.CHK_temDocumento__c) {
                opp.addError('Não é possível passar manualmente para "Formalização" sem adicionar um documento.');
            }
        }
    }
}
