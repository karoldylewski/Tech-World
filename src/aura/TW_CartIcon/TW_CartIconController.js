/**
 * Created by BRITENET on 12.07.2019.
 */
({
    doInit: function(component, event, helper) {
         helper.onInit(component);
    },

    navigateToCart: function(component, event, helper) {
         let urlEvent = $A.get("e.force:navigateToURL");
         urlEvent.setParams({
           "url": "/cart"
         });
         urlEvent.fire();
    }
})