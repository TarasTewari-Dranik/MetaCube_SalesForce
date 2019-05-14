@isTest
private class PopulateManagerFieldForOpportunityTest {
    @testSetup 
    static void testData() {
        Account testAcc = new Account(Name = 'Test Acc');
        insert testAcc;
        Contact testCont = new Contact(LastName = 'Test Cont', AccountId = testAcc.Id);
        insert testCont;
        List<Opportunity> newOpp = new List<Opportunity>();
        for (Integer i = 0; i<200; i++) {
            Opportunity opp = new Opportunity(Name = 'Test'+i, CloseDate = date.today(), StageName = 'Prospecting',BillToContact__c = testCont.Id);
            newOpp.add(opp);
        }
        insert newOpp;
    }
    
    static testmethod void testQueueable() {
        List<Opportunity> testOpportunity = [SELECT Id, Manager__c  FROM Opportunity WHERE Manager__c = null];
        PopulateManagerFieldForOpportunity managerForOpportunities = new PopulateManagerFieldForOpportunity(testOpportunity);
        Test.startTest();        
        System.enqueueJob(managerForOpportunities);
        Test.stopTest();
        List<Opportunity> processedOpportunity = [SELECT Id, Manager__c  FROM Opportunity WHERE Manager__c != null];
        Integer beforeProcessing = testOpportunity.size();
        Integer afterProcessing = processedOpportunity.size();
        System.assertEquals(beforeProcessing,afterProcessing);
    }

}