@isTest
private class NotAllowEnglishTeacherTest {
    
    @isTest 
    static void testNotAllowEnglishTeacher() {
        List<Contact> newEnglishTeacher = new List<Contact>();
        for (Integer i=0;i<200;i++){
            Contact teach = new Contact(LastName = 'Test Cont',Subject__c = 'English');
            newEnglishTeacher.add(teach);
        }
        try {
    		insert newEnglishTeacher;
		} catch(Exception e) {
            System.Assert(e.getMessage().contains('Teacher who teach English is not allowed'));
		}
    }

}