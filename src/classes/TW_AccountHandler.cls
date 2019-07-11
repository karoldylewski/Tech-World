/**
 * Created by BRITENET on 11.07.2019.
 */

public with sharing class TW_AccountHandler {

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