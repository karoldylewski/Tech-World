/**
 * Created by BRITENET on 09.07.2019.
 */

public with sharing class TW_ProductManager {

    @AuraEnabled
    public static Boolean placeOrder(List<String> productsId) {
        Boolean response = TW_ProductService.addProductsToOrder(productsId);
        return true;
    }
}