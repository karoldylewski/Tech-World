/**
 * Created by BRITENET on 15.07.2019.
 */

public with sharing class TW_CaseHandler {

    public static String insertCase(Case newCase) {
        try {
            insert newCase;
        } catch (Exception e) {
            return e.getMessage();
        }
        return newCase.Id;
    }

    public static Boolean crateOrderItemsInCase(List<Products__c> productsList) {
        Database.SaveResult[] saveResultList = Database.insert(productsList, false);
        for (Database.SaveResult sr : saveResultList) {
            if (!sr.isSuccess()) {
                return false;
            }
        }
        return true;
    }

    public static List<Case> getUserCases(String contactId) {
        List<Case> caseList = [
                SELECT Id, Subject,Description,CreatedDate
                FROM Case
                WHERE ContactId = :contactId
        ];
        return caseList;
    }

    public static List<Products__c> getCaseItems(String caseId) {
        List<Products__c> caseItemsList = [
                SELECT Id, Product_Name__c,
                        Order_Product__r.OrderItemNumber,
                        Order_Product__r.Quantity,
                        Order_Product__r.UnitPrice,
                        Complaint_Case__c
                FROM Products__c
                WHERE Complaint_Case__c = :caseId
        ];
        return caseItemsList;
    }
}