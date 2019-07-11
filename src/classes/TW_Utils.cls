/**
 * Created by BRITENET on 09.07.2019.
 */

public with sharing class TW_Utils {

    public with sharing class TW_ProductWrapper {
        @AuraEnabled
        public Product2 product {get; set;}
        @AuraEnabled
        public Integer originalPrice {get; set;}
        @AuraEnabled
        public Integer currentPrice {get; set;}
        @AuraEnabled
        public String imageId {get; set;}
        @AuraEnabled
        public String orgId {get; set;}
        @AuraEnabled
        public Integer count {get; set;}
        public TW_ProductWrapper(Product2 product, Integer orgPrice, Integer currPrice){
            this.product = product;
            this.originalPrice = orgPrice;
            this.currentPrice = currPrice;
        }
    }

    public with sharing class TW_ProductList {
        @AuraEnabled
        public String orgBaseUrl {get; set;}
        @AuraEnabled
        public List<TW_ProductWrapper> products {get; set;}
        public TW_ProductList(String orgUrl, List<TW_ProductWrapper> items){
            this.orgBaseUrl = orgUrl;
            this.products = items;
        }
        public TW_ProductList(){
        }
    }

}