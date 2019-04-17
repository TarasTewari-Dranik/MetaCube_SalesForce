/**
 * Create a Scheduler to mail to Opportunity Owner, if not modified for last 30 days.
 */
global class EmailReminderForOpportunityNotModified implements Schedulable {
    global void execute (SchedulableContext ctx) {
        //List of Opportunities which were not modified for last 30 days
        List<Opportunity> opptys = [SELECT Id,Name,OwnerID,LastModifiedDate FROM Opportunity WHERE LastModifiedDate < LAST_N_DAYS:30 AND IsClosed = false];
        //List of emails to the Owners of Opportunities
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        //Create emails.
        for (Opportunity opt:opptys){
            Messaging.SingleEmailMessage singleMail = new Messaging.SingleEmailMessage();
            singleMail.setTargetObjectId(opt.OwnerID);
            singleMail.setReplyTo('draniktaras@gmail.com');
            singleMail.setSenderDisplayName('CloudTeam Support');
            singleMail.setSubject('Opportunity is required your attention ' + opt.Name);
            singleMail.setSaveAsActivity(false);
            singleMail.setPlainTextBody('Your Opportunity: ' + opt.Name +' was not modified for more than 30 days');
            singleMail.setHtmlBody('Please adjust your Opportunity ' + opt.Name +' .'+
     'To view your Opportunity  <a href=https://eu19.lightning.force.com/lightning/r/Opportunity/'+opt.Id+'/view>click here.</a>');
            emails.add(singleMail);
        }

        Messaging.sendEmail(emails);
    }

}