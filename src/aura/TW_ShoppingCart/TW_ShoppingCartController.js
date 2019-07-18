/**
 * Created by BRITENET on 10.07.2019.
 */
({
    doInit: function(component, event, helper) {
        helper.onInit(component);
    },

    orderItems: function(component, event, helper) {
        helper.onOrderItems(component);
    },

    deleteItems: function(component, event, helper) {
        helper.onDeleteAllItems(component);
    },
})