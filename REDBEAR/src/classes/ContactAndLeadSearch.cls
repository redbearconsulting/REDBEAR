public with sharing class ContactAndLeadSearch {
	public static List<List< SObject>> searchContactsAndLeads(String searchParam) {
		List<List<sObject>> searchList = [FIND :searchParam IN ALL FIELDS 
                   RETURNING Lead(Id,Name),Contact(Id,Name)];
        return searchList;
	}
}