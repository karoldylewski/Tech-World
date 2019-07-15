public with sharing class TW_ProductService {

    public static String addProductsToOrder(List<String> productIds) {
        Map<String, Integer> sortedIds = TW_ProductServiceHelper.segregateIdsToArrays(productIds);
        List<String> idList = TW_ProductServiceHelper.getUniqueIdsFromMap(sortedIds);
        List<PricebookEntry> pricebookEntries = TW_ProductHandler.getPricebookEntriesForOrder(idList);
        String standardPriceBookId = TW_PricebookHandler.getStandardPricebook();
        List<PricebookEntry> filteredEntries = TW_ProductServiceHelper.getLowestPricesForPricebookEntries(pricebookEntries);
        Map<String, PricebookEntry> sortedPbs = TW_ProductServiceHelper.segregatePricebookEntriesToArrays(filteredEntries);
        Order newOrder = TW_ProductServiceHelper.createOrderForUser(standardPriceBookId);
        List<OrderItem> orderItems = TW_ProductServiceHelper.creteOrderItemsObjects(sortedIds,idList,newOrder);
        return TW_OrderHandler.createOrderItems(orderItems);
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
}