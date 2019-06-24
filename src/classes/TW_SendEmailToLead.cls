/**
 * Created by BRITENET on 19.06.2019.
 */

public with sharing class TW_SendEmailToLead {
    @InvocableMethod
    public static void sendEmail(List<Lead> targetLead) {

        List<String> bodyParams = new List<String>{targetLead[0].FirstName,targetLead[0].LastName,targetLead[0].Title,newSurvey(targetLead[0].Id)};
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.toAddresses =  new String[] { targetLead[0].Email };
        mail.subject = TW_EmailHelper.getEmailSubject('EmailSubject');
        mail.setHtmlBody(TW_EmailHelper.getEmailBody('EmailContent',bodyParams));
        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {mail};
        Messaging.sendEmail(messages);
    }

    private static String newSurvey(String leadId){
        TW_Survey__c newSurvey = new TW_Survey__c();
        newSurvey.Lead__c = leadId;
        insert newSurvey;
        return newSurvey.Id;
    }

//    private static String getEmailBody(List<String> params) {
//        TW_Message__c myCS = TW_Message__c.getInstance('EmailContent');
//        return String.format(myCS.Value__c,params);
//    }
//
//    private static String getEmailSubject() {
//        TW_Message__c myCS = TW_Message__c.getInstance('EmailSubject');
//        return myCS.Value__c;
//    }
}