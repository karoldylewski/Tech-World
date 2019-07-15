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

            System.debug('YOU JUST UPDATED FILE FOR PRODUCT. - trigger.');
            System.debug('Id of contentversion: '+itemsList[0].Id);
            System.debug('ContentDocumentId of contentversion: '+itemsList[0].ContentDocumentId);
            List<ContentDocumentLink> imageOwner = [SELECT LinkedEntityId,ContentDocumentId FROM ContentDocumentLink WHERE ContentDocumentId=:itemsList[0].ContentDocumentId];

            System.debug('Image owner SIZE : '+imageOwner.size());
            System.debug('Image owner ID : '+imageOwner[imageOwner.size()-1].LinkedEntityId);
            List<String> ownerIds = new List<String>();
            for(ContentDocumentLink con : imageOwner){
                ownerIds.add(con.LinkedEntityId);
            }


//            List<Product2> product = [SELECT Id, ImageId__c FROM Product2 WHERE Id=:imageOwner[imageOwner.size()-1].LinkedEntityId];
            List<Product2> product = [SELECT Id, ImageId__c FROM Product2 WHERE Id IN :ownerIds];

            if (product.size() > 0){
                product[0].ImageId__c = itemsList[0].ContentDocumentId;
                update product;
            }
            System.debug('FOUND : '+product.size()+'Product2 records with ids: ' +ownerIds);
            product[0].ImageId__c = itemsList[0].Id;
            update product;
        }
    }


}