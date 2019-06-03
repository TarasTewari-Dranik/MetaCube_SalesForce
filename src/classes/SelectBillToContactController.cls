public class SelectBillToContactController {
    
    private Opportunity opp;
    public String billContact {get;set;}
    
    public SelectBillToContactController(){
         opp = [SELECT Id,Name,Manager__c,BillToContact__c FROM Opportunity WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
        	
    }
    
    public List<SelectOption> getItems() {
        List<SelectOption> options=new List<SelectOption>();
        if (opp.Manager__c != null) {
            for (Contact cnt:[SELECT Id,Name FROM Contact WHERE AccountId =:opp.Manager__c]){
             options.add(new SelectOption(cnt.Id,cnt.Name));
        	}
        }
        return options;
    }
    
    public PageReference clear() {
        opp.BillToContact__c = null;
        opp.Manager__c = opp.Manager__c;
        update opp;
        PageReference pageRef = new PageReference('/' + opp.Id);
        return pageRef;
    }
    
    public PageReference cancel() {
        opp.BillToContact__c = opp.BillToContact__c;
        opp.Manager__c = opp.Manager__c;
        PageReference pageRef = new PageReference('/' + opp.Id);
        return pageRef;
    }

    public PageReference save() {
        opp.BillToContact__c = (Id) billContact;
        opp.Manager__c = opp.Manager__c;
        update opp;
        PageReference pageRef = new PageReference('/' + opp.Id);
        return pageRef;
    }
}