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

    @AuraEnabled
    public static List<Pricebook2> getAllPricebooks(){
        return TW_ProductService.getAllPricebooks();
    }

    @AuraEnabled
    public static List<PricebookEntry> getPricebookAllEntries(String pricebookId){
        return TW_ProductService.getPricebookAllEntries(pricebookId);
    }

    @AuraEnabled
    public static List<PricebookEntry> getAllProducts(){
        return TW_ProductService.getAllProducts();
    }

    @AuraEnabled
    public static String addNewPricebook(List<List<String>> itemsList, String pricebookName, Date sd, Date ed, Boolean isActive, String pbid){
        return TW_ProductService.saveNewPricebook(itemsList,pricebookName,sd,ed,isActive,pbid);
    }

    @AuraEnabled
    public static TW_Utils.TW_ProductList getProductListForPricebook(String pricebookId) {
        TW_Utils.TW_ProductList searchedProducts = TW_ProductService.getProductListForPricebooks(pricebookId);
        return searchedProducts;
    }

    @AuraEnabled
    public static Boolean deletePricebook(String pricebookId) {
        return TW_ProductService.deletePricebook(pricebookId);
    }
}