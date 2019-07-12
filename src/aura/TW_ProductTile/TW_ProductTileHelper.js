/**
 * Created by BRITENET on 10.07.2019.
 */
({
    displayDetails: function(component) {
        let productId = component.get("v.item.product.Id");
        let productName = component.get("v.item.product.Name");
        let productNameConvertedToUrl = productName.replace(/\s+/g, '-').toLowerCase();
        let productItemObject = component.get("v.item");
        let orgBaseUrl = component.get("v.orgUrl");
        let urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "/product/" + productId + "/" + productNameConvertedToUrl
        });
        urlEvent.fire();
        let productSelectedEvent = $A.get("e.c:TW_ProductSelected");
        productSelectedEvent.setParams({
            productObject: productItemObject,
            orgUrl: orgBaseUrl
        })
        productSelectedEvent.fire();
    },

    onAddToCart: function(component) {
        let thisProductId = component.get("v.item.product.Id");
        let currentTime = new Date();
        let thisProductKey = currentTime.getHours().toString() + currentTime.getMinutes().toString() +
            currentTime.getSeconds().toString() + Math.random();
        localStorage.setItem(thisProductKey, JSON.stringify(thisProductId));
        let storedItems = localStorage.getItem('productList');
        if (storedItems == null) {
            let storedKeysArray = [];
            storedKeysArray.push(thisProductKey);
            storedItems = storedKeysArray;
        } else {
            let storedKeysArray = storedItems.split(',');
            storedKeysArray.push(thisProductKey);
            storedItems = storedKeysArray;
        }
        localStorage.setItem('productList', storedItems);
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Added",
            "message": "Product is in your cart",
            type: "success",
        });
        toastEvent.fire();
        let appEvent = $A.get("e.c:TW_ProductAddedToCart");
        appEvent.fire();
    },
})