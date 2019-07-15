/**
 * Created by BRITENET on 11.07.2019.
 */

public with sharing class TW_ProductServiceHelper {

    public static Map<String, PricebookEntry> segregatePricebookEntriesToArrays(List<PricebookEntry> pricebookList){
        Map<String, PricebookEntry> pricebookMap = new Map<String, PricebookEntry>();
        for(PricebookEntry pb : pricebookList){
            pricebookMap.put(pb.Product2Id,pb);
        }
        return pricebookMap;
    }

    public static OrderItem prepareOrderItem(String orderId, String productId, Integer quantity, String pricebookId, Decimal unitPrice){
        OrderItem item = new OrderItem();
        item.OrderId = orderId;
        item.Product2Id = productId;
        item.PricebookEntryId = pricebookId;
        item.Quantity = quantity;
        item.UnitPrice = unitPrice;
        return item;
    }

    public static Order createOrderForUser(String standardPriceBook) {
        Order ord = new Order();
        ord.Pricebook2Id = standardPriceBook;
        ord.AccountId = TW_AccountHandler.getCommunityCustomerAccountIdByEmail();
        ord.EndDate = Date.today().addDays(30);
        ord.Status = 'Order Placed';
        ord.EffectiveDate = Date.today();
        String OrderId = TW_OrderHandler.createOrder(ord);
        return ord;
    }

    public static List<PricebookEntry> getLowestPricesForPricebookEntries(List<PricebookEntry> entries) {
        List<PricebookEntry> resultList = new List<PricebookEntry>();
        for (PricebookEntry entry : entries) {
            if (!resultList.isEmpty()) {
                if (entry.Product2Id != resultList.get(resultList.size() - 1).Product2Id) {
                    resultList.add(entry);
                } else {
                    if (entry.UnitPrice < resultList.get(resultList.size() - 1).UnitPrice) {
                        resultList.get(resultList.size() - 1).UnitPrice = entry.UnitPrice;
                    }
                }
            } else {
                resultList.add(entry);
            }
        }
        return resultList;
    }

    public static List< TW_Utils.TW_ProductWrapper> addItemsToWrappers(List<PricebookEntry> entries) {
        List<TW_Utils.TW_ProductWrapper> wrapList = new List<TW_Utils.TW_ProductWrapper>();
        for (PricebookEntry entry : entries) {
            if (!wrapList.isEmpty()) {
                if (entry.Product2.Id != wrapList.get(wrapList.size() - 1).product.Id) {
                    wrapList.add(new TW_Utils.TW_ProductWrapper(entry.Product2, Integer.valueOf(entry.UnitPrice), Integer.valueOf(entry.UnitPrice)));
                } else {
                    if (Integer.valueOf(entry.UnitPrice) < wrapList.get(wrapList.size() - 1).currentPrice) {
                        wrapList.get(wrapList.size() - 1).currentPrice = Integer.valueOf(entry.UnitPrice);
                    }
                }
            } else {
                wrapList.add(new TW_Utils.TW_ProductWrapper(entry.Product2, Integer.valueOf(entry.UnitPrice), Integer.valueOf(entry.UnitPrice)));
            }
        }
        return wrapList;
    }

    public static String getOrgBaseUrl() {
        return TW_Message__c.getInstance('TW_OrgBaseUrl').Value__c;
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
        for (String param : parameters){
            Id recordId = Id.valueOf(param);
            returnIdList.add(recordId);
        }
        return returnIdList;
    }

    public static String getUserId() {
        return UserInfo.getUserId();
    }

}