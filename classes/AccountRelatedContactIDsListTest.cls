@isTest
private class AccountRelatedContactIDsListTest {
    
    @isTest
    static void testAccountRelatedContactIDsList() {
        Account testAcc = new Account(Name = 'Test Acc');
        insert testAcc;
        List<Contact> relContacts = new List<Contact>();
        for (Integer i=0; i<5;i++) {
            Contact testCont = new Contact(LastName = 'Test Cont'+i, AccountId = testAcc.Id);
            relContacts.add(testCont);
        }
        insert relContacts;
        
        for (Contact cnt:relContacts){
            AccountRelatedContactIDsList.contactIDsList(cnt);
        }
        Account acc = [SELECT Id,ContactIDs__c FROM Account WHERE Id = :testAcc.Id];
        Integer count=0;
        for(Contact cn:relContacts){
            if (acc.ContactIDs__c.contains(cn.Id)){
                count++;
            }
        }
        System.assertEquals(relContacts.size(), count); 
    }
}