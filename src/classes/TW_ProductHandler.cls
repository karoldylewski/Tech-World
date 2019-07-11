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

}