@isTest
private class StudentTriggersTest {
    @testSetup 
    static void testData() {
        List<Class__c> testClasses= new List<Class__c>();
        for (Integer i=0; i < 2; i++){
            Class__c cl = new Class__c(Name = 'Test class'+i,MaxSize__c = 15);
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
    static void testNotAllowedInsertIfClassReachedLimit() {
        List<Class__c> allClasses = [SELECT Id FROM Class__c];
        List<Student__c> newStudents = new List<Student__c>();
        for (Class__c cl:allClasses) {
            for (Integer i=0; i<10; i++){
                Student__c st = new Student__c (Name = 'New Test student'+i,Class__c = cl.Id,Sex__c = 'Female');
            	newStudents.add(st);
            }
        }
        try {
    		insert newStudents;
		} catch(Exception e) {
            System.Assert(e.getMessage().contains('Class already reached MaxLimit'));
		}
        
    }
    @isTest
    static void testNotAllowedInsertIfClassReachedLimitUpdate() {
        List<Class__c> allClasses = [SELECT Id,MyCount__c FROM Class__c];
        List<Student__c> newStudents = new List<Student__c>();
        for (Class__c cl:allClasses) {
            for (Integer i=0; i<3; i++){
                Student__c st = new Student__c (Name = 'New Test student'+i,Class__c = cl.Id,Sex__c = 'Female');
            	newStudents.add(st);
            }
        }
        insert newStudents;
        Id classId = newStudents[0].Class__c;
        for (Integer i=0;i<newStudents.size();i++){
            newStudents[i].Class__c = classId;
        }
        try {
    		update newStudents;
		} catch(Exception e) {
            System.Assert(e.getMessage().contains('Class already reached MaxLimit'));
		}
    }
    @isTest
    static void testUpdateMyCountOnTheClassObject() {
        List<Class__c> allClasses = [SELECT Id,MyCount__c FROM Class__c];
        List<Student__c> newStudents = new List<Student__c>();
        for (Class__c cl:allClasses) {
            for (Integer i=0; i<2; i++){
                Student__c st = new Student__c (Name = 'New Test student'+i,Class__c = cl.Id,Sex__c = 'Female');
            	newStudents.add(st);
            }
        }
        insert newStudents;
        for (Class__c cl:[SELECT Id,MyCount__c FROM Class__c]) {
            System.assertEquals(12, cl.MyCount__c);
        }
        Id classId = newStudents[0].Class__c;
        for (Integer i=0;i<newStudents.size();i++){
            newStudents[i].Class__c = classId;
        }
        update newStudents;
        Class__c updatedClass = [SELECT Id,MyCount__c FROM Class__c WHERE Id =:classId];
        List<Student__c> relatedStudents = [SELECT Id FROM Student__c WHERE Class__c =:classId];
        System.assertEquals(relatedStudents.size(), updatedClass.MyCount__c);
        
        List<Student__c> studentsToDelete = [SELECT Id FROM Student__c WHERE Class__c =:allClasses[0].Id LIMIT 2];
        delete studentsToDelete;
        Class__c numberStud = [SELECT MyCount__c FROM Class__c WHERE Id =:allClasses[0].Id];
        List<Student__c> listStudentsAfterDelete = [SELECT Id FROM Student__c WHERE Class__c =:allClasses[0].Id];
        System.assertEquals(listStudentsAfterDelete.size(), numberStud.MyCount__c);
    }

}