@isTest
private class PopulatesCloseDateIfClosedTest {
    
    @isTest
    static void testCloseDate() {
        List<Opportunity> upOpp = new List<Opportunity>();
        Test.startTest();
        List<Opportunity> oppList = test.loadData(Opportunity.sObjectType,'OpportunityNotModDataTest2');
    	System.assert(oppList.size() == 4);
        for (Opportunity opp:oppList){
            opp.StageName = 'Closed Won';
            upOpp.add(opp);
        }
        update upOpp;
        Test.stopTest();
        List<Opportunity> closedOpp = [SELECT Id FROM Opportunity WHERE CloseDate = :Date.today()];
        System.assertEquals(upOpp.size(),closedOpp.size());
    }

}