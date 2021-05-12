trigger newRecord on VacationRequest__c (before insert) {
	for(VacationRequest__c vr : Trigger.new) {
		vr.Status__c = 'New';
		Integer workingDays = vrController.CalculateWorkingDays(vr.StartDate__c,vr.EndDate__c);
		vr.WorkingDays__c = workingDays;
		User managerId = [SELECT Id, ManagerId FROM User WHERE Id=:UserInfo.getUserId()];
		vr.Manager__c = managerId.ManagerId;
	}
}