/**
 * Created by BRITENET on 16.07.2019.
 */
({
    valueChanged: function(component, event, helper) {
        helper.onValueChange(component);
    },

    sliderChanged: function(component, event, helper) {
        helper.onSliderChange(component);
    },

    savePricebook: function(component, event, helper) {
        helper.onSavePricebook(component);
    },

    doInit: function(component, event, helper) {
         helper.onInit(component);
    },

    searchProducts: function(component, event, helper) {
         helper.onSearchProducts(component);
    },

    addProductsFromEvent: function(component, event, helper) {
         helper.onAddProductsFromEvent(component,event);
    },

    removeProductFromEvent: function(component, event, helper) {
         helper.onRemoveProductFromEvent(component,event);
    },

    addAllItemToList: function(component, event, helper) {
         helper.onAddAllProducts(component,event);
    }
})