@isTest
private class ParkLocatorTest {
	
	@isTest static void testCallout() {    
		// This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new ParkServiceMock());

		String[] parks = ParkLocator.country('Germany');
    }

	
}