/**
 * Created by BRITENET on 12.06.2019.
 */
({
    handleAccountDisplay : function (component,event,handler){
        component.set("v.item", event.getParam('account'));
    },

    navigationToEditRecord : function(component, event, helper) {
        component.find('editRecordModal').openModal();
    },

    navigationToDeleteRecord : function(component, event, helper) {
        component.find('deleteRecordModal').openModal();
    },

    clearResultList : function(component,event,helper){
          component.set("v.item", null);
    },

    closeDeleteRecordModel: function(component, event, helper) {
       component.find('deleteRecordModal').closeModal();
    },

    closeEditRecordModel: function(component, event, helper) {
       component.find('editRecordModal').closeModal();
    },

    deleteRecord: function(component, event, helper) {
       helper.deleteRecord(component,event);
       component.find('deleteRecordModal').closeModal();
    },

    editRecord : function(component, event, helper) {
       helper.saveRecord(component,event);
       component.find('editRecordModal').closeModal();
    },

    savedItem : function(component, event, helper) {
        helper.updateDisplayInfo(component,event);
    },
})