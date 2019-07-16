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
}