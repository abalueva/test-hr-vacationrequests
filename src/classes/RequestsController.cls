public class RequestsController {
	@AuraEnabled(cacheable=true)
	public static List<Vacation_Request__c> getRequestList() {
		return [
				SELECT Id, OwnerId, RequestsType__c
				FROM Vacation_Request__c
		];
	}
}