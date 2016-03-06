public with sharing class ParkLocator {
	
	public static String[] country(String country) {
		
		ParkService.ParksImplPort request = new ParkService.ParksImplPort();
		String[] parks = request.byCountry(country);
		return parks;
	}
}