/**
 * Created by BRITENET on 16.07.2019.
 */
({
        onAddItemToList : function(component){
            let dataList=[];
            let data = component.get("v.item");
            dataList.push(data);
            let compEvent = component.getEvent("addProductToList");
            compEvent.setParams({"products" : dataList });
            compEvent.fire();
        }
})