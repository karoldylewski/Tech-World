({
    getAccountsFromServer: function(component) {
        let searchInput = component.get("v.searchedItem");
        let action = component.get('c.getAccounts');
        action.setParams({
            acc: searchInput
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let sendAccountToResult = $A.get("e.c:TW_AccountSendToResult");
                sendAccountToResult.setParams({
                    "accountList": response.getReturnValue(),
                });
                sendAccountToResult.fire();
                let clearDetails = $A.get("e.c:TW_ClearDetailsPanel");
                clearDetails.fire();
            }else{
                let toastParams = {
                    title: "Error",
                    message: $A.get('$Label.c.TW_Apex_Error'),
                    type: "error"
                };
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams(toastParams);
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    },

    clearResultList: function(component) {
        component.set("v.searchedItem.Name", '');
        component.set("v.searchedItem.AccountNumber", '');
        component.set("v.searchedItem.BillingCountry", '');
        let clearAccountResult = $A.get("e.c:TW_AccountClearResultList");
        clearAccountResult.fire();

    },
    createAccount: function(component) {
        let accId = component.get("v.item.Id");
        component.find("navId").navigate({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: "Account",
                actionName: 'new',
            }
        }, true);
    },
})