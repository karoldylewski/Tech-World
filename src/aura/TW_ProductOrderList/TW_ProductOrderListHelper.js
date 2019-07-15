/**
 * Created by BRITENET on 11.07.2019.
 */
({
    onInit: function(component) {
        let action = component.get('c.getUserOrders');
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let responseItem = response.getReturnValue();
                component.set('v.items', responseItem);
            } else {
                console.log(JSON.stringify(response.getReturnValue()));
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Error",
                    "message": "Could not load orders",
                    type: "error",
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    },
})