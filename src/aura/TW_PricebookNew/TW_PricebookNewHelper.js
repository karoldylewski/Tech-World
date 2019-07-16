/**
 * Created by BRITENET on 16.07.2019.
 */
({
    onSliderChange: function(component) {
        let data = {
            discountValue: component.get("v.discountValueSlider"),
            discountType: component.get("v.saleTypeRadioValue"),
        };
        let childCmps = component.find("childItem");
        for (let i = 0; i < childCmps.length; i++) {
            childCmps[i].recalculatePrice(data);
        }
    },

    onValueChange: function(component) {
        let data = {
            discountValue: component.get("v.discountValueInput"),
            discountType: component.get("v.saleTypeRadioValue"),
        };
        let childCmps = component.find("childItem");
        for (let i = 0; i < childCmps.length; i++) {
            childCmps[i].recalculatePrice(data);
        }
    },

    onSavePricebook: function(component) {
                let data = {
                    discountValue: component.get("v.discountValueSlider"),
                    discountType: component.get("v.saleTypeRadioValue"),
                };
                let childCmps = component.find("childItem");
                for (let i = 0; i < childCmps.length; i++) {
                    childCmps[i].recalculatePrice(data);
                }
        console.log('save pricebook!');
    },


    onInit: function(component) {
        let action = component.get('c.getAllProducts');
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let responseItem = response.getReturnValue();
                component.set("v.products", responseItem);
                console.log(JSON.stringify(responseItem));
            } else {
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Error",
                    "message": "Could not load products",
                    type: "error",
                });
                toastEvent.fire();
                console.log(JSON.stringify(response.getReturnValue()));
            }
        });
        $A.enqueueAction(action);
    },
})