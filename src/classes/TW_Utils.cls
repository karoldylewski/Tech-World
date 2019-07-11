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

    public static Map<String,Integer> segregateIdsToArrays(List<String> parameters){
        Map<String,Integer> itemMap = new Map<String,Integer>();
        for (String str : parameters){
            Integer currentNumber = itemMap.get(str);
            if (currentNumber == null){
                itemMap.put(str,1);
            }else{
                currentNumber +=1;
                itemMap.put(str,currentNumber);
            }
        }
        return itemMap;
    }

    public static List<String> getUniqueIdsFromMap(Map<String,Integer> parameters){
        Set<String> idSet = new Set<String>();
        for (String key : parameters.keySet()){
            idSet.add(key);
        }
        List<String> idList = new List<String>(idSet);
        return idList;
    }

    public static List<Id> convertStringToId(List<String> parameters){
        List<Id> returnIdList = new List<Id>();
        System.debug('Starting conversion from string to ID');
        for (String param : parameters){
            System.debug('Trying to convert string:'+param+'to id');
            Id recordId = Id.valueOf(param);
            returnIdList.add(recordId);
        }
        return returnIdList;
    }
//
//    public static generateQueryPartForSoql(List<String> parameters){
//        String result;
//        for (String param : parameters){
//            result = 'Parent2.Id = '+param;
//        }
//
//    }
}