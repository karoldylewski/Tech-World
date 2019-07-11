public with sharing class TW_ProductService {

    public static TW_Utils.TW_ProductList getProductList(List<String> parameters) {
        List<PricebookEntry> pricebookEntries = TW_ProductHandler.getPricebookEntries(prepareParametersForQuery(parameters));
        List<TW_Utils.TW_ProductWrapper> wrapList = addItemsToWrappers(pricebookEntries);
        String orgBaseUrl = getOrgBaseUrl();
        TW_Utils.TW_ProductList products = new TW_Utils.TW_ProductList(orgBaseUrl, wrapList);
        return products;
    }

    public static TW_Utils.TW_ProductWrapper getProductDetails(String productId) {
        List<PricebookEntry> pricebookEntries = TW_ProductHandler.getPricebookEntriesForId(productId);
        List<TW_Utils.TW_ProductWrapper> wrapList = addItemsToWrappers(pricebookEntries);
        wrapList[0].orgId = getOrgBaseUrl();
        return wrapList[0];
    }

    public static TW_Utils.TW_ProductList getProductDetailsForMultipleId(List<String> productIds) {
        Map<String, Integer> sortedIds = TW_Utils.segregateIdsToArrays(productIds);
        List<String> idList = TW_Utils.getUniqueIdsFromMap(sortedIds);
        List<Id> idsToSearch = TW_Utils.convertStringToId(idList);
        List<PricebookEntry> pricebookEntries = TW_ProductHandler.getPricebookEntriesForMultipleId(idList);
        List<TW_Utils.TW_ProductWrapper> wrapList = addItemsToWrappers(pricebookEntries);
        for (TW_Utils.TW_ProductWrapper singleProduct : wrapList) {
            Integer itemCount = sortedIds.get(singleProduct.product.Id);
            singleProduct.count = itemCount;
        }
        String orgBaseUrl = getOrgBaseUrl();
        TW_Utils.TW_ProductList products = new TW_Utils.TW_ProductList(orgBaseUrl, wrapList);
        return products;
    }

    public static Boolean addProductsToOrder(List<String> productIds) {
        Map<String, Integer> sortedIds = TW_Utils.segregateIdsToArrays(productIds);
        List<String> idList = TW_Utils.getUniqueIdsFromMap(sortedIds);
        List<PricebookEntry> pricebookEntries = TW_ProductHandler.getPricebookEntriesForMultipleId(idList);
        System.debug('Pricebook entries:'+pricebookEntries);
//        Order newOrder = createOrderForUser();
//        for(String productId : productIds){
//            OrderItem newOrderItem =createOrderItem(newOrder.Id,productId);
//        }
        return true;
    }

    private static OrderItem createOrderItem(String orderId, String productId){
        OrderItem item = new OrderItem();
        item.OrderId = orderId;
        item.Product2Id = productId;
        try{
            insert item;
        }catch (Exception e){
            System.debug('Error: '+e.getMessage());
        }
        return item;
    }


    private static Order createOrderForUser() {
        Order ord = new Order();
        ord.AccountId = TW_AccountHandler.getCommunityCustomerAccountIdByEmail();
        ord.EndDate = Date.today().addDays(30);
        ord.Status = 'Draft';
        ord.EffectiveDate = Date.today();
        String OrderId = TW_OrderHandler.createOrder(ord);
        return ord;
    }


    private static List< TW_Utils.TW_ProductWrapper> addItemsToWrappers(List<PricebookEntry> entries) {
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

    private static String getOrgBaseUrl() {
        return TW_Message__c.getInstance('TW_OrgBaseUrl').Value__c;
    }

    private static List<String> prepareParametersForQuery(List<String> parameters) {
        List<String> modifiedParams = new List<String>();
        for (String param : parameters) {
            modifiedParams.add('%' + param + '%');
        }
        return modifiedParams;
    }
}