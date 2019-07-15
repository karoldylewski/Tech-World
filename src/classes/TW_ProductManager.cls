/**
 * Created by BRITENET on 09.07.2019.
 */

public with sharing class TW_ProductManager {
    @AuraEnabled
    public static List<TW_Product_Review__c> getReviewItems(String productId) {
        List<TW_Product_Review__c> reviewItems = TW_ProductService.getProductReviews(productId);
        return reviewItems;
    }
    @AuraEnabled
    public static Boolean checkIfUserCanReview(String productId) {
        return TW_ProductService.checkIfUserCanReview(productId);
    }
}