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
<<<<<<< HEAD
=======

    public static String createPricebook(Pricebook2 item) {
        try {
            insert item;
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
>>>>>>> feature/TW-14_Product-discount
}