/**
 * Created by BRITENET on 16.07.2019.
 */
({
    onShowProducts: function(component) {
        let pricebookNode = document.getElementsByName('pricebook-to-display');
        console.log(JSON.stringify(pricebookNode));

        let pricebooksCallout = component.get('c.getPricebookAllEntries');
        pricebooksCallout.setParams({
            pricebookId: component
        });
        pricebooksCallout.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let responseItem = response.getReturnValue();
                component.set("v.pricebooks", responseItem);
            } else {
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Error",
                    "message": "Could not load pricebook products",
                    type: "error",
                });
                toastEvent.fire();
                console.log(JSON.stringify(response.getReturnValue()));
            }
        });
        $A.enqueueAction(pricebooksCallout);
    }
})