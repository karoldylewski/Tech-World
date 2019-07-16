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
    },

    onMakeComplaint: function(component) {
            let checkedItemsArray = [];
            let checkboxes = document.querySelectorAll('input[type=checkbox]:checked');
            for (let i = 0; i < checkboxes.length; i++) {
              checkedItemsArray.push(checkboxes[i].id);
            }
            console.log('array: '+checkedItemsArray);
            let action = component.get('c.makeAComplaint');
        action.setParams({
            productsId: checkedItemsArray,
            subject: component.get("v.complaintSubject"),
            description: component.get("v.complaintDesc"),
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let responseItem = response.getReturnValue();
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Submitted",
                    "message": "Your complaint has been submitted",
                    type: "success",
                });
                toastEvent.fire();
                component.set("v.complaintSubject",'');
                component.set("v.complaintDesc",'');
                for (let i = 0; i < checkboxes.length; i++) {
                     checkboxes[i].checked = false;
                }
            } else {
                console.log(JSON.stringify(response.getReturnValue()));
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Error",
                    "message": "Could not submit complaint",
                    type: "error",
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    },
})