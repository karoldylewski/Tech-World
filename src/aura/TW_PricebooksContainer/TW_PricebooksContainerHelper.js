/**
 * Created by BRITENET on 16.07.2019.
 */
({
    onShowPricebooks: function(component) {
        let pricebooksCallout = component.get('c.getAllPricebooks');
        pricebooksCallout.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let responseItem = response.getReturnValue();
                component.set("v.pricebooks", responseItem);
            } else {
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Error",
                    "message": "Could not load pricebooks",
                    type: "error",
                });
                toastEvent.fire();
                console.log(JSON.stringify(response.getReturnValue()));
            }
        });
        $A.enqueueAction(pricebooksCallout);
        component.set("v.toDisplay", 'pricebooks');
    },

    onNewPricebook: function(component) {
        component.set("v.toDisplay", 'new');
    },
})