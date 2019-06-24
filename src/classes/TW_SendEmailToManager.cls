/**
 * Created by BRITENET on 19.06.2019.
 */

public with sharing class TW_SendEmailToManager {
    @InvocableMethod
    public static void sendEmail(List<Lead> targetLead) {
        String leadOwner = targetLead[0].OwnerId;
//        List<User> manager = [SELECT Id, Manager.Email,Manager.Name FROM User WHERE Id=:targetLead[0].OwnerId];
        List<User> manager = TW_EmailHelper.getUserManager(targetLead[0].OwnerId);
        String urlToLead = TW_EmailHelper.getInstanceUrl()+'/one/one.app#/sObject/'+targetLead[0].Id+'/view';
        List<String> bodyParams = new List<String>{manager[0].Manager.Name,targetLead[0].Title,targetLead[0].Status,urlToLead};
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.toAddresses =  new String[] {manager[0].Manager.Email };
        mail.subject = TW_EmailHelper.getEmailSubject('EmailManagerSubject');
        mail.setHtmlBody(TW_EmailHelper.getEmailBody('EmailManagerContent',bodyParams));
        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {mail};
        Messaging.sendEmail(messages);

    }
}