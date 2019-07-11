/**
 * Created by BRITENET on 09.07.2019.
 */

public with sharing class TW_ProductWrapper {
    @AuraEnabled
    public Product2 product {get; set;}
    @AuraEnabled
    public Integer originalPrice {get; set;}
    @AuraEnabled
    public Integer currentPrice {get; set;}
    @AuraEnabled
    public String imageId {get; set;}
    public TW_ProductWrapper(Product2 product, Integer orgPrice, Integer currPrice){
        this.product = product;
        this.originalPrice = orgPrice;
        this.currentPrice = currPrice;
    }
}