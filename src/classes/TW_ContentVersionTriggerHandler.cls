/**
 * Created by BRITENET on 09.07.2019.
 */


public with sharing class TW_ContentVersionTriggerHandler implements TW_ITrigger{

    public void bulkBefore() {
        if (trigger.isInsert) {

        }
    }

    public void bulkAfter() {
        if (trigger.isInsert) {
            List<ContentVersion> itemsList = trigger.new;
            List<ContentDocumentLink> imageOwner = [SELECT LinkedEntityId,ContentDocumentId FROM ContentDocumentLink WHERE ContentDocumentId=:itemsList[0].ContentDocumentId];
            List<String> ownerIds = new List<String>();
            for(ContentDocumentLink con : imageOwner){
                ownerIds.add(con.LinkedEntityId);
            }
            List<Product2> product = [SELECT Id, ImageId__c FROM Product2 WHERE Id IN :ownerIds];
            if (product.size() > 0){
                product[0].ImageId__c = itemsList[0].ContentDocumentId;
                update product;
            }
        }
    }


}