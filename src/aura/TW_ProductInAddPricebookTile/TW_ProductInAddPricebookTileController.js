/**
 * Created by BRITENET on 16.07.2019.
 */
({
    recalculate:function(component, event, helper) {
        let data = event.getParam('arguments');
        let newPrice = component.get('v.item.UnitPrice');

        if(component.get("v.isChecked")){
        if (data.data.discountType == 'val'){
            newPrice = newPrice - data.data.discountValue;
        }else if (data.data.discountType == 'perc'){
            newPrice = newPrice - ((data.data.discountValue / 100)*newPrice);
        }
        component.set("v.recalculatedPrice",newPrice);
        }else{
            component.set("v.recalculatedPrice",null);
        }
    }
})