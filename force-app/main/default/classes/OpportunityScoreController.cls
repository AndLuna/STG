public class OpportunityScoreController {
    @AuraEnabled(cacheable=true)
    public static Opportunity getOppScore(Id OpportunityId) {
        Opportunity opportunity = [SELECT Id, OppSource_SomadePontos__c, PKL_Satisfacao__c, name, amount FROM Opportunity WHERE Id = :opportunityId LIMIT 1];
        return opportunity;
    }

    public static void calculateOppScore(List<Opportunity> opportunities) {
        for (Opportunity opportunity : opportunities) {
            Integer oppScore = 0;
            if (opportunity.PKL_Satisfacao__c == '1') {
                oppScore += 20;
            } else if (opportunity.PKL_Satisfacao__c == '2') {
                oppScore += 40;
            } else if (opportunity.PKL_Satisfacao__c == '3') {
                oppScore += 60;
            } else if (opportunity.PKL_Satisfacao__c == '4') {
                oppScore += 80;
            }else if (opportunity.PKL_Satisfacao__c == '5') {
                oppScore += 100;
            }else {
                oppScore += 0;
            }

            // Atualizar a pontuação total no campo OppSource_SomadePontos__c
            opportunity.OppSource_SomadePontos__c = oppScore;
        }
    }
}