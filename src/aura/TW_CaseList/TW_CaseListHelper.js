/**
 * Created by BRITENET on 15.07.2019.
 */
({
    onInit: function(component) {
        let action = component.get('c.getUserComplaints');
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let responseItem = response.getReturnValue();
                component.set('v.items', responseItem);
                console.log(JSON.stringify(responseItem));
            } else {
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