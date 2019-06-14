/**
 * Created by BRITENET on 12.06.2019.
 */
({
    handleAccountDisplay : function (component,event,handler){
        component.set("v.item", event.getParam('account'));
    },

    navigationToEditRecord : function(component, event, helper) {
       //helper.openEditRecordModal(component);
        component.find('selectPropertiesModal').openModal();
    },

    navigationToDeleteRecord : function(component, event, helper) {
        component.set("v.isOpen", true);
    },

    clearResultList : function(component,event,helper){
          component.set("v.item", null);
    },

    closeDeleteRecordModel: function(component, event, helper) {
       component.set("v.isOpen", false);
    },

    closeEditRecordModel: function(component, event, helper) {
       component.find('selectPropertiesModal').closeModal();
    },

    deleteRecord: function(component, event, helper) {
       helper.deleteRecord(component,event);
    },

    editRecord : function(component, event, helper) {
         helper.saveRecord(component,event);
         component.find('selectPropertiesModal').closeModal();
    },

    savedItem : function(component, event, helper) {
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
    },
})