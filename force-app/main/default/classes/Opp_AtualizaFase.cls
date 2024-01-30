public with sharing class Opp_AtualizaFase {

    public static void run(List<Opportunity> newOpportunities, Map<Id, Opportunity> oldOpportunitiesMap) {
        for (Opportunity opp : newOpportunities) {
            Opportunity oldOpp = oldOpportunitiesMap.get(opp.Id);

            if (opp.DAT_Data_Fim__c != null && opp.DAT_Data_Inicio__c != null && opp.TXTL_Detalhamento_do_projeto__c != null) {
                if (oldOpp != null && oldOpp.StageName == 'Prospecting') {
                    opp.StageName = 'Negotiation/Review';
                }
            }

            if (oldOpp != null && Opp.StageName == 'Formalização') {
                if (opp.Email__c == null || opp.DAT_Data_Fim__c == null || opp.DAT_Data_Inicio__c == null) {
                    if(!opp.CHK_temDocumento__c){ 
                        opp.addError('Para avançar, anexe o contrato.');

                    }
                    else
                    {
                    opp.addError('Para avançar, os campos Email, Data Fim e Data Inicio devem ser preenchidos.');
                }
                } else {
                    opp.StageName = 'Formalização';
                }
            }

            // if (opp.StageName == 'Formalização' && !opp.CHK_temDocumento__c) {
            //     opp.addError('Não é possível passar manualmente para "Formalização" todos os campos Email, Data Fim e Data Inicio devem ser preenchidos e um documento adicionado depois.');
            // }
            if ((opp.Processo_de_aprova_o__c != 'Concluido') &&
                (opp.StageName == 'Closed Won')) {
                opp.addError('Não é permitido Ganhar a oportunidade enquanto o Processo de Aprovação estiver "Aguardando Formalização".');
            }
        }
    }
}
