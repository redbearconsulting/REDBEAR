@isTest
private class AccountManagerTest {
	
	@isTest(SeeAllData=true)
	static void test_method_one() {
		//Id recordId = createTestRecord();
		Id recordId ='0012400000EcjfzAAB';
		system.debug('## id : '+recordId);
		// Implement test code
		RestRequest request = new RestRequest();
        request.requestUri =
            'https://eu5.salesforce.com/services/apexrest/Accounts/'
            + recordId+'/contacts';
        system.debug('## id : request'+request);
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account thisAccount = AccountManager.getAccount();
	}

	
	// Helper method
    static Id createTestRecord() {
        // Create test record
        Account accountTest = new Account(
            Name='Test record'
            );
        insert accountTest;
        Contact contactTest = new Contact(
            FirstName='Test record contact',
            LastName='Test record contact',
            AccountId=accountTest.Id
            );
        system.debug('## contact : '+contactTest);
        insert contactTest;
        system.debug('## contact : '+contactTest.Id);
        return accountTest.Id;
    } 
	
}