/**
 * Created by BRITENET on 11.07.2019.
 */

public with sharing class TW_PricebookHandler {

    public static String getStandardPricebook() {
        Pricebook2 pb = [
                SELECT Id
                FROM Pricebook2
                WHERE IsStandard = true
        ];
        return pb.Id;
    }

    public static List<Pricebook2> getAllPricebooks() {
        List<Pricebook2> pbs = [
                SELECT Id,Name,TW_StartDate__c,TW_EndDate__c,IsActive
                FROM Pricebook2
        ];
        return pbs;
    }

    public static String createPricebook(Pricebook2 item) {
        try {
            upsert item;
        } catch (Exception e) {
            return e.getMessage();
        }
        return item.Id;
    }

    public static String createPricebookEntry(PricebookEntry item) {
        try {
            insert item;
        } catch (Exception e) {
            return e.getMessage();
        }
        return item.Id;
    }

    public static Boolean createPricebookEntry(List<PricebookEntry> items) {
        try {
            upsert items;
        } catch (Exception e) {
            return false;
        }
        return true;
    }

    public static Boolean deletePricebookEntry(List<PricebookEntry> items) {
        try {
            delete items;
        } catch (Exception e) {
            return false;
        }
        return true;
    }

    public static Pricebook2 checkIfPriceBookExists(String pricebookName){
        List<Pricebook2> pbs = [
                SELECT Id
                FROM Pricebook2
                WHERE Name=:pricebookName
        ];
        if (pbs.isEmpty()){
            return null;
        }
        return pbs[0];
    }

    public static Boolean deletePricebook(String pricebookId){
        List<Pricebook2> pbs = [
                SELECT Id
                FROM Pricebook2
                WHERE Id=:pricebookId
        ];
        if (!pbs.isEmpty()){
            delete pbs;
            return true;
        }
        return false;
    }
}