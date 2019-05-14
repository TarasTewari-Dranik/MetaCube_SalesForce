@isTest
private class ClassObjectTriggersTest {
    @testSetup 
    static void testData() {
        List<Class__c> testClasses= new List<Class__c>();
        for (Integer i=0; i < 2; i++){
            Class__c cl = new Class__c(Name = 'Test class'+i);
            testClasses.add(cl);
        }
        insert testClasses;
        List<Student__c> testStudents = new List<Student__c>();
        for (Class__c cl:testClasses){
            for (Integer i=0; i < 10; i++){
            	Student__c st = new Student__c (Name = 'Test student'+i,Class__c = cl.Id,Sex__c = 'Male');
            	testStudents.add(st);
       		}
        }
        insert testStudents;
    }
    
    @isTest
    static void testCannotDeleteIfMoreThanOneFemale(){
        List<Class__c> allclasses = [SELECT Id FROM Class__c];
        for (Integer i=0; i<2;i++){
            Student__c femaleSt = new Student__c (Name = 'Female'+i,Class__c = allclasses[0].Id, Sex__c = 'Female');
            insert femaleSt;
        }
        Database.DeleteResult dr1 = Database.delete(allclasses[0],false);
        System.assertEquals(dr1.isSuccess(), false);
        Database.DeleteResult dr2 = Database.delete(allclasses[1],false);
        System.assertEquals(dr2.isSuccess(), true);
    }
    
     @isTest
     static void testDeleteAllAssociatedStudentsRecordIfReset(){
        List<Class__c> allclasses = [SELECT Id FROM Class__c];
        List<Student__c> allStudentsBeforeReset = [SELECT Id FROM Student__c];
        System.assertEquals(20, allStudentsBeforeReset.size());
        for (Class__c cl:allclasses){
            cl.Custom_Status__c = 'Reset';
            update cl;
        }
        List<Student__c> allStudents = [SELECT Id FROM Student__c];
        System.assertEquals(0, allStudents.size());
        
    }

}