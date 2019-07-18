/**
 * Created by BRITENET on 15.07.2019.
 */

public with sharing class TW_ContactHandler {

    public static String getCommunityCustomerContactId() {
        String currentUserEmail = UserInfo.getUserEmail();
        String firstName = UserInfo.getFirstName();
        String lastName = UserInfo.getLastName();
        if (currentUserEmail != null) {
            List<Contact> contacts = [
                    SELECT Id, FirstName, LastName
                    FROM Contact
                    WHERE Email = :currentUserEmail
                    AND FirstName =: firstName
                    AND LastName =: lastName
            ];
            return contacts[0].Id;
        }
        return 'Error';
    }
}