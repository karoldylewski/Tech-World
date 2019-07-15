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
                console.log(JSON.stringify(response.getReturnValue()));
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
    },

    onMakeComplaint: function(component) {
        let action = component.get('c.getOrderItems');
        action.setParams({
            orderId: component.get("v.item.Id")
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let responseItem = response.getReturnValue();
                component.set('v.orderItems', responseItem);
                    let orderItemsList = [];
                        for (let iterator = 0; iterator < responseItem.length; iterator++) {
                            for (let iterator2 = 0; iterator2 < responseItem[iterator].Quantity; iterator2++) {
                                let object = new Object();
                                object.name =responseItem[iterator].Product2.Name;
                                orderItemsList.push(object);
                            }
                        }
                        console.log('complaintOrderItems: '+JSON.stringify(orderItemsList));
                        component.set("v.complaintOrderItems",orderItemsList);
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
        let complaintForm = component.get("v.showComplaintForm");
        if (complaintForm){
            component.set("v.showComplaintForm",false);
        }else{
            component.set("v.showComplaintForm",true);
        }
    },

    onManageIdInComplaintList: function(component) {
        let complaintIds = component.get("v.complaintIds");
//        if (complaintIds != null){
//             for (let iterator = 0; iterator < complaintIds.length; iterator++) {
//                if (complaintIds[iterator] == targetItemId) {
//
//                }
//             }
//        }


    }
})