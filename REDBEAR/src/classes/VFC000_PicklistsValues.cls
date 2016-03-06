public with sharing class VFC000_PicklistsValues{
    private Set<String> usefulStandardObjects;
    private Set<String> uselessCustomObjects;
    
  	public list<ObjectClass> objectList{get;set;}
    public Set<String> objectNames{get;set;}
    public final Integer numberOfObjects;
	
    public string isIterationDone{get;set;}

    public string xmlheader {get;set;}
 	public string endfile{get;set;}

     
  	public VFC000_PicklistsValues() {
        usefulStandardObjects = new Set<String>{'Account', 'Case', 'Contact', 'Contract', 'Product', 'Pricebook', 'Task', 'Event'};
        uselessCustomObjects = new Set<String>{};
        objectList  = new list<objectClass> ();
        objectNames= new Set<String>();

        list<schema.sObjectType> allObjects = Schema.getGlobalDescribe().Values();
        numberOfObjects = allObjects.size();
        isIterationDone = 'No';

        xmlheader ='<?xml version="1.0" ?><?mso-application progid="Excel.Sheet"?>';
        endfile = '</Workbook>';
      	objectList();
  	}

  	public void objectList(){
        for(Schema.SObjectType oneObject : Schema.getGlobalDescribe().Values()){
            if(!objectNames.contains(oneObject.getDescribe().getName())){
                objectNames.add(oneObject.getDescribe().getName());
                // If Custom Object
                if(oneObject.getDescribe().isCustom() && (oneObject.getDescribe().isCustomSetting()==false) && (oneObject.getDescribe().getName().contains('__c')==true) && !(uselessCustomObjects.contains(oneObject.getDescribe().getName()))){
                       ObjectClass obj = new ObjectClass(oneObject.getDescribe().getLabel().replace('/','-'), oneObject.getDescribe().getName(), oneObject.getDescribe().fields.getMap());
                       if(obj.hasPicklists){
                           objectList.add(obj);
                       }
                }else{
                    if(usefulStandardObjects.contains(oneObject.getDescribe().getName())){
                        ObjectClass obj = new objectClass(oneObject.getDescribe().getLabel().replace('/','-'), oneObject.getDescribe().getName(), oneObject.getDescribe().fields.getMap());
                        if(obj.hasPicklists){
                           objectList.add(obj);
                       }
                   	}
                }
            }
        }
    }
  
    public class ObjectClass{
        public Boolean hasPicklists{get;set;}
        public String label{get;set;}
        public String apiName{get;set;}
        public List<Schema.SObjectField> fields{get; set;}
        public Map<String, List<Schema.PicklistEntry>> pickListValuesMap{get;set;}
        
        public ObjectClass(string lab, string api, Map <String, Schema.SObjectField> fieldMap){
            this.fields = fieldMap.Values();
            this.hasPicklists = false;
            // Maximum 31 caracters in Workbook Name
            if(lab.length()>31){
                this.label = lab.substring(0, 31);
            }else{
                this.label = lab;
            } 
            if(api.length()>31){
                this.apiName = api.substring(0, 31);
            }else{
                this.apiName = api;
            } 
            this.pickListValuesMap = new Map<String,List<Schema.PicklistEntry>>();
            for (Schema.SObjectField field: this.fields){
                if (String.valueOf(field.getDescribe().getType()) =='PICKLIST' || String.valueOf(field.getDescribe().getType()) =='MultiPicklist'){
                    this.hasPicklists = true;
                    this.pickListValuesMap.put(field.getDescribe().getLabel(),field.getDescribe().getPicklistValues());
                }            
            }
        }
    }
}