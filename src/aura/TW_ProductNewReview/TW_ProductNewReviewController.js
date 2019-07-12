/**
 * Created by BRITENET on 12.07.2019.
 */
({
    doInit: function(component, event, helper){
        helper.onInit(component);
    },

    saveReview: function(component, event, helper){
         helper.onSave(component,event);
    },

    ratingChanged: function(component,event,helper){
        helper.ratingChanged(component,event);
    }
})