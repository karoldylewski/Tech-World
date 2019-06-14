/**
 * Created by BRITENET on 13.06.2019.
 */
({
    selectRow : function(component,event,handler){
        var sendAccountToDetailsPanel = $A.get("e.c:TW_SendAccountToDetailsPanel");
        sendAccountToDetailsPanel.setParams({
               "account": component.get('v.item'),
        });
        sendAccountToDetailsPanel.fire();
        var accNumber = component.get('v.item.AccountNumber');
        var allTrows = document.getElementsByClassName("singleRow");
        for(var i=0;i<allTrows.length;i++){
            allTrows[i].classList.remove("selected");
        }
        var trow = document.getElementById("tableRow"+accNumber);
        trow.className +=" selected";
    },
    updateAccount  : function(component,event,handler){
        let eventObject = event.getParam('account');
        if (component.get('v.item.Id') == eventObject.Id){
            component.set("v.item", eventObject);
        }
    }
})