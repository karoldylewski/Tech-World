/**
 * Created by BRITENET on 16.07.2019.
 */
({
    onShowProducts: function(component) {
        console.log('item name: '+JSON.stringify(component.get("v.itemName")));
        let pricebookNode = component.get("v.itemId");
        let compEvent = component.getEvent("pricebookItemsEvent");
        compEvent.setParams({
                "itemId": pricebookNode,
                "itemName" : component.get("v.itemName"),
                "itemSd" : component.get("v.itemSd"),
                "itemEd" : component.get("v.itemEd"),
                "isActive" : component.get("v.isActive"),
        });
        compEvent.fire();
    }
})