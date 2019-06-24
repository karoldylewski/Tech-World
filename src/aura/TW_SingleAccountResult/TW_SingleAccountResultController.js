/**
 * Created by BRITENET on 13.06.2019.
 */
({
    selectRow : function(component,event,helper){
        helper.selectRow(component,event);
    },
    updateAccount  : function(component,event,helper){
        let eventObject = event.getParam('account');
        if (component.get('v.item.Id') == eventObject.Id){
            component.set("v.item", eventObject);
        }
    }
})