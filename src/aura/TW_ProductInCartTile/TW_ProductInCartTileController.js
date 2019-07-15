/**
 * Created by BRITENET on 10.07.2019.
 */
({
    removeItem: function(component, event, helper) {
        helper.onRemoveItem(component);
    },

    addItem: function(component, event, helper) {
        helper.onAddItem(component);
    },

    seeDetails: function(component, event, helper) {
        helper.onSeeDetails(component);
    },
})