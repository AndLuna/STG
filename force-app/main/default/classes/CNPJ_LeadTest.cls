@isTest
public class CNPJ_LeadTest {
    
    private static Lead createTestLead() {
        return new Lead(
            lastName = 'teste',
            company = 'teste',
            TXT_CNPJ__c = '19131243000197'
        );
    }
    
    @isTest
    static void testInvalidCNPJ() {
        Lead lead = createTestLead();
        insert lead;
        
        Test.startTest();
        
        CNPJ_Lead.processLeadAfterInsert(new List<Id>{lead.Id});
        Test.stopTest();
        
        lead = [SELECT Id, TXT_CNPJ__c, TXT_Nome_Fantasia__c, TXT_Razao_Social__c, TXT_situacaoCadastral__c FROM Lead WHERE Id = :lead.Id];
        System.assertEquals(null, lead.TXT_Nome_Fantasia__c);
        System.assertEquals(null, lead.TXT_Razao_Social__c);
    }
    
    @isTest
    static void testValidCNPJ200() {
        Lead leadValidCNPJ = createTestLead();
        leadValidCNPJ.TXT_CNPJ__c = '19131243000197';
        insert leadValidCNPJ;
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(200));
        
        Test.startTest();
        CNPJ_Lead.get(leadValidCNPJ.TXT_CNPJ__c, leadValidCNPJ.Id);
        Test.stopTest();
        
        Lead leadAfterGet = [SELECT Id, TXT_CNPJ__c, TXT_Nome_Fantasia__c, TXT_Razao_Social__c, TXT_situacaoCadastral__c FROM Lead WHERE Id = :leadValidCNPJ.Id];
        System.assertEquals('CNPJ ok na base da Receita Federal', leadAfterGet.TXT_situacaoCadastral__c);
        
    }
    
    @isTest
    static void testInvalidCNPJ400() {
        Lead leadInvalidCNPJ = createTestLead();
        insert leadInvalidCNPJ;
        
        // Configurar o mock HTTP para simular a resposta da API com status 400
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(400));
        
        Test.startTest();
        CNPJ_Lead.get(leadInvalidCNPJ.TXT_CNPJ__c, leadInvalidCNPJ.Id);
        Test.stopTest();
        
        Lead leadAfterGet = [SELECT Id, TXT_CNPJ__c, TXT_Nome_Fantasia__c, TXT_Razao_Social__c, TXT_situacaoCadastral__c FROM Lead WHERE Id = :leadInvalidCNPJ.Id];
        System.assertEquals('O CNPJ não está ativo na base da Receita Federal.', leadAfterGet.TXT_situacaoCadastral__c);
        System.assertEquals(null, leadAfterGet.TXT_Nome_Fantasia__c);
        System.assertEquals(null, leadAfterGet.TXT_Razao_Social__c);
    }
    
}