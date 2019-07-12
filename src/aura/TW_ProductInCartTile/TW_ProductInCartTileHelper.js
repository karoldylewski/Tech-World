/**
 * Created by BRITENET on 10.07.2019.
 */
({
    onRemoveItem: function(component) {
        let targetItemId = component.get("v.item.product.Id");
        let storedItems = localStorage.getItem('productList');
        if (storedItems != null) {
            let storedKeysArray = storedItems.split(',');
            for (let iterator = 0; iterator < storedKeysArray.length; iterator++) {
                let singleStoredItem = localStorage.getItem(storedKeysArray[iterator]);
                if (singleStoredItem.charAt(0) == '"') {
                    singleStoredItem = singleStoredItem.substring(1);
                }
                if (singleStoredItem.charAt(singleStoredItem.length - 1) == '"') {
                    singleStoredItem = singleStoredItem.substring(0, singleStoredItem.length - 1);
                }
                if (singleStoredItem == targetItemId) {
                    let indexToRemove = storedKeysArray[iterator];
                    if (storedKeysArray.length == 1) {
                        localStorage.removeItem('productList')
                        localStorage.removeItem(indexToRemove);
                    } else {
                        storedKeysArray.splice(iterator, 1);
                        localStorage.removeItem('productList')
                        localStorage.setItem('productList', storedKeysArray);
                        localStorage.removeItem(indexToRemove);
                    }
                    let compEvent = component.getEvent("productRemovedFromCart");
                    compEvent.fire();
                    return;
                }

            }
        }
    },

    onAddItem: function(component) {
        let thisProductId = component.get("v.item.product.Id");
        let currentTime = new Date();
        let thisProductKey = currentTime.getHours().toString() + currentTime.getMinutes().toString() +
            currentTime.getSeconds().toString() + Math.random();
        localStorage.setItem(thisProductKey, JSON.stringify(thisProductId));
        let storedItems = localStorage.getItem('productList');
        let storedKeysArray = storedItems.split(',');
        storedKeysArray.push(thisProductKey);
        localStorage.setItem('productList', storedKeysArray);
        let compEvent = component.getEvent("productRemovedFromCart");
        compEvent.fire();
    },

    onSeeDetails: function(component) {
       let productId = component.get("v.item.product.Id");
       let urlEvent = $A.get("e.force:navigateToURL");
       urlEvent.setParams({
             "url": "/product/"+productId
       });
       urlEvent.fire();

    }
})