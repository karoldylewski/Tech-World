/**
 * Created by BRITENET on 12.07.2019.
 */
({
    navigateToHomePage: function(component,event,handler){
         let urlEvent = $A.get("e.force:navigateToURL");
         urlEvent.setParams({
           "url": "/"
         });
         urlEvent.fire();
    }
})