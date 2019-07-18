/**
 * Created by BRITENET on 17.07.2019.
 */
({
     onInit: function(component) {
//            let itemId = component.get("v.ProductId");
            let action = component.get('c.getHighlightProduct');
            action.setCallback(this, function(response) {
                let state = response.getState();
                if (state === "SUCCESS") {
                    let responseItem = response.getReturnValue();
                    console.log('review item: '+JSON.stringify(responseItem));
                    component.set("v.orgUrl", responseItem.orgId);
                    component.set("v.item", responseItem);
//                    this.loadReviews(component);
                } else {
                    let toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Error",
                        "message": "Could not load product",
                        type: "error",
                    });
                    toastEvent.fire();
                    console.log(JSON.stringify(response.getReturnValue()));
                }
            });
            $A.enqueueAction(action);
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