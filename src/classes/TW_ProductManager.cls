/**
 * Created by BRITENET on 09.07.2019.
 */

public with sharing class TW_ProductManager {

    @AuraEnabled
    public static Boolean makeAComplaint(List<String> productsId,String subject, String description) {
        Boolean result = TW_ProductService.makeAComplaint(productsId,subject,description);
        return true;
    }

    @AuraEnabled
    public static List<Case> getUserComplaints() {
        return TW_ProductService.getUserComplaints();
    }

    @AuraEnabled
    public static List<Products__c> getCaseItems(String caseId) {
        return TW_ProductService.getCaseItems(caseId);
    }


}