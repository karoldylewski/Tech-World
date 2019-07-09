/**
 * Created by BRITENET on 09.07.2019.
 */

public with sharing class TW_ProductHandler {

    public static List<PricebookEntry> getPricebookEntries(){
        String query = 'SELECT Product2.Id, Product2.Name, Product2.Camera__c, Product2.RAM__c, Product2.Battery_capacity__c, Product2.Cellular__c, Product2.Screen_size__c,  UnitPrice FROM PricebookEntry ORDER BY Product2.Id';
        List<PricebookEntry> resultList = Database.query(query);
        return resultList;
    }

}