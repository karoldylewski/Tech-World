/**
 * Created by BRITENET on 09.07.2019.
 */

public with sharing class TW_ProductHandler {

    public static List<PricebookEntry> getPricebookEntries(List<String> parameters) {
        List<PricebookEntry> resultList = [
                SELECT Product2.RecordType.DeveloperName,
                        Product2.Id,
                        Product2.Name,
                        Product2.ImageId__c,
                        UnitPrice
                FROM PricebookEntry
                WHERE Product2.RecordType.DeveloperName = 'TW_Product'
                AND Name
                        LIKE :parameters
                ORDER BY Product2.Id, UnitPrice DESC
        ];
        return resultList;
    }

    public static List<PricebookEntry> getPricebookEntriesForId(String itemId) {
        List<PricebookEntry> resultList = [
                SELECT Product2.RecordType.DeveloperName,
                        Product2.Id,
                        Product2.Name,
                        Product2.Camera__c,
                        Product2.RAM__c,
                        Product2.Battery_capacity__c,
                        Product2.Cellular__c,
                        Product2.Screen_size__c,
                        Product2.ImageId__c,
                        Product2.Description__c,
                        UnitPrice
                FROM PricebookEntry
                WHERE Product2.RecordType.DeveloperName = 'TW_Product'
                AND Product2.Id =: itemId
                ORDER BY Product2.Id, UnitPrice DESC
        ];
        return resultList;
    }

    public static List<PricebookEntry> getPricebookEntriesForMultipleId(List<String> itemId) {
        List<PricebookEntry> resultList = [
                SELECT Product2.RecordType.DeveloperName,
                        Product2.Id,
                        Product2.Name,
                        Product2.Camera__c,
                        Product2.RAM__c,
                        Product2.Battery_capacity__c,
                        Product2.Cellular__c,
                        Product2.Screen_size__c,
                        Product2.ImageId__c,
                        Product2.Description__c,
                        UnitPrice
                FROM PricebookEntry
                WHERE Product2.Id IN : itemId
                ORDER BY Product2.Id, UnitPrice DESC
        ];
        System.debug('parameters for soql: '+itemId);
        System.debug('Result for multiple ids: '+resultList.size());
        return resultList;
    }

    public static List<PricebookEntry> getPricebookEntriesForOrder(List<String> itemId) {
        List<PricebookEntry> resultList = [
                SELECT Product2.Id,UnitPrice, Pricebook2Id
                FROM PricebookEntry
                WHERE Product2.Id IN : itemId
                ORDER BY Product2.Id, UnitPrice DESC
        ];
        return resultList;
    }
}