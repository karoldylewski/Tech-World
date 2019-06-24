/**
 * Created by BRITENET on 19.06.2019.
 */

public with sharing class TW_SendEmailToLead {
    @InvocableMethod
    public static void sendEmail(List<Lead> targetLead) {

        List<String> bodyParams = new List<String>{targetLead[0].FirstName,targetLead[0].LastName,targetLead[0].Title,newSurvey(targetLead[0].Id,targetLead[0].FirstName,targetLead[0].LastName)};
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.toAddresses =  new String[] { targetLead[0].Email };
        mail.subject = TW_EmailHelper.getEmailSubject('EmailSubject');
        mail.setHtmlBody(TW_EmailHelper.getEmailBody('EmailContent',bodyParams));
        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {mail};
        Messaging.sendEmail(messages);
    }

    private static String newSurvey(String leadId, String firstName, String lastName){
        TW_Survey__c newSurvey = new TW_Survey__c();
        newSurvey.Lead__c = leadId;
        newSurvey.Name = 'Survey for '+firstName+' '+lastName;
        insert newSurvey;
        return newSurvey.Id;
    }

}