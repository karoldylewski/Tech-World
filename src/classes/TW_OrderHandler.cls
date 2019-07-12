/**
 * Created by BRITENET on 11.07.2019.
 */

public with sharing class TW_OrderHandler {

    public static String createOrder(Order ord) {
        try {
            insert ord;
        } catch (Exception e) {
            return e.getMessage();
        }
        return ord.Id;
    }

    public static Boolean createOrderItems(List<OrderItem> items) {
        try {
            insert items;
        } catch (Exception e) {
            return false;
        }
        return true;
    }

    public static List<Order> getUserOrders(String userId) {
        List<Order> orders = [
                SELECT Id,Status,OwnerId,TotalAmount,EffectiveDate,OrderNumber
                FROM Order
                WHERE OwnerId = :userId
                ORDER BY CreatedDate DESC
        ];
        return orders;
    }

    public static List<OrderItem> getItemsForOrder(String orderId) {
        List<OrderItem> orderItems = [
                SELECT Id,UnitPrice,TotalPrice,Quantity,Product2.Name
                FROM OrderItem
                WHERE OrderId = :orderId
        ];
        return orderItems;
    }
}