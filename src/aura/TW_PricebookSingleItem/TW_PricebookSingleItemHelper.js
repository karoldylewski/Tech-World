/**
 * Created by BRITENET on 16.07.2019.
 */
({
    onShowProducts: function(component) {
        let pricebookNode = component.get("v.itemId");
        console.log('pricebookNode: ' + pricebookNode);

        let pricebooksCallout = component.get('c.getPricebookAllEntries');
        pricebooksCallout.setParams({
            pricebookId: pricebookNode
        });
        pricebooksCallout.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let responseItem = response.getReturnValue();
                let compEvent = component.getEvent("pricebookItemsEvent");
                compEvent.setParams({
                    "items": responseItem
                });
                compEvent.fire();
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