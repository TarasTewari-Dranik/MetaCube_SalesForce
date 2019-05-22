public with sharing class TableEditAndDelete {
    
    public String SelectedClassId { get; set;}
    public Class__c editRecord {get;set;}

    public TableEditAndDelete(ApexPages.StandardSetController controller){
        
    }

    public void deleteClass(){
      List<Class__c> classes = [SELECT Id FROM Class__c WHERE id = :SelectedClassId];
      if(classes.size() > 0 || classes[0].Id != ''){
      	delete classes;
      }
        return;
   }
    
    public void editClass(){
      Class__c editRecord = [SELECT Id,Name,Board__c,ClassTeacher__c,Custom_Status__c,Fee__c,MaxSize__c FROM Class__c WHERE id = :SelectedClassId LIMIT 1];
   }

}