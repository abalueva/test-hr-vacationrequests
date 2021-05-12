public class requestListItemController {
	@AuraEnabled(cacheable=true)
	public static Boolean showRemoveSubmit(VacationRequest__c vr) {
	if (vr.Status__c == 'New' && vr.CreatedById == UserInfo.getUserId())
		return true;
	else
		return false;
	}

	@AuraEnabled(cacheable=true)
	public static Boolean showApprove(VacationRequest__c vr) {
		if (vr.Status__c == 'Submitted' && vr.Manager__r.Id == UserInfo.getUserId())
			return true;
		else
			return false;
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
	public static String getColor(String Status) {
		return Status.toLowerCase()+'-color';
	}
}