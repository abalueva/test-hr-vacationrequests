@isTest
public class testController {
	@isTest static void getColorTest() {
		String new_output = requestListItemController.getColor('New');
		System.assertEquals('new-color', new_output);

		String submitted_output = requestListItemController.getColor('Submitted');
		System.assertEquals('submitted-color', submitted_output);

		String approved_output = requestListItemController.getColor('Approved');
		System.assertEquals('approved-color', approved_output);
	}
}