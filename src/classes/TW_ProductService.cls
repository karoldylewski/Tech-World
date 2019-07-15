public with sharing class TW_ProductService {


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
}