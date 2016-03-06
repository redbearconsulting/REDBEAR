public with sharing class AccountHandler {
	public static Account insertNewAccount(String param) {
		Account acc;
		if(param == null || param == ''){
			return null;
		}
		try{
			acc = new Account(Name=param);
			insert acc;

		}catch(Exception e){
			System.debug('A DML exception has occurred: ' +
                e.getMessage());

		}
		return acc;
	}
}