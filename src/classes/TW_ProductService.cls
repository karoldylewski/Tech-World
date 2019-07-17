public with sharing class TW_ProductService {

    public static Boolean makeAComplaint(List<String> productsIds,String subject, String description){
        List<OrderItem> orderItems = TW_OrderHandler.getOrderItemsByMultipleId(productsIds);
        String contactId = TW_ContactHandler.getCommunityCustomerContactId();
        String caseId = TW_ProductServiceHelper.crateCase(contactId,subject,description);
        return TW_ProductServiceHelper.crateOrderItemsInCase(caseId,orderItems);
    }

    public static List<Case> getUserComplaints(){
        String contactId = TW_ContactHandler.getCommunityCustomerContactId();
        return TW_CaseHandler.getUserCases(contactId);;
    }

    public static List<Products__c> getCaseItems(String caseId){
        return TW_CaseHandler.getCaseItems(caseId);
    }

}