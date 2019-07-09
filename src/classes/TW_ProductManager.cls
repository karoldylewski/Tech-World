/**
 * Created by BRITENET on 09.07.2019.
 */

public with sharing class TW_ProductManager {

    @AuraEnabled
    public static List<TW_ProductWrapper> getProductList() {
        List<TW_ProductWrapper> wrapList = TW_ProductService.getProductList();
        return wrapList;
    }

}