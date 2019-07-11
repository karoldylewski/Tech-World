/**
 * Created by BRITENET on 11.07.2019.
 */

public with sharing class TW_PricebookHandler {

    public static String getStandardPricebook(){
        Pricebook2 pb = [SELECT Id FROM Pricebook2 WHERE IsStandard=true];
        return pb.Id;
    }
}