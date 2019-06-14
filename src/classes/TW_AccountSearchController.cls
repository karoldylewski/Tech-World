/**
 * Created by BRITENET on 13.06.2019.
 */

public with sharing class TW_AccountSearchController {

    @AuraEnabled
    public static List<Account> getAccounts(Account acc){
        return TW_AccountHandler.getAccounts(acc);
    }

    @AuraEnabled
    public static TW_OperatonResult deleteAccount(Account acc){
        return TW_AccountHandler.deleteAccount(acc);
    }

    @AuraEnabled
    public static TW_OperatonResult updateAccount(Account acc){
        return TW_AccountHandler.updateAccount(acc);
    }
}