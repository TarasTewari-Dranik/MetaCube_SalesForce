/*
Not allow insert student if class already reached MaxLimit.(Without using MyConnt field).

*/
trigger NotAllowedInsertIfClassReachedLimit on Student__c (before insert, before update) {

    if (Trigger.isInsert) {
        Map<Id,Decimal> classesStudensNumber = new Map<Id,Decimal>();
        for(Student__c st:Trigger.New){
            if(classesStudensNumber.get(st.Class__c) != null){
    			classesStudensNumber.put(st.Class__c,classesStudensNumber.get(st.Class__c)+1);
            } else {
                classesStudensNumber.put(st.Class__c, 1);
            }
		}
    	List<Class__c> classes = [SELECT Id,NumberOfStudents__c,MaxSize__c FROM Class__c WHERE Id IN :classesStudensNumber.keySet()];
    	Map<Id, Class__c> m = new Map<Id, Class__c>(classes);
        for (Student__c st:Trigger.New){
        	if(m.get(st.Class__c).NumberOfStudents__c+classesStudensNumber.get(st.Class__c) > m.get(st.Class__c).MaxSize__c){
           		st.addError('Class already reached MaxLimit');
        	}
        }
    }
    
    if (Trigger.isUpdate) {
        Map<Id,Decimal> classesStudensNumber = new Map<Id,Decimal>();
        for(Student__c st:Trigger.New){
            if(Trigger.oldMap.get(st.Id).Class__c != Trigger.newMap.get(st.Id).Class__c){
                if (classesStudensNumber.get(Trigger.oldMap.get(st.Id).Class__c) != null){
                    classesStudensNumber.put(Trigger.oldMap.get(st.Id).Class__c,classesStudensNumber.get(Trigger.oldMap.get(st.Id).Class__c)-1);
                } else {
                    classesStudensNumber.put(Trigger.oldMap.get(st.Id).Class__c,-1);
                }
                if (classesStudensNumber.get(Trigger.newMap.get(st.Id).Class__c) != null ){
                    classesStudensNumber.put(Trigger.newMap.get(st.Id).Class__c,classesStudensNumber.get(Trigger.newMap.get(st.Id).Class__c)+1);
                } else {
                    classesStudensNumber.put(Trigger.newMap.get(st.Id).Class__c,1);
                }
            } 
		}
        List<Class__c> classes = [SELECT Id,NumberOfStudents__c,MaxSize__c FROM Class__c WHERE Id IN :classesStudensNumber.keySet()];
    	Map<Id, Class__c> m = new Map<Id, Class__c>(classes);
        for (Student__c st:Trigger.New){
        	if(m.get(st.Class__c).NumberOfStudents__c+classesStudensNumber.get(st.Class__c) > m.get(st.Class__c).MaxSize__c){
           		st.addError('Class already reached MaxLimit');
        	}
        }
    }
}