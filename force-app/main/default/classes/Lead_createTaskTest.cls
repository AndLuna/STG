@isTest
private class Lead_createTaskTest {
    @isTest
    static void testCreateTask() {
        Lead testLead = new Lead(
            FirstName = 'Test',
            LastName = 'Lead',
            Company = 'Test Company',
            TXT_CNPJ__c = '19131243000197',
            OwnerId = UserInfo.getUserId()
        );
        insert testLead;
        
        Test.startTest();
        Lead_createTask.createTask([SELECT Id, OwnerId FROM Lead WHERE Id = :testLead.Id]);
        Test.stopTest();

        List<Task> tasks = [SELECT Id, Subject, WhoId, OwnerId FROM Task WHERE WhoId = :testLead.Id];
        System.assert(tasks.size() > 0, 'Expected at least one task to be created');

    }
}