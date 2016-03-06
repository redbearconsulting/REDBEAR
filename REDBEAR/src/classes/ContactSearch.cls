public with sharing class ContactSearch {
	public static List<Contact> searchForContacts(String lastName, String postalCode) {

		 List<Contact> listContact = [Select Id, Name from Contact where LastName = :lastName and MailingPostalCode = :postalCode];
		 return listContact;
	}
}
