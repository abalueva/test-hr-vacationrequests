public class newRequestController {
	// get Manager Id to open New Request Form
	@AuraEnabled(cacheable=true)
	public static Boolean NoManager() {
		User managerId = [
				SELECT Id, ManagerId
				FROM User
				WHERE Id=:UserInfo.getUserId()
		];
		if (managerId.ManagerId == null) {
			return true;
		}
		return false;
	}

	// calculate Working Days
	@AuraEnabled(cacheable=true)
	public static Integer CalculateWorkingDays (Date StartDate, Date EndDate) {
		Integer workingDays = 0;

		for(integer i=0; i <= startDate.daysBetween(endDate); i++) {
			Date dt = startDate + i;
			DateTime currDate = DateTime.newInstance(dt.year(), dt.month(), dt.day());
			String todayDay = currDate.format('EEEE');
			if(todayDay != 'Saturday' && todayDay !='Sunday') {
				workingDays = workingDays + 1;
			}
		}
		return workingDays;
	}
}