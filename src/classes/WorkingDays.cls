/**
* Returns number of working days.
*/
public class WorkingDays {
    
    public BusinessHours wDays;
    
    //Constructor to specify Business Hours schedule
    public WorkingDays(String organizationBusinessHoursName) {
        wDays = [SELECT Id FROM BusinessHours WHERE Name =:organizationBusinessHoursName];
    }
    
    //Takes default schedule if no schedule is specified 
    public WorkingDays(){
        wDays = [SELECT Id FROM BusinessHours WHERE IsDefault = true];
    }
    /**
	* Return number of working days between two dates excluding both days. (Saturday and Sunday is non-working days)
	* @param startDate DateTime class parameter which represent start Date.
	* @param endDate DateTime class parameter which represent end Date.
	* @return count Integer number of working days.
	*/
    public Integer numberOfWorkingDays (DateTime startDate, DateTime endDate) {
        Integer count = 0;
        startDate = startDate.addDays(1);
        while (startDate < endDate){
            if (BusinessHours.isWithin(wDays.Id, startDate)){
                count++;
            }
            startDate = startDate.addDays(1);
        }
        return count;
    }

}