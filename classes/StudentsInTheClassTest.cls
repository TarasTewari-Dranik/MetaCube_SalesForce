@isTest
private class StudentsInTheClassTest {
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
            for (Integer i=0; i < 200; i++){
            	Student__c st = new Student__c (Name = 'Test student'+i,Class__c = cl.Id);
            	testStudents.add(st);
       		}
        }
        insert testStudents;

    }
    
    static testmethod void testStudentsNameList(){
        Class__c oneClass = [SELECT Id FROM Class__c LIMIT 1];
        List<String> allSt = StudentsInTheClass.studentsNameList(oneClass);
        //List<String> studentListInTheClass = allSt.studentsNameList(oneClass);
        System.assertEquals(200,allSt.size());
    }
    
    static testmethod void testStudentsListInTheClasses(){
        Map<Id,Set<Id>> listOfClasses = StudentsInTheClass.studentsListInTheClasses();
        Integer count = 0;
        for (Integer i=0; i<listOfClasses.size();i++){
            count = count+listOfClasses.values()[i].size();
        }
        System.assertEquals(400,count);
    }

}