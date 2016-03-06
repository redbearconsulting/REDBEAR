@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {


	@HttpGet
    global static Account getAccount() {
    	Account result = new Account();
    	RestRequest request = RestContext.request;

    	String accountId = request.requestURI.substringBetween('Accounts/', '/contacts');
    	system.debug('## accountId : '+accountId);

    	result = [Select Id, Name, (Select Id, Name from Contacts) from Account where Id =:accountId];

		system.debug('## result : '+result);
		return result;

    }
}