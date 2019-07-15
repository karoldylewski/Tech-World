/**
 * Created by BRITENET on 11.07.2019.
 */

public with sharing class TW_OrderHandler {

    public static Boolean checkIfUserHasPurchasedItem(String itemId, String userId){
        List<OrderItem> resultList = [
                SELECT Id
                FROM OrderItem
                WHERE Product2Id =: itemId
                AND CreatedById =: userId
        ];
        if (resultList.isEmpty()){
            return false;
        }else{
            return true;
        }
    }
}