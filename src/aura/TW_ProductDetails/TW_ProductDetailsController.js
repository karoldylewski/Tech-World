({
    doInit: function(component, event, helper) {
        helper.onInit(component);
    },

    addToCart: function(component, event, helper){
        helper.onAddToCart(component);
    },

    goToCart: function(component, event, helper){
         let urlEvent = $A.get("e.force:navigateToURL");
         urlEvent.setParams({
           "url": "/cart/"
         });
         urlEvent.fire();
    },

    refreshReviews: function(component, event, helper) {
        helper.loadReviews(component);
        helper.onCheckIfUserCanReview(component);
    }
})