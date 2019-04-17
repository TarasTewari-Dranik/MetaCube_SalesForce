//Trigger to fire PopulateManagerFieldForOpportunity class when Opportunity is updated
trigger UpdateManagerFieldOnOpportunity on Opportunity (after update) {
    List<Opportunity> updatedOpportunity = Trigger.New;
    PopulateManagerFieldForOpportunity updOppJob = new PopulateManagerFieldForOpportunity(updatedOpportunity);
    ID jobID = System.enqueueJob(updOppJob);
}