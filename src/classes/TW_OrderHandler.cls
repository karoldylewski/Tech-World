/**
 * Created by BRITENET on 11.07.2019.
 */

public with sharing class TW_OrderHandler {

    public static String createOrder(Order ord) {
        try{
            insert ord;
        }catch (Exception e){
            return e.getMessage();
        }
        return ord.Id;
    }

}