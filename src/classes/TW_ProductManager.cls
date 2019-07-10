/**
 * Created by BRITENET on 09.07.2019.
 */

public with sharing class TW_ProductManager {

    @AuraEnabled
    public static TW_Utils.TW_ProductList getProductList(List<String> parameters) {
        TW_Utils.TW_ProductList searchedProducts = TW_ProductService.getProductList(parameters);
        return searchedProducts;
    }

    @AuraEnabled
    public static TW_Utils.TW_ProductWrapper getProductDetails(String productId) {
        System.debug('inside apex method;');
        TW_Utils.TW_ProductWrapper item = TW_ProductService.getProductDetails(productId);
        return item;
    }

}