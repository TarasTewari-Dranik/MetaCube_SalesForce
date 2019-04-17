/**
* Create a class which show the list of all sobjects exists in org.
*/
public class AllsObjects {
    public static List<String> getAllSObjects(){
    	List<String> sObjectList = new List<String>();
    	for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values()){
        	Schema.DescribeSObjectResult describeSObjectResultObj = objTyp.getDescribe();
            String name = objTyp.getDescribe().getName();
            if(!name.containsignorecase('history') && !name.containsignorecase('tag')&&
             !name.containsignorecase('share') && !name.containsignorecase('feed')) {
                sObjectList.add(name);
            }
        }
    	system.debug('All SObjectList' + sObjectList);
    	return sObjectList;
	}
}