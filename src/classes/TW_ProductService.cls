public with sharing class TW_ProductService {

    public static Boolean addProductsToOrder(List<String> productIds) {
        Map<String, Integer> sortedIds = TW_ProductServiceHelper.segregateIdsToArrays(productIds);
        List<String> idList = TW_ProductServiceHelper.getUniqueIdsFromMap(sortedIds);
        List<PricebookEntry> pricebookEntries = TW_ProductHandler.getPricebookEntriesForOrder(idList);
        String standardPriceBookId = TW_PricebookHandler.getStandardPricebook();
        List<PricebookEntry> filteredEntries = TW_ProductServiceHelper.getLowestPricesForPricebookEntries(pricebookEntries);
        Map<String, PricebookEntry> sortedPbs = TW_ProductServiceHelper.segregatePricebookEntriesToArrays(filteredEntries);
        Order newOrder = TW_ProductServiceHelper.createOrderForUser(standardPriceBookId);
        return TW_OrderHandler.insertOrderItemItems(TW_ProductServiceHelper.creteOrderItemsObjects(sortedIds,idList,newOrder));;
    }
}