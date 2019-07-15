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
        List<Order> orders = [SELECT Id,Status,OwnerId,TotalAmount,EffectiveDate,OrderNumber FROM Order WHERE OwnerId = :userId];
        return orders;
    }

    public static List<OrderItem> getItemsForOrder(String orderId) {
        List<OrderItem> orderItems = [SELECT Id,UnitPrice,TotalPrice,Quantity,Product2.Name FROM OrderItem WHERE OrderId = :orderId];
        return orderItems;
    }

    public static Boolean checkIfUserHasPurchasedItem(String itemId, String userId) {
        List<OrderItem> resultList = [
                SELECT Id
                FROM OrderItem
                WHERE Product2Id = :itemId
                AND CreatedById = :userId
        ];
        if (resultList.isEmpty()) {
            return false;
        }
        return true;
    }

    public static Boolean insertOrderItemItems(List<OrderItem> items) {
        Database.SaveResult[] saveResultList = Database.insert(items, false);
        for (Database.SaveResult sr : saveResultList) {
            if (!sr.isSuccess()) {
                return false;
            }
        }
        return true;
    }