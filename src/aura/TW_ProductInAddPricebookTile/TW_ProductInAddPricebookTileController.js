/**
 * Created by BRITENET on 16.07.2019.
 */
({
    recalculate:function(component, event, helper) {
        let data = event.getParam('arguments');
<<<<<<< HEAD
        let newPrice = component.get('v.item.UnitPrice');

        if(component.get("v.isChecked")){
=======
        let newPrice = component.get('v.item.originalPrice');
>>>>>>> feature/TW-14_Product-discount
        if (data.data.discountType == 'val'){
            newPrice = newPrice - data.data.discountValue;
        }else if (data.data.discountType == 'perc'){
            newPrice = newPrice - ((data.data.discountValue / 100)*newPrice);
        }
<<<<<<< HEAD
        component.set("v.recalculatedPrice",newPrice);
        }else{
            component.set("v.recalculatedPrice",null);
        }
    }
=======
        if(newPrice<0){
             newPrice=null;
        }
        component.set("v.recalculatedPrice",newPrice);
    },

    removeItem: function(component, event, helper) {
        let idToRemove=component.get("v.item.product.Id")
        let compEvent = component.getEvent("removeProductFromList");
        compEvent.setParams({"productId" : idToRemove });
        compEvent.fire();
    },

    getRecordDetails: function(component, event, helper) {
        let record = [];
        record.push(component.get("v.item.product.Id"));
        record.push(component.get("v.item.product.Name"));
        let recalculatedPrice = component.get("v.recalculatedPrice");
        if (recalculatedPrice == null){
            recalculatedPrice = component.get("v.item.originalPrice")
        }
        record.push(recalculatedPrice);
        return record;
    },

>>>>>>> feature/TW-14_Product-discount
})