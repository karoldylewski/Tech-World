/**
 * Created by BRITENET on 13.06.2019.
 */
({
    openEditRecordModal : function (component){
      component.set("v.isEditOpen", true);
      var recordId = event.target.dataset.id;
      var editRecordEvent = $A.get("e.force:editRecord");
      editRecordEvent.setParams({
          "recordId": recordId
      });
      editRecordEvent.fire();
    },

    deleteRecord : function (component,event){
        component.set("v.isOpen", false);
        var searchInput = component.get("v.item");
        var action = component.get('c.deleteAccount');
        action.setParams({
               acc: searchInput
        });
        action.setCallback(this, function (response) {
             let state = response.getState();
             if (state === "SUCCESS") {
                var sendAccountToResult = $A.get("e.c:TW_RecordDeleted");
                 sendAccountToResult.fire();
             }
        });
        $A.enqueueAction(action);
    },

    saveRecord : function (component,event){
        component.set("v.isEditOpen", false);
        component.find("edit").get("e.recordSave").fire();
    },

    updateDisplayInfo : function(component, event){
        var payload = event.getParams().response;
        let item = component.get('v.item');
        let obj = payload.fields;
        for (let key in obj) {
             item[key] = obj[key].value;
        }
        component.set("v.item", item);
        var sendAccountToResult = $A.get("e.c:TW_RecordEdited");
        sendAccountToResult.setParams({
            "account": component.get('v.item'),
        });
        sendAccountToResult.fire();
    }
})