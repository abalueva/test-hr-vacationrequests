@isTest
private class testController {
	public static VacationRequest__c vrInsert(User user, String RequestType) {
		VacationRequest__c testVR = new VacationRequest__c(RequestType__c = RequestType,
				StartDate__c = System.today(),
				EndDate__c = System.today() + 6);
		insert testVR;

		VacationRequest__c vr = [
				SELECT Name, CreatedById, IsDeleted, Manager__r.Name, WorkingDays__c, Status__c
				FROM VacationRequest__c
				WHERE CreatedById = :user.Id
		];
		return vr;
	}

	@isTest static void getColorTest() {
		String new_output = requestListItemController.getColor('New');
		System.assertEquals('new-color', new_output);

		String submitted_output = requestListItemController.getColor('Submitted');
		System.assertEquals('submitted-color', submitted_output);

		String approved_output = requestListItemController.getColor('Approved');
		System.assertEquals('approved-color', approved_output);
	}

	@isTest static void noManagerTest() {
		Boolean testNoManagerTrue;
		Boolean testNoManagerFalse;

		User utest = [SELECT Id FROM User WHERE Alias='utest'];
		System.RunAs(utest) {
			System.debug('Checking NoManager() for a user with a manager...');
			testNoManagerFalse = newRequestController.NoManager();
		}
		User tuser = [SELECT Id FROM User WHERE Alias='tuser'];
		System.RunAs(tuser) {
			System.debug('Checking NoManager() for a user without a manager...');
			testNoManagerTrue = newRequestController.NoManager();
		}
		System.assertEquals(true, testNoManagerTrue);
		System.assertEquals(false, testNoManagerFalse);
	}

	@isTest static void CalculateWorkingDaysTest() {
		Decimal WorkingDays = 5;
		Decimal testWorkingDays = newRequestController.CalculateWorkingDays(System.today(), System.today()+6);
		System.assertEquals(WorkingDays, testWorkingDays);
	}

	@isTest static void runInsertTests() {
		Boolean testShowRemoveSubmit;
		Boolean testShowApprove;
		VacationRequest__c vr;
		final String ManagerName = 'Anastasia Balueva';

		User utest = [SELECT Id FROM User WHERE Alias='utest'];
		User abalueva = [SELECT Id FROM User WHERE Alias='abalueva'];
		System.RunAs(utest){

			vr = vrInsert(utest, 'Vacation');
			System.assertEquals(ManagerName, vr.Manager__r.Name);

			// testing Buttons showing
			testShowRemoveSubmit = requestListItemController.showRemoveSubmit(vr);
			testShowApprove = requestListItemController.showApprove(vr);
			System.assertEquals(true, testShowRemoveSubmit);
			System.assertEquals(false, testShowApprove);

			// testing Remove
			requestListItemController.vrRemove(vr);
			VacationRequest__c vrDeleted = [SELECT Id, IsDeleted FROM VacationRequest__c
			WHERE Id = :vr.Id ALL ROWS];
			System.assertEquals(true, vrDeleted.IsDeleted);

			// testing vrSubmit()
			//	create new record -> submit -> switch System.runAs() to manager
			vr = vrInsert(utest, 'Vacation');
			requestListItemController.vrSubmit(vr);
			// testing that Submit and Remove Buttons don't show up after request was submitted
			testShowRemoveSubmit = requestListItemController.showRemoveSubmit(vr);
			System.assertEquals(false, testShowRemoveSubmit);
		}

		System.runAs(abalueva) {
			// testing Approve action and button showing
			testShowApprove = requestListItemController.showApprove(vr);
			System.assertEquals(true, testShowApprove);
			requestListItemController.vrApprove(vr);
			System.assertEquals('Approved', vr.Status__c);
		}
	}
}