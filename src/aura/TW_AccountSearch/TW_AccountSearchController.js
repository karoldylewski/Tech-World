/**
 * Created by BRITENET on 12.06.2019.
 */
({
    searchAccounts : function(component,event,helper){
        helper.getAccountsFromServer(component);
    },

    clearFields : function(component,event,helper){
        helper.clearResultList(component);
    },

    createNewAccount : function (component,event,helper){
        helper.createAccount(component);
    },

})