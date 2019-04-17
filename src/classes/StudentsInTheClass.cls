/**
 * Retrieve Students list from the class
 */
public class StudentsInTheClass {
    /**
	* Returns all names of the students in the class as a list.
 	* @param classId Id of the class.
 	* @return studentsNames List of strings with names of the students in the classId
 	*/
    public static List<String> studentsNameList (Id classId){
        List<String> studentsNames = new List<String>();
        for (Student__c students:[SELECT Name,FirstName__c FROM Student__c WHERE Class__c =:classId]){
            studentsNames.add(String.valueOf(students.Name+' '+students.FirstName__c));
        }
        return studentsNames;
    }
    
    /**
	* Create a map where key is class and value is set of students Id in it.
 	* @param 
 	* @return mapOfClassesAndStudents Map where key is Class Ids and value is a set of Student Ids in that class
 	*/
    public Map<Id,Set<Id>> studentsListInTheClasses(){
        List<Class__c> classesWithStudents = [SELECT Id,(SELECT Id FROM Students__r) FROM Class__c WHERE NumberOfStudents__c !=null];
        Map<Id,Set<Id>> mapOfClassesAndStudents = new Map<Id,Set<Id>>();
        for (Class__c classes:classesWithStudents){
            Set<Id> studentsSet = new Set<Id>();
            for(Student__c st:classes.Students__r){
                studentsSet.add(st.Id);
            }
            mapOfClassesAndStudents.put(classes.Id, studentsSet);
        }
        return mapOfClassesAndStudents;
    }
    

}