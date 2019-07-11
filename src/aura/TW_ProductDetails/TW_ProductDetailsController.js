/**
 * Created by BRITENET on 10.07.2019.
 */
({
    doInit: function(component, event, helper) {
        helper.onInit(component);
    },

    addToCart: function(component, event, helper){
        console.log('add item to cart');
    },

    goToCart: function(component, event, helper){
         let urlEvent = $A.get("e.force:navigateToURL");
         urlEvent.setParams({
           "url": "/cart/"
         });
         urlEvent.fire();
    }


})