({
	getAccountsFromServer : function(component) {
		var searchInput = component.get("v.searchedItem");
		var action = component.get('c.getAccounts');
		action.setParams({
        			acc: searchInput
        });
        action.setCallback(this, function (response) {
        			let state = response.getState();
        			if (state === "SUCCESS") {
        			    	var sendAccountToResult = $A.get("e.c:TW_SendAccountToResult");
                                    sendAccountToResult.setParams({
                                        "accountList": response.getReturnValue(),
                                    });
                            sendAccountToResult.fire();
                            var sendAccountToResult = $A.get("e.c:TW_ClearDetailsPanel");
                            sendAccountToResult.fire();
        			} else {
        			   //// ERROR
        			}
        		});
        		$A.enqueueAction(action);
	},

	clearResultList : function (component){
	    component.set("v.searchedItem.Name",'');
        component.set("v.searchedItem.AccountNumber",'');
        component.set("v.searchedItem.BillingCountry",'');
	    var clearAccountResult = $A.get("e.c:TW_ClearAccountResultList");
        clearAccountResult.fire();

    },
    createAccount : function(component){
        let accId = component.get("v.item.Id");
        component.find("navId").navigate({
             type: 'standard__objectPage',
             attributes: {
                   objectApiName : "Account",
                   actionName: 'new',
             }}, true);
    },
})