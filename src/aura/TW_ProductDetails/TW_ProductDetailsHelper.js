/**
 * Created by BRITENET on 10.07.2019.
 */
({
    onInit: function(component) {
        let itemId = component.get("v.ProductId");
        let action = component.get('c.getProductDetails');
        action.setParams({
            productId: itemId
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let responseItem = response.getReturnValue();
                component.set("v.orgUrl", responseItem.orgId);
                component.set("v.item", responseItem);
                console.log(JSON.stringify(responseItem));
            } else {
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Error",
                    "message": "Could not load product",
                    type: "error",
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    },
})