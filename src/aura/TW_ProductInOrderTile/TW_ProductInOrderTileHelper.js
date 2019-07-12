({

    onSeeDetails: function(component) {
//        let orderItems = component.get("v.orderItems");
////        console.log('order items:'+orderItems+'.');
//        console.log('done.');
//        if (orderItems != ''){
//            return;
//        }
        let action = component.get('c.getOrderItems');
        action.setParams({
            orderId: component.get("v.item.Id")
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let responseItem = response.getReturnValue();
                component.set('v.orderItems', responseItem);
//                console.log('success.');
                console.log(JSON.stringify(responseItem));
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