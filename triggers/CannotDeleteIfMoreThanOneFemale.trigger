/*
Not allow any class to delete if there are more than one Female students.
*/
trigger CannotDeleteIfMoreThanOneFemale on Class__c (before delete) {
    for(Class__c cl:[SELECT Id,(SELECT Id FROM Students__r WHERE Sex__c = 'Female') FROM Class__c WHERE Id IN:Trigger.oldMap.keySet()]){
        if (cl.Students__r.size() > 1) {
            Trigger.oldMap.get(cl.Id).addError('You cannot delete this record');
        }
    }

}