public class JSONGenerator {
    private sObject st;
    public JSONGenerator(ApexPages.StandardController controller){
        st = (sObject)controller.getRecord();
    }
    public String getJsonData(){
        Id rId = st.Id;
		DescribeSObjectResult describeResult = rId.getSObjectType().getDescribe();      
		Map<String, Schema.SObjectField> fieldMap = describeResult.fields.getMap();
  
		// Get all of the fields on the object
		Set<String> fieldNames = fieldMap.keySet();
 
		// Build a Dynamic Query String.
		String soqlQuery = ' SELECT ' + string.join (new List<String>(fieldNames), ',') + ' FROM ' + describeResult.getName() + ' Where Id =: rId';
 
		// Need to return a generic list of sObject because we don't necessarily know exactly what the object is.
		List<sObject> record = Database.query(soqlQuery);

     	return JSON.serializePretty(record);
  	}

}