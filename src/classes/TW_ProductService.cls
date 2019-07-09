/**
 * Created by BRITENET on 09.07.2019.
 */

public with sharing class TW_ProductService {

    public static List<TW_ProductWrapper> getProductList(){
        List<PricebookEntry> pricebookEntries = TW_ProductHandler.getPricebookEntries();
        List<TW_ProductWrapper> wrapList = addItemsToWrappers(pricebookEntries);

        for (TW_ProductWrapper wrapElement : wrapList){
            System.debug(wrapElement.product.Name+' '+wrapElement.originalPrice+' '+wrapElement.currentPrice);
        }
        return wrapList;
    }


    private static List<TW_ProductWrapper> addItemsToWrappers(List<PricebookEntry> entries){
        List<TW_ProductWrapper> wrapList = new List<TW_ProductWrapper>();
        for (PricebookEntry entry : entries){
            if (wrapList.size() > 0){
                if (entry.Product2.Id != wrapList.get(wrapList.size()-1).product.Id){
                    wrapList.add(new TW_ProductWrapper(entry.Product2,Integer.valueOf(entry.UnitPrice),Integer.valueOf(entry.UnitPrice)));
                }else{
                    if(Integer.valueOf(entry.UnitPrice) < wrapList.get(wrapList.size()-1).currentPrice){
                        wrapList.get(wrapList.size()-1).currentPrice = Integer.valueOf(entry.UnitPrice);
                    }
                }
            }else{
                wrapList.add(new TW_ProductWrapper(entry.Product2,Integer.valueOf(entry.UnitPrice),Integer.valueOf(entry.UnitPrice)));
            }


        }

        return wrapList;
    }
}