/**
 * Created by BRITENET on 10.07.2019.
 */
({
    doInit: function(component, event, helper) {
        helper.onInit(component);
    },

    orderItems: function(component, event, helper) {
        console.log('Order items from cart');
    },
    deleteItems: function(component, event, helper) {
        helper.onDeleteAllItems(component);
    },
})