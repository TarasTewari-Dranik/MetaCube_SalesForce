/*
Create a new PickList  “Custom Status” in Class object.(New,Open,Close,Reset) values. When this field changed and value is “Reset” now then delete all associated students with related Class.
*/
trigger DeleteAllAssociatedStudentsRecordIfReset on Class__c (after update) {
    Set<Id> ids = new Set<Id>();
    for (Class__c cl:Trigger.New){
        if (Trigger.oldMap.get(cl.Id).Custom_Status__c != Trigger.newMap.get(cl.Id).Custom_Status__c && cl.Custom_Status__c == 'Reset') {
            ids.add(cl.Id);
        }
    }
    List<Student__c> deleteStudents = [SELECT Id FROM Student__c WHERE Class__c IN :ids];
    delete deleteStudents;
}