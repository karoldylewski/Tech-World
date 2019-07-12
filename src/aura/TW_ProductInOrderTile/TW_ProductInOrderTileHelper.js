({
    onSeeDetails: function(component) {
        let existingItems = component.get("v.orderItems");
        if (existingItems.length != 0){
            return;
        }
        let action = component.get('c.getOrderItems');
        action.setParams({
            orderId: component.get("v.item.Id")
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let responseItem = response.getReturnValue();
                component.set('v.orderItems', responseItem);
            } else {
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Error",
                    "message": "Could not load order items",
                    type: "error",
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    }
})