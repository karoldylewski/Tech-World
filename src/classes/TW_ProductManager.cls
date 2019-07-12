/**
 * Created by BRITENET on 09.07.2019.
 */

public with sharing class TW_ProductManager {

    @AuraEnabled
    public static String placeOrder(List<String> productsId) {
        String response = TW_ProductService.addProductsToOrder(productsId);
        return response;
    }

    @AuraEnabled
    public static List<Order> getUserOrders() {
        List<Order> orderItems = TW_ProductService.getUserOrders();
        return orderItems;
    }

    @AuraEnabled
    public static List<OrderItem> getOrderItems(String orderId) {
        List<OrderItem> orderItems = TW_ProductService.getOrderItems(orderId);
        return orderItems;
    }

}