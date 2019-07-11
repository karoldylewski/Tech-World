/**
 * Created by BRITENET on 10.07.2019.
 */
({
    onInit: function(component) {
        ;
        let storedItems = localStorage.getItem('productList');
        if (storedItems != null) {
            let storedKeysArray = storedItems.split(',');
            let itemsIdList = [];
            for (let iterator = 0; iterator < storedKeysArray.length; iterator++) {
                let singleStoredItem = localStorage.getItem(storedKeysArray[iterator]);
                if (singleStoredItem.charAt(0) == '"') {
                    singleStoredItem = singleStoredItem.substring(1);
                }
                if (singleStoredItem.charAt(singleStoredItem.length - 1) == '"') {
                    singleStoredItem = singleStoredItem.substring(0, singleStoredItem.length - 1);
                }
                itemsIdList.push(singleStoredItem);
            }
            let action = component.get('c.getMultipleProductDetails');
            action.setParams({
                productsId: itemsIdList
            });
            action.setCallback(this, function(response) {
                let state = response.getState();
                if (state === "SUCCESS") {
                    let responseItem = response.getReturnValue();
                    component.set('v.items', responseItem);
                    let totalCartValue = 0;
                    for (let i = 0; i < responseItem.products.length; i++) {
                        let productsValue = responseItem.products[i].count * responseItem.products[i].currentPrice
                        totalCartValue = totalCartValue + productsValue;
                    }
                    component.set('v.totalValue', totalCartValue);
                } else {
                    let toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Error",
                        "message": "Could not load cart",
                        type: "error",
                    });
                    toastEvent.fire();
                }
            });
            $A.enqueueAction(action);
        } else {
            component.set('v.items', null);
        }
    },

    onDeleteAllItems: function(component) {
        let storedItems = localStorage.getItem('productList');
        let storedKeysArray = storedItems.split(',');
        for (let iterator = 0; iterator < storedKeysArray.length; iterator++) {
            localStorage.removeItem(storedKeysArray[iterator]);
            localStorage.removeItem('productList');
        }
        this.onInit(component);
    },

    onOrderItems: function(component) {
        let storedItems = localStorage.getItem('productList');
        let storedKeysArray = storedItems.split(',');
        let itemsIdList = [];
        for (let iterator = 0; iterator < storedKeysArray.length; iterator++) {
            let singleStoredItem = localStorage.getItem(storedKeysArray[iterator]);
            if (singleStoredItem.charAt(0) == '"') {
                singleStoredItem = singleStoredItem.substring(1);
            }
            if (singleStoredItem.charAt(singleStoredItem.length - 1) == '"') {
                singleStoredItem = singleStoredItem.substring(0, singleStoredItem.length - 1);
            }
            itemsIdList.push(singleStoredItem);
        }
        let action = component.get('c.placeOrder');
        action.setParams({
            productsId: itemsIdList
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
//                this.onDeleteAllItems(component);
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Order placed",
                    "message": "Your order has been submitted",
                    type: "success",
                });
                toastEvent.fire();
            } else {
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Error",
                    "message": "Could not place an order",
                    type: "error",
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    }
})