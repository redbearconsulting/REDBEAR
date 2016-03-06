public with sharing class StringArrayTest {
	
	public static List<String> generateStringArray(Integer n) {

		List<String> myListS = new List<String>();

		if(n != null){
			Integer i = 0;
			do{
				String myS = 'Test '+i;
				myListS.add(myS);
				i++;
			}while(i<n);
		}
		return myListS;
	}
}