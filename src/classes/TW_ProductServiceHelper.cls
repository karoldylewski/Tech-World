/**
 * Created by BRITENET on 11.07.2019.
 */

public with sharing class TW_ProductServiceHelper {

    public static Map<String, PricebookEntry> segregatePricebookEntriesToArrays(List<PricebookEntry> pricebookList) {
        Map<String, PricebookEntry> pricebookMap = new Map<String, PricebookEntry>();
        for (PricebookEntry pb : pricebookList) {
            pricebookMap.put(pb.Product2Id, pb);
        }
        return pricebookMap;
    }

    public static OrderItem prepareOrderItem(String orderId, String productId, Integer quantity, String pricebookId, Decimal unitPrice) {
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

    public static List<String> prepareParametersForQuery(List<String> parameters) {
        List<String> modifiedParams = new List<String>();
        for (String param : parameters) {
            modifiedParams.add('%' + param + '%');
        }
        return modifiedParams;
    }


    public static Map<String, Integer> segregateIdsToArrays(List<String> parameters) {
        Map<String, Integer> itemMap = new Map<String, Integer>();
        for (String str : parameters) {
            Integer currentNumber = itemMap.get(str);
            if (currentNumber == null) {
                itemMap.put(str, 1);
            } else {
                currentNumber += 1;
                itemMap.put(str, currentNumber);
            }
        }
        return itemMap;
    }

    public static List<String> getUniqueIdsFromMap(Map<String, Integer> parameters) {
        Set<String> idSet = new Set<String>();
        for (String key : parameters.keySet()) {
            idSet.add(key);
        }
        List<String> idList = new List<String>(idSet);
        return idList;
    }

    public static List<Id> convertStringToId(List<String> parameters) {
        List<Id> returnIdList = new List<Id>();
        for (String param : parameters) {
            Id recordId = Id.valueOf(param);
            returnIdList.add(recordId);
        }
        return returnIdList;
    }

    public static String getUserId() {
        return UserInfo.getUserId();
    }

    public static String crateCase(String contactId, String subject, String description) {
        Case newCase = new Case();
        newCase.Origin = 'Web';
        newCase.ContactId = contactId;
        newCase.Subject = subject;
        newCase.Description = description;
        newCase.Status = 'New';
        return TW_CaseHandler.insertCase(newCase);
    }

    public static Boolean crateOrderItemsInCase(String caseId, List<OrderItem> items) {
        List<Products__c> orderItemInCaseList = new List<Products__c>();
        for (OrderItem orderItem : items) {
            Products__c orderItemInCase = new Products__c();
            orderItemInCase.Complaint_Case__c = caseId;
            orderItemInCase.Order_Product__c = orderItem.Id;
            orderItemInCase.Product_Name__c = orderItem.Product2.Name;
            orderItemInCaseList.add(orderItemInCase);
        }
        return TW_CaseHandler.crateOrderItemsInCase(orderItemInCaseList);
    }

    public static String createNewPricebook2(String pricebookName, Date sd, Date ed, Boolean isActive, String pbId) {
        Pricebook2 newPb = new Pricebook2();
        newPb.Name = pricebookName;
        newPb.TW_StartDate__c = sd;
        newPb.TW_EndDate__c = ed;
        newPb.IsActive = isActive;
        if (pbId != null) {
            newPb.Id = pbId;
        }
        return TW_PricebookHandler.createPricebook(newPb);
    }

    public static List<PricebookEntry> createPricebookEntries(List<List<String>> itemsList, String pricebookId) {
        List<PricebookEntry> entriesObject = new List<PricebookEntry>();
        for (List<String> entryItem : itemsList) {
            PricebookEntry entry = TW_ProductServiceHelper.createPricebookEntry(entryItem, pricebookId);
            entriesObject.add(entry);
        }
        return entriesObject;
    }


    public static PricebookEntry createPricebookEntry(List<String> item, String pricebookId) {
        PricebookEntry newEntry = new PricebookEntry();
        newEntry.Pricebook2Id = pricebookId;
        newEntry.Product2Id = item[0];
        newEntry.UnitPrice = Decimal.valueOf(item[2]);
        newEntry.IsActive = true;
        return newEntry;
    }

    public static List<String> getIdsFromList(List<PricebookEntry> items) {
        List<String> ids = new List<String>();
        for (PricebookEntry entry : items) {
            ids.add(entry.Product2Id);
        }
        return ids;
    }


    public static String prepareParameter(String param) {
        if (param.startsWith('[')) {
            param = param.substring(1, param.length());
        }
        if (param.startsWith('"')) {
            param = param.substring(1, param.length());
        }
        if (param.endsWith(']')) {
            param = param.substring(0, param.length() - 1);
        }
        if (param.endsWith('"')) {
            param = param.substring(0, param.length() - 1);
        }
        return param;
    }

    public static Map<String, PricebookEntry> selectEntriesToUpsert(List<PricebookEntry> newEntries,Map<String,PricebookEntry> existingEntriesMap) {
        Map<String,PricebookEntry> mapToUpsert = new Map<String,PricebookEntry>();
        for (PricebookEntry newEntry : newEntries) {
            if (existingEntriesMap.containsKey(newEntry.Product2Id)) {
                newEntry.Id = existingEntriesMap.get(newEntry.Product2Id).Id;
                mapToUpsert.put(newEntry.Product2Id, newEntry);
            } else {
                mapToUpsert.put(newEntry.Product2Id, newEntry);
            }
        }
        return mapToUpsert;
    }

    public static List<PricebookEntry> selectEntriesToDelete(Map<String,PricebookEntry> existingEntriesMap,Map<String,PricebookEntry> mapToUpsert) {
        List<PricebookEntry> entriesToDelete = new List<PricebookEntry>();
        for(String key : existingEntriesMap.keySet()){
            if (!mapToUpsert.containsKey(key)){
                entriesToDelete.add(existingEntriesMap.get(key));
            }
        }
        return entriesToDelete;
    }

    public static List<PricebookEntry> getEntriesListToUpsert(Map<String,PricebookEntry> mapToUpsert) {
        List<PricebookEntry> entriesToUpsert = new List<PricebookEntry>();
        for(String key : mapToUpsert.keySet()){
            entriesToUpsert.add(mapToUpsert.get(key));
        }
        return entriesToUpsert;
    }

    public static List<String> createIdListForPricebook(String pricebookId){
        List<String> pricebooksIds = new List<String>();
        pricebooksIds.add(pricebookId);
        pricebooksIds.add(TW_PricebookHandler.getStandardPricebook());
        return pricebooksIds;
    }
}