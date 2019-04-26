/*
In Opportunity, If the stage is changed from another value  to CLOSED_WON or CLOSED_LOST, populates the Close Date field with Today().

*/
trigger PopulatesCloseDateIfClosed on Opportunity (before update,after insert) {
    for(Opportunity op:Trigger.New){
        if (Trigger.isUpdate && Trigger.oldMap.get(op.Id).StageName != Trigger.newMap.get(op.Id).StageName && op.StageName.contains('Closed')){
           		 op.CloseDate = Date.today();
        }
        if(Trigger.isInsert && op.StageName.contains('Closed')){
            op.CloseDate = Date.today();
        }
    }
}