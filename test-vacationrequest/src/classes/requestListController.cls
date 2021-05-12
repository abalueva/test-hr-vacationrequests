public class requestListController {
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
}