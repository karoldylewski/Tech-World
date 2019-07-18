/**
 * Created by BRITENET on 09.07.2019.
 */

public with sharing class TW_ProductHandler {

    public static List<PricebookEntry> getPricebookEntries(List<String> parameters) {
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
                        UnitPrice
                FROM PricebookEntry
                WHERE Product2.RecordType.DeveloperName = 'TW_Product'
                AND Pricebook2.TW_StartDate__c <= TODAY
                AND Pricebook2.TW_EndDate__c >= TODAY
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
                AND Pricebook2.TW_StartDate__c <= TODAY
                AND Pricebook2.TW_EndDate__c >= TODAY
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
                AND Pricebook2.TW_StartDate__c <= TODAY
                AND Pricebook2.TW_EndDate__c >= TODAY
                ORDER BY Product2.Id, UnitPrice DESC
        ];
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

    public static List<PricebookEntry> getPricebookEntriesForPricebook(String pricebookId) {
        List<PricebookEntry> resultList = [
                SELECT Product2.Name,UnitPrice, Pricebook2Id
                FROM PricebookEntry
                WHERE Product2.RecordType.DeveloperName = 'TW_Product'
                AND Pricebook2Id =: pricebookId
        ];
        return resultList;
    }

    public static List<PricebookEntry> getAllProducts(String standardPriceBookId){
        List<PricebookEntry> products = [
                SELECT Id, Name, UnitPrice
                FROM PricebookEntry
                WHERE Pricebook2Id = :standardPriceBookId
                AND Product2.RecordType.DeveloperName = 'TW_Product'
        ];
        return products;
    }

    public static List<PricebookEntry> getPricebookEntriesForPricebook(List<String> pricebookIds,List<String> productsIds) {
        List<PricebookEntry> resultList = [
                SELECT Product2.RecordType.DeveloperName,
                        Product2.Id,
                        Product2.Name,
                        UnitPrice
                FROM PricebookEntry
                WHERE Product2.RecordType.DeveloperName = 'TW_Product'
                AND Pricebook2Id IN : pricebookIds
                AND Product2Id IN : productsIds
                ORDER BY Product2.Id, UnitPrice DESC
        ];
        return resultList;
    }

    public static List<PricebookEntry> getPricebookEntriesForCustomPricebook(String customPricebookId) {
        List<PricebookEntry> resultList = [
                SELECT Product2.Id
                FROM PricebookEntry
                WHERE Product2.RecordType.DeveloperName = 'TW_Product'
                AND Pricebook2Id =: customPricebookId
        ];
        return resultList;
    }

    public static String getLatestProduct() {
        List<Product2> resultList = [
                SELECT Id
                FROM Product2
                WHERE RecordType.DeveloperName = 'TW_Product'
                ORDER BY CreatedDate DESC
                LIMIT 1
        ];
        return resultList[0].Id;
    }
}