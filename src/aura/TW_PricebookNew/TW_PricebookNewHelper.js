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

<<<<<<< HEAD
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
=======
    validateFields: function(component) {
        //        var validExpense = component.find('fieldId').reduce(function(validSoFar, inputCmp) {
        //            inputCmp.showHelpMessageIfInvalid();
        //            return validSoFar && inputCmp.get('v.validity').valid;
        //        }, true);

    },

    onSavePricebook: function(component) {
        //        this.validateFields(component);
        var validExpense = component.find('fieldId').reduce(function(validSoFar, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);

        if (!validExpense) {
            return;
        }
        let returnArray = [];
        let childCmps = component.find("childItem");
        for (let i = 0; i < childCmps.length; i++) {
            let returnRecord = childCmps[i].getRecordDetails();
            returnArray.push(returnRecord);
        }
        console.log('item list to send to apex:' + JSON.stringify(returnArray));
        let action = component.get("c.addNewPricebook");
        action.setParams({
            itemsList: returnArray,
            pricebookName: component.get("v.saleName"),
            sd: component.get("v.saleStartDate"),
            ed: component.get("v.saleEndDate"),
            isActive: component.get("v.saleIsActive"),
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (component.isValid() && state === 'SUCCESS') {
                let searchingResult = response.getReturnValue();
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success",
                    "message": "Pricebook has been saved",
                    type: "success",
                });
                toastEvent.fire();
                let compEvent = component.getEvent("pricebookAdded");
                compEvent.fire();
            } else {
                console.log(JSON.stringify(response.getReturnValue()));
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Error",
                    "message": "Could not save pricebook",
                    type: "error",
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);

    },

    onSearchProducts: function(component) {

        let searchingFor = component.get("v.searchedPhrase").split(" ");
        let action = component.get("c.getProductList");
        action.setParams({
            parameters: searchingFor
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (component.isValid() && state === 'SUCCESS') {
                let searchingResult = response.getReturnValue();
                component.set("v.searchingResultList", searchingResult.products);
            } else {
                console.log(JSON.stringify(response.getReturnValue()));
>>>>>>> feature/TW-14_Product-discount
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Error",
                    "message": "Could not load products",
                    type: "error",
                });
                toastEvent.fire();
<<<<<<< HEAD
                console.log(JSON.stringify(response.getReturnValue()));
=======
>>>>>>> feature/TW-14_Product-discount
            }
        });
        $A.enqueueAction(action);
    },
<<<<<<< HEAD
=======

    onAddProductsFromEvent: function(component, event) {
        let listToMerge = event.getParam("products");
        let existingList = component.get("v.products");
        let duplicateCounter = 0;
        for (let i = 0; i < listToMerge.length; i++) {
            let record = existingList.filter(item => item.product.Id == listToMerge[i].product.Id);
            if (record.length == 0) {
                existingList.push(listToMerge[i]);
            } else {
                duplicateCounter = duplicateCounter + 1;
            }
        }
        component.set('v.products', existingList);
        let addedTotal = listToMerge.length - duplicateCounter
        if (duplicateCounter > 0) {
            let toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": "Error",
                "message": "Found " + duplicateCounter + " duplicates. Added " + addedTotal + '/' + listToMerge.length,
                type: "warning",
            });
            toastEvent.fire();
        }
    },

    onRemoveProductFromEvent: function(component, event) {
        let idToRemove = event.getParam("productId");
        let existingList = component.get("v.products");
        let index = existingList.findIndex(x => x.product.Id === idToRemove);
        existingList.splice(index, 1);
        component.set("v.products", existingList);
    },

    onAddAllProducts: function(component, event) {
        let listToMerge = component.get("v.searchingResultList");
        let existingList = component.get("v.products");
        let duplicateCounter = 0;
        for (let i = 0; i < listToMerge.length; i++) {
            let record = existingList.filter(item => item.product.Id == listToMerge[i].product.Id);
            if (record.length == 0) {
                existingList.push(listToMerge[i]);
            } else {
                duplicateCounter = duplicateCounter + 1;
            }
        }
        component.set('v.products', existingList);
        let addedTotal = listToMerge.length - duplicateCounter
        if (duplicateCounter > 0) {
            let toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": "Warning",
                "message": "Found " + duplicateCounter + " duplicates. Added " + addedTotal + '/' + listToMerge.length,
                type: "warning",
            });
            toastEvent.fire();
        }
    }
>>>>>>> feature/TW-14_Product-discount
})