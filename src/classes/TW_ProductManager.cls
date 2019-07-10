/**
 * Created by BRITENET on 09.07.2019.
 */

public with sharing class TW_ProductManager {

    @AuraEnabled
    public static TW_Utils.TW_ProductList getProductList(List<String> parameters) {
        TW_Utils.TW_ProductList searchedProducts = TW_ProductService.getProductList(parameters);
        return searchedProducts;
    }

}