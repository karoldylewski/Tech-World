/**
 * Created by BRITENET on 25.06.2019.
 */
({
    selectRow: function(component, event) {
        let sendAccountToDetailsPanel = $A.get("e.c:TW_AccountSendToDetailsPanel");
        sendAccountToDetailsPanel.setParams({
            "account": component.get('v.item'),
        });
        sendAccountToDetailsPanel.fire();
        let accNumber = component.get('v.item.AccountNumber');
        let allTrows = document.getElementsByClassName("singleRow");
        for (let i = 0; i < allTrows.length; i++) {
            allTrows[i].classList.remove("selected");
        }
        let trow = document.getElementById("tableRow" + accNumber);
        trow.className += " selected";
    },

    updateAccount : function (component,event){
        let eventObject = event.getParam('account');
        if (component.get('v.item.Id') == eventObject.Id){
            component.set("v.item", eventObject);
        }
    }
})