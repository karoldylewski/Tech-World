/**
 * Created by BRITENET on 10.07.2019.
 */
({
    doInit: function(component, event, helper){
            helper.getProductDetails(component);
    },

    loadProductDetails: function(component, event, helper){
     console.log('load product details from event ');
    }
})