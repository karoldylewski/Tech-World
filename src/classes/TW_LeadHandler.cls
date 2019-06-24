/**
 * Created by BRITENET on 18.06.2019.
 */

public with sharing class TW_LeadHandler {

    public static List<Lead> getLeadsByIds(List<String> leadId){
        return [SELECT id,Name,Owner.Name, company,status,CreatedDate,CreatedBy.Name, LeadSource, Title FROM Lead WHERE id IN :leadId];
    }

    public static String createLead(){
        Lead lead = new Lead();
        insert lead;
        return lead.Id;

    }
}