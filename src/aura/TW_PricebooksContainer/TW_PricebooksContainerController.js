/**
 * Created by BRITENET on 16.07.2019.
 */
({
    showPricebooks: function(component, event, helper) {
        helper.onShowPricebooks(component);
    },

    newPricebook: function(component, event, helper) {
        helper.onNewPricebook(component);
    },

    loadPricebookToEdit: function(component, event, helper) {
        helper.onLoadPricebookToEdit(component,event);
    },
})