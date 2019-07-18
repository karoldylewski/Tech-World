/**
 * Created by BRITENET on 15.07.2019.
 */
({
        onSeeDetails: function(component) {
            let existingItems = component.get("v.complaintItems");
            if (existingItems.length != 0){
                return;
            }
            let action = component.get('c.getCaseItems');
            action.setParams({
                caseId: component.get("v.item.Id")
            });
            action.setCallback(this, function(response) {
                let state = response.getState();
                if (state === "SUCCESS") {
                    let responseItem = response.getReturnValue();
                    component.set('v.complaintItems', responseItem);
                    console.log(JSON.stringify(responseItem));
                } else {
                    let toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Error",
                        "message": "Could not load complaint items",
                        type: "error",
                    });
                    toastEvent.fire();
                    console.log(JSON.stringify(responseItem))
                }
            });
            $A.enqueueAction(action);
        },
})