/**
 * Created by BRITENET on 09.07.2019.
 */

public with sharing class TW_ProductManager {

    @AuraEnabled
    public static TW_Utils.TW_ProductList getProductList(List<String> parameters) {
        TW_Utils.TW_ProductList searchedProducts = TW_ProductService.getProductList(parameters);
        return searchedProducts;
    }

    @AuraEnabled
    public static TW_Utils.TW_ProductWrapper getProductDetails(String productId) {
        TW_Utils.TW_ProductWrapper item = TW_ProductService.getProductDetails(productId);
        return item;
    }

    @AuraEnabled
    public static TW_Utils.TW_ProductList getMultipleProductDetails(List<String> productsId) {
        TW_Utils.TW_ProductList item = TW_ProductService.getProductDetailsForMultipleId(productsId);
        return item;
    }

    @AuraEnabled
    public static Boolean placeOrder(List<String> productsId) {
        Boolean response = TW_ProductService.addProductsToOrder(productsId);
        return true;
    }

    @AuraEnabled
    public static List<Order> getUserOrders() {
        List<Order> orderItems = TW_ProductService.getUserOrders();
        return orderItems;
    }

    @AuraEnabled
    public static List<OrderItem> getOrderItems(String orderId) {
        List<OrderItem> orderItems = TW_ProductService.getOrderItems(orderId);
        return orderItems;
    }

    @AuraEnabled
    public static List<TW_Product_Review__c> getReviewItems(String productId) {
        List<TW_Product_Review__c> reviewItems = TW_ProductService.getProductReviews(productId);
        return reviewItems;
    }
    @AuraEnabled
    public static Boolean checkIfUserCanReview(String productId) {
        return TW_ProductService.checkIfUserCanReview(productId);
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
<<<<<<< HEAD
=======

    @AuraEnabled
    public static String addNewPricebook(List<List<String>> itemsList, String pricebookName, Date sd, Date ed, Boolean isActive){
        return TW_ProductService.saveNewPricebook(itemsList,pricebookName,sd,ed,isActive);
    }

    @AuraEnabled
    public static TW_Utils.TW_ProductList getProductListForPricebook(String pricebookId) {
        TW_Utils.TW_ProductList searchedProducts = TW_ProductService.getProductListForPricebooks(pricebookId);
        return searchedProducts;
    }
>>>>>>> feature/TW-14_Product-discount
}