/**
 * Create a class and a static function which takes a ContactID as argument and check if Account’s ContactIDs field is Null or Not Null
 * IF Null, then fetch all related Account Contacts and store their IDs as a comma separated list in it.
 * IF Not Null, then check, Is ContactID already exist in the field value, if not then append it on that value.
 */

public class AccountRelatedContactIDsList {
    public static void contactIDsList(ID newContactId){
        Contact relatedAccount = [SELECT AccountId,Account.ContactIDs__c FROM Contact WHERE Id =:newContactId];
        if (relatedAccount.Account.ContactIDs__c == null){
            List<String> allContacts = new List<String>();
            for (Contact cnt:[SELECT Id FROM Contact WHERE AccountID = :relatedAccount.AccountId]){
                allContacts.add(cnt.Id);
            }
            String contacts = String.join(allContacts, ', ');
            Account accountWithRelatedContactList = new Account(Id = relatedAccount.AccountId, ContactIDs__c = contacts);
            update accountWithRelatedContactList;
        } else if (!relatedAccount.Account.ContactIDs__c.contains(newContactId)) {
            String contacts = relatedAccount.Account.ContactIDs__c+', '+newContactId;
            Account accountWithRelatedContactList = new Account(Id = relatedAccount.AccountId, ContactIDs__c = contacts);
            update accountWithRelatedContactList;
        }
    }

}