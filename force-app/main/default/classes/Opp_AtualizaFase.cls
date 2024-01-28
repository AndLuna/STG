public with sharing class Opp_AtualizaFase {
    public static void run(List<Opportunity> oportunidades) {
        for (Opportunity opp : oportunidades) {
  
            if (opp.DAT_Data_Fim__c != null && opp.DAT_Data_Inicio__c != null && opp.TXTL_Detalhamento_do_projeto__c != null) {
      
                opp.StageName = 'Negotiation/Review';
            }
        }
    }
}
