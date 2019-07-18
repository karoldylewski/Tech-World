public with sharing class TW_ProductService {

    public static TW_Utils.TW_ProductList getProductList(List<String> parameters) {
        List<PricebookEntry> pricebookEntries = TW_ProductHandler.getPricebookEntries(TW_ProductServiceHelper.prepareParametersForQuery(parameters));
        List<TW_Utils.TW_ProductWrapper> wrapList = TW_ProductServiceHelper.addItemsToWrappers(pricebookEntries);
        String orgBaseUrl = TW_ProductServiceHelper.getOrgBaseUrl();
        TW_Utils.TW_ProductList products = new TW_Utils.TW_ProductList(orgBaseUrl, wrapList);
        return products;
    }

    public static TW_Utils.TW_ProductWrapper getProductDetails(String productId) {
        List<PricebookEntry> pricebookEntries = TW_ProductHandler.getPricebookEntriesForId(productId);
        List<TW_Utils.TW_ProductWrapper> wrapList = TW_ProductServiceHelper.addItemsToWrappers(pricebookEntries);
        wrapList[0].orgId = TW_ProductServiceHelper.getOrgBaseUrl();
        return wrapList[0];
    }

    public static TW_Utils.TW_ProductList getProductDetailsForMultipleId(List<String> productIds) {
        Map<String, Integer> sortedIds = TW_ProductServiceHelper.segregateIdsToArrays(productIds);
        List<String> idList = TW_ProductServiceHelper.getUniqueIdsFromMap(sortedIds);
        List<Id> idsToSearch = TW_ProductServiceHelper.convertStringToId(idList);
        List<PricebookEntry> pricebookEntries = TW_ProductHandler.getPricebookEntriesForMultipleId(idList);
        List<TW_Utils.TW_ProductWrapper> wrapList = TW_ProductServiceHelper.addItemsToWrappers(pricebookEntries);
        for (TW_Utils.TW_ProductWrapper singleProduct : wrapList) {
            Integer itemCount = sortedIds.get(singleProduct.product.Id);
            singleProduct.count = itemCount;
        }
        String orgBaseUrl = TW_ProductServiceHelper.getOrgBaseUrl();
        TW_Utils.TW_ProductList products = new TW_Utils.TW_ProductList(orgBaseUrl, wrapList);
        return products;
    }

    public static Boolean addProductsToOrder(List<String> productIds) {
        Map<String, Integer> sortedIds = TW_ProductServiceHelper.segregateIdsToArrays(productIds);
        List<String> idList = TW_ProductServiceHelper.getUniqueIdsFromMap(sortedIds);
        List<PricebookEntry> pricebookEntries = TW_ProductHandler.getPricebookEntriesForOrder(idList);
        String standardPriceBookId = TW_PricebookHandler.getStandardPricebook();
        List<PricebookEntry> filteredEntries = TW_ProductServiceHelper.getLowestPricesForPricebookEntries(pricebookEntries);
        Map<String, PricebookEntry> sortedPbs = TW_ProductServiceHelper.segregatePricebookEntriesToArrays(filteredEntries);
        Order newOrder = TW_ProductServiceHelper.createOrderForUser(standardPriceBookId);
        List<OrderItem> orderItems = new List<OrderItem>();
        for(String productId : idList){
            PricebookEntry pb = sortedPbs.get(productId);
            orderItems.add(TW_ProductServiceHelper.prepareOrderItem(newOrder.Id,productId,sortedIds.get(productId),pb.Id,pb.UnitPrice));
        }
        Boolean operationResult = TW_OrderHandler.createOrderItems(orderItems);
        return operationResult;
    }

    public static List<Order> getUserOrders() {
        String userId = TW_ProductServiceHelper.getUserId();
        List<Order> allUserOrders = TW_OrderHandler.getUserOrders(userId);
        return allUserOrders;
    }

    public static List<OrderItem> getOrderItems(String orderId) {
        List<OrderItem> orderItems = TW_OrderHandler.getItemsForOrder(orderId);
        return orderItems;
    }

    public static List<TW_Product_Review__c> getProductReviews(String itemId){
        List<TW_Product_Review__c> reviews = TW_ReviewHandler.getReviewsForProduct(itemId);
        return reviews;
    }

    public static Boolean checkIfUserCanReview(String itemId){
        String userId = TW_ProductServiceHelper.getUserId();
        Boolean hasPurchased = TW_OrderHandler.checkIfUserHasPurchasedItem(itemId,userId);
        if (!hasPurchased){
            return false;
        }
        Boolean hasCommented = TW_ReviewHandler.checkIfUserHasCommented(itemId,userId);
        Boolean access=hasPurchased && !hasCommented;
        return hasPurchased && !hasCommented;
    }

    public static Boolean makeAComplaint(List<String> productsIds,String subject, String description){
        List<OrderItem> orderItems = TW_OrderHandler.getOrderItemsByMultipleId(productsIds);
        String contactId = TW_ContactHandler.getCommunityCustomerContactId();
        String caseId = TW_ProductServiceHelper.crateCase(contactId,subject,description);
        return TW_ProductServiceHelper.crateOrderItemsInCase(caseId,orderItems);
    }

    public static List<Case> getUserComplaints(){
        String contactId = TW_ContactHandler.getCommunityCustomerContactId();
        List<Case> caseList = TW_CaseHandler.getUserCases(contactId);
        return caseList;
    }

    public static List<Products__c> getCaseItems(String caseId){
        return TW_CaseHandler.getCaseItems(caseId);
    }

    public static List<Pricebook2> getAllPricebooks(){
        return TW_PricebookHandler.getAllPricebooks();
    }

    public static List<PricebookEntry> getPricebookAllEntries(String pricebookId){
        return TW_ProductHandler.getPricebookEntriesForPricebook(pricebookId);
    }

    public static List<PricebookEntry> getAllProducts(){
        return TW_ProductHandler.getAllProducts(TW_PricebookHandler.getStandardPricebook());
    }

    public static String saveNewPricebook(List<List<String>> itemsList, String pricebookName, Date sd, Date ed, Boolean isActive, String pricebookId){
        pricebookId = TW_ProductServiceHelper.prepareParameter(pricebookId);
        if (pricebookId == TW_Utils.TW_NEW_PRICEBOOK){
            pricebookId =  TW_ProductServiceHelper.createNewPricebook2(pricebookName,sd,ed,isActive,null);
            List<PricebookEntry> entriesToInsert = TW_ProductServiceHelper.createPricebookEntries(itemsList,pricebookId);
            Boolean entriesInsertResult = TW_PricebookHandler.createPricebookEntry(entriesToInsert);
        }else{
            pricebookId = TW_ProductServiceHelper.createNewPricebook2(pricebookName,sd,ed,isActive,pricebookId);
            List<PricebookEntry> existingEntries = TW_ProductHandler.getPricebookEntriesForPricebook(pricebookId);
            Map<String,PricebookEntry> existingEntriesMap = TW_ProductServiceHelper.segregatePricebookEntriesToArrays(existingEntries);
            List<PricebookEntry> newEntries  = TW_ProductServiceHelper.createPricebookEntries(itemsList,pricebookId);
            Map<String,PricebookEntry> mapToUpsert = TW_ProductServiceHelper.selectEntriesToUpsert(newEntries,existingEntriesMap);
            TW_PricebookHandler.deletePricebookEntry(TW_ProductServiceHelper.selectEntriesToDelete(existingEntriesMap,mapToUpsert));
            TW_PricebookHandler.createPricebookEntry(TW_ProductServiceHelper.getEntriesListToUpsert(mapToUpsert));
        }
        return pricebookId;
    }

    public static TW_Utils.TW_ProductList getProductListForPricebooks(String pricebookId) {
        List<String> pricebooksIds = TW_ProductServiceHelper.createIdListForPricebook(pricebookId);
        List<String> productsIds = TW_ProductServiceHelper.getIdsFromList(TW_ProductHandler.getPricebookEntriesForCustomPricebook(pricebookId));
        List<PricebookEntry> pricebookEntries = TW_ProductHandler.getPricebookEntriesForPricebook(pricebooksIds,productsIds);
        List<TW_Utils.TW_ProductWrapper> wrapList = TW_ProductServiceHelper.addItemsToWrappers(pricebookEntries);
        String orgBaseUrl = TW_ProductServiceHelper.getOrgBaseUrl();
        return new TW_Utils.TW_ProductList(orgBaseUrl, wrapList);
    }

    public static Boolean deletePricebook(String pricebookId) {
        return TW_PricebookHandler.deletePricebook(pricebookId);
    }

    public static TW_Utils.TW_ProductWrapper getHighlightProduct() {
        String productId = TW_ProductHandler.getLatestProduct();
        List<PricebookEntry> pricebookEntries = TW_ProductHandler.getPricebookEntriesForId(productId);
        List<TW_Utils.TW_ProductWrapper> wrapList = TW_ProductServiceHelper.addItemsToWrappers(pricebookEntries);
        wrapList[0].orgId = TW_ProductServiceHelper.getOrgBaseUrl();
        return wrapList[0];
    }
}