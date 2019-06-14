/**
 * Created by BRITENET on 13.06.2019.
 */
({
        jsLoaded: function(component, event, helper) {
              helper.initiateMap(component);
        },

        accsLoaded: function(component, event, helper){
            helper.getMultiplePins(component,event);
        },

        singleAccLoaded : function (component,event,helper){
            helper.getSinglePin(component,event);
        },

        clearResultList : function(component,event,helper){
            helper.clearMapPins(component);
        }
})