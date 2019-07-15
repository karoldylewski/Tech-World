/**
 * Created by BRITENET on 09.07.2019.
 */

public with sharing class TW_ProductManager {

    @AuraEnabled
    public static Boolean placeOrder(List<String> productsId) {
        return TW_ProductService.addProductsToOrder(productsId);
    }
}