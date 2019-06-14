/**
 * Created by BRITENET on 13.06.2019.
 */
({
    handleAccountFromSearch : function(component,event,helper){
        component.set("v.items", event.getParam('accountList'));
    },

    clearResultList : function (component,event,handler){
         component.set("v.items", '');
    },
})