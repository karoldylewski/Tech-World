/**
 * Created by BRITENET on 13.06.2019.
 */

public with sharing class TW_AccountHandler {

    public static String buildSoqlQuery(Account acc){
        String soqlQuery = new TW_QueryBuilder()
                .addSourceObject('Account')
                .addCondition('Name', acc.Name)
                .addCondition('AccountNumber', acc.AccountNumber)
                .addCondition('BillingCountry', acc.BillingCountry)
                .addCondition('RecordType.DeveloperName', 'TW_Division')
                .addField('Site')
                .addField('Phone')
                .addField('NumberOfEmployees')
                .addField('TW_Geolocation__latitude__s')
                .addField('TW_Geolocation__longitude__s')
                .addField('BillingAddress')
                .addField('AnnualRevenue')
                .addOrder('Name', 'ASC')
                .getQuery();
        return soqlQuery;
    }

    public static List<Account> getAccounts(Account acc){
        return Database.query(buildSoqlQuery(acc));
    }

    public static Database.DeleteResult[] deleteRecordList(List<Account> accList){
        Database.DeleteResult[] drList= Database.delete(accList, false);
        return drList;
    }

    public static Database.SaveResult[] updateRecordList(List<Account> accList){
        Database.SaveResult[] urlist= Database.update(accList, false);
        return urlist;
    }

    public static TW_OperatonResult deleteAccount(Account acc){
        List<Account> accList = new List<Account>();
        accList.add(acc);
        Database.DeleteResult[] drList= TW_AccountHandler.deleteRecordList(accList);
        for(Database.DeleteResult dr : drList) {
            if (dr.isSuccess()) {
                return new TW_OperatonResult();
            } else {
                return new TW_OperatonResult(false, dr.getErrors()[0].getMessage());
            }
        }
        return new TW_OperatonResult();
    }

    public static TW_OperatonResult updateAccount(Account acc){
        List<Account> accList = new List<Account>();
        accList.add(acc);
        Database.SaveResult[] urList= TW_AccountHandler.updateRecordList(accList);
        for(Database.SaveResult ur : urList) {
            if (ur.isSuccess()) {
                return new TW_OperatonResult();
            } else {
                return new TW_OperatonResult(false, ur.getErrors()[0].getMessage());
            }
        }
        return new TW_OperatonResult();
    }

    public static String getCommunityCustomerAccountIdByEmail() {
            String currentUserEmail = UserInfo.getUserEmail();
            if (currentUserEmail != null) {
                List<Contact> contacts = [SELECT AccountId FROM Contact WHERE Email = :currentUserEmail];
                return contacts[0].AccountId;
            } else {
                return 'Error';
            }
        }
}