/**
 * Created by BRITENET on 11.07.2019.
 */

public with sharing class TW_ProductServiceHelper {

    public static List< TW_Utils.TW_ProductWrapper> addItemsToWrappers(List<PricebookEntry> entries){
        List<TW_Utils.TW_ProductWrapper> wrapList = new List<TW_Utils.TW_ProductWrapper>();
        for (PricebookEntry entry : entries){
            if (!wrapList.isEmpty()){
                if (entry.Product2.Id != wrapList.get(wrapList.size()-1).product.Id){
                    wrapList.add(new  TW_Utils.TW_ProductWrapper(entry.Product2,Integer.valueOf(entry.UnitPrice),Integer.valueOf(entry.UnitPrice)));
                }else{
                    if(Integer.valueOf(entry.UnitPrice) < wrapList.get(wrapList.size()-1).currentPrice){
                        wrapList.get(wrapList.size()-1).currentPrice = Integer.valueOf(entry.UnitPrice);
                    }
                }
            }else{
                wrapList.add(new TW_Utils.TW_ProductWrapper(entry.Product2,Integer.valueOf(entry.UnitPrice),Integer.valueOf(entry.UnitPrice)));
            }
        }
        return wrapList;
    }

    public static String getOrgBaseUrl(){
        return TW_Message__c.getInstance('TW_OrgBaseUrl').Value__c;
    }

    public static List<String> prepareParametersForQuery(List<String> parameters){
        List<String> modifiedParams = new List<String>();
        for (String param : parameters){
            modifiedParams.add('%'+param+'%');
        }
        return modifiedParams;
    }
}