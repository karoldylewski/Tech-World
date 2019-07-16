/**
 * Created by BRITENET on 16.07.2019.
 */
({
    showProducts: function(component, event, helper) {
        helper.onShowProducts(component);
    },

    loadPricebookItems: function(component, event, helper) {
        component.set('v.pricebookProducts', event.getParam("items"));
    }
})