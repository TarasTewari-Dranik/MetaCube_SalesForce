/**Check if BillToContact field is not Blank and Manager is Blank then populate Manager field by related account which is linked with the contact given in BillToContact field.
 * 
 */
public class PopulateManagerFieldForOpportunity implements Queueable {
    private List<Opportunity> opportunities;
    
    public PopulateManagerFieldForOpportunity(List<Opportunity> records){
        this.opportunities = [SELECT Id,BillToContact__r.AccountId,Manager__c FROM Opportunity WHERE Id IN :records AND BillToContact__c !=null AND Manager__c = null];
    }
    
    public void execute (QueueableContext context) {
        if (!opportunities.isEmpty()) {
            for(Opportunity opp:opportunities){
                    opp.Manager__c = opp.BillToContact__r.AccountId;
            }
            update opportunities;
        }
    }
}