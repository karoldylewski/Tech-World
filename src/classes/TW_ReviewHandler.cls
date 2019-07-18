/**
 * Created by BRITENET on 12.07.2019.
 */

public with sharing class TW_ReviewHandler {

    public static List<TW_Product_Review__c> getReviewsForProduct(String itemId) {
        List<TW_Product_Review__c> resultList = [
                SELECT Id,Content__c, Product__c, Rating__c, CreatedBy.Name, CreatedDate
                FROM TW_Product_Review__c
                WHERE Product__c =: itemId
                ORDER BY CreatedDate DESC
        ];
        return resultList;
    }

    public static Boolean checkIfUserHasCommented(String itemId, String userId) {
        List<TW_Product_Review__c> resultList = [
                SELECT Id
                FROM TW_Product_Review__c
                WHERE Product__c =: itemId
                AND CreatedBy.Id =: userId
        ];
        if (resultList.isEmpty()){
            return false;
        }else{
            return true;
        }
    }
}