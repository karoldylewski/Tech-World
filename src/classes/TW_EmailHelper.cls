/**
 * Created by BRITENET on 19.06.2019.
 */

public with sharing class TW_EmailHelper {

    public static String getEmailBody(String csName, List<String> params) {
        TW_Message__c myCS = TW_Message__c.getInstance(csName);
        return String.format(myCS.Value__c,params);
    }

    public static String getEmailSubject(String csName) {
        TW_Message__c myCS = TW_Message__c.getInstance(csName);
        return myCS.Value__c;
    }

    public static List<User> getUserManager (String userId){
        List<User> manager = [SELECT Id, Manager.Email,Manager.Name FROM User WHERE Id=:userId];
        return manager;
    }

    public static String getInstanceUrl(){
        return System.URL.getSalesforceBaseUrl().toExternalForm();
    }

}