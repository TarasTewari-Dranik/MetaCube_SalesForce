/*
Not Allow any teacher to insert/update if that teacher is teaching English (Use subject multi select picklist).

*/
trigger NotAllowEnglishTeacher on Contact (before insert,before update) {
    for (Contact cnt:Trigger.new){
        if(cnt.Subject__c.contains('English')){
            cnt.addError('Teacher who teach English is not allowed');
        }
    }

}