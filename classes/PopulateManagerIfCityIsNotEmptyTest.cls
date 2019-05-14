@isTest
private class PopulateManagerIfCityIsNotEmptyTest {
    @isTest
    static void testPopulateManager() {
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u = new User(Alias = 'standt', Email='standarduser@metacube.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser123@metacube.com');
        insert u;
        CityManager__c cityMan = new CityManager__c (City__c = 'Almere', Manager__c = u.Id);
        insert cityMan;
        Loan__c nLoan = new Loan__c(Name='Test', City__c = 'Almere');
        insert nLoan;
        Loan__c loanManager = [SELECT Manager__c FROM Loan__c WHERE Id =:nLoan.Id];
        System.assertEquals(u.Id, loanManager.Manager__c);

    }

}