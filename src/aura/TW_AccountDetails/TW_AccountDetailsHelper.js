/**
 * Created by BRITENET on 13.06.2019.
 */
({
    openEditRecordModal: function(component) {
        component.set("v.isEditOpen", true);
        let recordId = event.target.dataset.id;
        let editRecordEvent = $A.get("e.force:editRecord");
        editRecordEvent.setParams({
            "recordId": recordId
        });
        editRecordEvent.fire();
    },

    deleteRecord: function(component, event) {
        component.set("v.isOpen", false);
        let searchInput = component.get("v.item");
        let action = component.get('c.deleteAccount');
        action.setParams({
            acc: searchInput
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let sendAccountToResult = $A.get("e.c:TW_AccountRecordDeleted");
                sendAccountToResult.fire();
            }else{
                let toastParams = {
                   title: "Error",
                    message: $A.get('$Label.c.TW_Apex_Error'),
                    type: "error"
                 };
                 let toastEvent = $A.get("e.force:showToast");
                 toastEvent.setParams(toastParams);
                 toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    },

    saveRecord: function(component, event) {
        component.set("v.isEditOpen", false);
        component.find("edit").get("e.recordSave").fire();
    },

    updateDisplayInfo: function(component, event) {
        let payload = event.getParams().response;
        let item = component.get('v.item');
        let obj = payload.fields;
        for (let key in obj) {
            item[key] = obj[key].value;
        }
        component.set("v.item", item);
        let sendAccountToResult = $A.get("e.c:TW_AccountRecordEdited");
        sendAccountToResult.setParams({
            "account": component.get('v.item'),
        });
        sendAccountToResult.fire();
    }
})