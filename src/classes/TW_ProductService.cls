/**
 * Created by BRITENET on 09.07.2019.
 */

public with sharing class TW_ProductService {

    public static TW_Utils.TW_ProductList getProductList(List<String> parameters){
        List<PricebookEntry> pricebookEntries = TW_ProductHandler.getPricebookEntries(TW_ProductServiceHelper.prepareParametersForQuery(parameters));
        List< TW_Utils.TW_ProductWrapper> wrapList = TW_ProductServiceHelper.addItemsToWrappers(pricebookEntries);
        String orgBaseUrl = TW_ProductServiceHelper.getOrgBaseUrl();
        TW_Utils.TW_ProductList products = new TW_Utils.TW_ProductList(orgBaseUrl,wrapList);
        return products;
    }
}