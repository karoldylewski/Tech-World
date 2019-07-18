/**
 * Created by BRITENET on 16.07.2019.
 */
({
    onShowProducts: function(component) {
        let pricebookNode = component.get("v.itemId");
        let compEvent = component.getEvent("pricebookItemsEvent");
        compEvent.setParams({
            "itemId": pricebookNode,
            "itemName": component.get("v.itemName"),
            "itemSd": component.get("v.itemSd"),
            "itemEd": component.get("v.itemEd"),
            "isActive": component.get("v.isActive"),
        });
        compEvent.fire();
    },

    onRemovePricebook: function(component) {
        let action = component.get("c.deletePricebook");
        action.setParams({
            pricebookId: component.get("v.itemId")
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (component.isValid() && state === 'SUCCESS') {
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success",
                    "message": "Pricebook has been removed",
                    type: "success",
                });
                toastEvent.fire();
                let compEvent = component.getEvent("pricebookRemoved");
                compEvent.fire();
            } else {
                console.log(JSON.stringify(response.getReturnValue()));
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Error",
                    "message": "Could not remove pricebook",
                    type: "error",
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    }
})