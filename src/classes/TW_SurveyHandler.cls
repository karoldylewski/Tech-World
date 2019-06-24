/**
 * Created by BRITENET on 19.06.2019.
 */

public with sharing class TW_SurveyHandler {

    public static TW_Survey__c getSurveyObject(String passedId){
        List<TW_Survey__c> sList = [SELECT Id,Interested__c,Satisfied__c
        FROM TW_Survey__c
        WHERE Id = :passedId
        LIMIT 1];
        if (sList.isEmpty()){
            return null;
        }else if (sList[0].Interested__c == null){
            return sList[0];
        }
        return null;
    }

    public static void submitSurvey(String interest,String satisfied,String surveyId){
        TW_Survey__c surv = TW_SurveyHandler.getSurveyObject(surveyId);
        surv.Interested__c = interest;
        surv.Satisfied__c = Integer.valueOf(satisfied);
        surv.Datetime_completed__c = system.now();
        update surv;
    }

    public static Boolean checkIfSurveyAvailable(String surveyId) {
        if (surveyId.length() != 15 && surveyId.length() != 18) {
            return false;
        } else {
            TW_Survey__c surv = TW_SurveyHandler.getSurveyObject(surveyId);
            if (surv != null){
                return true;
            }
            return false;
        }
    }
}