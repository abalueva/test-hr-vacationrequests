public class vrController {
	@AuraEnabled(cacheable=true)
	public static List<VacationRequest__c> getRequestList() {
		return [
				SELECT Id, Name, CreatedBy.Name, RequestType__c, StartDate__c, EndDate__c, WorkingDays__c, Status__c, Manager__r.Name
				FROM VacationRequest__c
		];
	}

	@AuraEnabled(cacheable=true)
	public static List<VacationRequest__c> getOnlyMyList() {
		return [
				SELECT Id, CreatedById, CreatedBy.Name, RequestType__c, StartDate__c, EndDate__c, WorkingDays__c, Status__c, Manager__r.Name
				FROM VacationRequest__c
				WHERE CreatedById=:UserInfo.getUserId()
		];
	}

	@AuraEnabled(cacheable=true)
	public static String NoManager() {
		User managerId = [
				SELECT Id, ManagerId
				FROM User
				WHERE Id=:UserInfo.getUserId()
		];
		if (managerId.ManagerId == null) {
			return null;
		}
		return managerId.ManagerId;
	}

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

	@AuraEnabled
	public static void vrRemove(String vrName) {
		VacationRequest__c vrToRemove = [
				SELECT Name
				FROM VacationRequest__c
				WHERE Name =: vrName];
		delete vrToRemove;
	}

	@AuraEnabled
	public static void vrSubmit(String vrName) {
		VacationRequest__c vrToSubmit = [
				SELECT Name, Status__c
				FROM VacationRequest__c
				WHERE Name =: vrName];
		vrToSubmit.Status__c = 'Submitted';
		 update vrToSubmit;
	}

	@AuraEnabled
	public static void vrApprove(String vrName) {
		VacationRequest__c vrToApprove = [
				SELECT Name, Status__c
				FROM VacationRequest__c
				WHERE Name =: vrName];
		vrToApprove.Status__c = 'Approved';
		update vrToApprove;
	}

	@AuraEnabled(cacheable=true)
	public static String getUserId() {
		return UserInfo.getUserId();
	}
}