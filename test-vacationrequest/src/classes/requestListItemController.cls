public class requestListItemController {
	// show Remove and Submit Buttons
	@AuraEnabled(cacheable=true)
	public static Boolean showRemoveSubmit(VacationRequest__c vr) {
	if (vr.Status__c == 'New' && vr.CreatedById == UserInfo.getUserId())
		return true;
	else
		return false;
	}

	// show Approve Button
	@AuraEnabled(cacheable=true)
	public static Boolean showApprove(VacationRequest__c vr) {
		if (vr.Status__c == 'Submitted' && vr.Manager__r.Id == UserInfo.getUserId())
			return true;
		else
			return false;
	}

	// Remove record
	@AuraEnabled
	public static void vrRemove(VacationRequest__c vrToRemove) {
		delete vrToRemove;
	}

	// Submit record
	@AuraEnabled
	public static void vrSubmit(VacationRequest__c vrToSubmit) {
		vrToSubmit.Status__c = 'Submitted';
		update vrToSubmit;
	}

	// Approve record
	@AuraEnabled
	public static void vrApprove(VacationRequest__c vrToApprove) {
		vrToApprove.Status__c = 'Approved';
		update vrToApprove;
	}

	// get background color of a request based on Status
	@AuraEnabled(cacheable=true)
	public static String getColor(String Status) {
		return Status.toLowerCase()+'-color';
	}
}