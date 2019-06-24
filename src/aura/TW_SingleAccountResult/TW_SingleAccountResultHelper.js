/**
 * Created by BRITENET on 24.06.2019.
 */
({
    selectRow: function(component, event) {
        let sendAccountToDetailsPanel = $A.get("e.c:TW_SendAccountToDetailsPanel");
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
    }
})