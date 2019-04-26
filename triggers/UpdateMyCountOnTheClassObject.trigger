/*
When insert/update any student’s in class then update MyCount Accordingly(Use MyCount as a number field).

*/
trigger UpdateMyCountOnTheClassObject on Student__c (after insert, after update, before delete) {
    Set<Id> classesId = new Set<Id>();
    List<Class__c> classesToUpdate = new List<Class__c>();


    if (Trigger.isUpdate){
        for (Student__c st:Trigger.New){
          	if (Trigger.oldMap.get(st.Id).Class__c !=  Trigger.newMap.get(st.Id).Class__c ) {
        		    classesId.add(Trigger.oldMap.get(st.Id).Class__c);
                     classesId.add(Trigger.newMap.get(st.Id).Class__c);
    		}
        }
		if  (classesId.size() != null) {
            for (Class__c cl:[SELECT Id,(SELECT Id FROM Students__r) FROM Class__c WHERE Id IN :classesId]){
       		 classesToUpdate.add(new Class__c(id = cl.Id, MyCount__c = cl.Students__r.size()));
    	   }
        }
    }
    if (Trigger.isInsert){
        for (Student__c st:Trigger.New){
            classesId.add(st.Class__c);
        }
        if  (classesId.size() != null) {
            for (Class__c cl:[SELECT Id,(SELECT Id FROM Students__r) FROM Class__c WHERE Id IN :classesId]){
       	     	 classesToUpdate.add(new Class__c(id = cl.Id, MyCount__c = cl.Students__r.size()));
    	  }
        }
    }
    if (Trigger.isDelete){
        Map<Id,Decimal> classesStudensNumber = new Map<Id,Decimal>();
        for(Student__c st:Trigger.Old){
            if(st.Class__c != null){
            	if(classesStudensNumber.get(st.Class__c) != null){
    				classesStudensNumber.put(st.Class__c,classesStudensNumber.get(st.Class__c)+1);
           		} else {
                	classesStudensNumber.put(st.Class__c, 1);
            	}
            }
		}
        if  (classesStudensNumber.size() != null) {
            for (Class__c cl:[SELECT Id,MyCount__c FROM Class__c WHERE Id IN :classesStudensNumber.keySet()]){
                if (cl.MyCount__c != null) {
                    classesToUpdate.add(new Class__c(id = cl.Id, MyCount__c = cl.MyCount__c - classesStudensNumber.get(cl.Id)));
                }
    	  }
        } 
    }
    update classesToUpdate;
}