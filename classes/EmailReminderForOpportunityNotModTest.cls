@isTest
private class EmailReminderForOpportunityNotModTest {
    
    static testmethod void testScheduledJob(){
    	List<Opportunity> oppList = test.loadData(Opportunity.sObjectType,'OpportunityNotModDataTest2');
    	System.assert(oppList.size() == 4);
        
        Test.startTest();
        
        	RunEmailReminderForOpportunity.runReminder();
        	
        Test.stopTest();
        
        System.assertEquals(1, Limits.getEmailInvocations(), 'message');
        
    }
}