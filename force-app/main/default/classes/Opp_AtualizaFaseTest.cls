@isTest
private class Opp_AtualizaFaseTest {

    private static Opportunity createTestOpportunity() {
        return new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Negotiation/Review',
            CHK_temDocumento__c = true,
            Processo_de_aprova_o__c = 'Concluido',
            CloseDate = date.today()
        );
    }

    @isTest
    static void testClosedWonWithPendingApprovalProcess() {
        Opportunity testOpportunity = createTestOpportunity();
        insert testOpportunity;

        Test.startTest();

        try {
            testOpportunity.StageName = 'Closed Won';
            testOpportunity.Processo_de_aprova_o__c = 'Aguardando Formalização';
            update testOpportunity;
        } catch (Exception e) {
            System.assert(e.getMessage().contains('Não é permitido Ganhar a oportunidade enquanto o Processo de Aprovação estiver "Aguardando Formalização".'), 'Mensagem de erro incorreta.');
        }

        Test.stopTest();
    }
    @isTest
    static void testProspectingToNegotiationReview() {
    
        Opportunity testOpportunity = createTestOpportunity();
        testOpportunity.StageName = ('Prospecting');
        insert testOpportunity;

        Test.startTest();

    
        Opportunity updatedOpportunity = [SELECT Id, StageName FROM Opportunity WHERE Id = :testOpportunity.Id LIMIT 1];
        System.assertEquals('Prospecting', updatedOpportunity.StageName, 'Oportunidade deve estar inicialmente em "Prospecting"');

    
        updatedOpportunity.DAT_Data_Fim__c = System.today() + 10;
        updatedOpportunity.DAT_Data_Inicio__c = System.today();
        updatedOpportunity.TXTL_Detalhamento_do_projeto__c = 'Detalhamento do Projeto';

        update updatedOpportunity;

      
        Opportunity finalOpportunity = [SELECT Id, StageName FROM Opportunity WHERE Id = :updatedOpportunity.Id LIMIT 1];
        System.assertEquals('Negotiation/Review', finalOpportunity.StageName, 'Oportunidade não foi movida para "Negotiation/Review"');

        Test.stopTest();
    }
 @isTest
    static void testFormalizationStageConditions() {
        Opportunity testOpportunity = createTestOpportunity();
        testOpportunity.CHK_temDocumento__c = false;
        insert testOpportunity;

        testOpportunity.StageName = 'Formalização';
        try {
            update testOpportunity;
            System.assert(false, 'O código não gerou a exceção esperada.');
        } catch (Exception e) {
            System.assert(e.getMessage().contains('Para avançar, anexe o contrato.'), 'Mensagem de erro incorreta.');
        }
        testOpportunity.CHK_temDocumento__c = true;
        testOpportunity.StageName = 'Formalização';
        testOpportunity.Email__c = 'contato@gmail.com';
        testOpportunity.DAT_Data_Fim__c = date.today();
        testOpportunity.DAT_Data_Inicio__c = date.today();
        update testOpportunity;
    }
}