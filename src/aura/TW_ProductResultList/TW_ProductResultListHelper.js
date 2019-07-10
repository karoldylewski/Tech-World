/**
 * Created by BRITENET on 09.07.2019.
 */
({
    getProducts: function(component) {
        let searchingFor = component.get("v.searchQuery").split(" ");
        let action = component.get("c.getProductList");
        action.setParams({
            parameters: searchingFor
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (component.isValid() && state === 'SUCCESS') {
                let searchingResult = response.getReturnValue();
                console.log('LOG FROM TW_ProductResultListHelper .Incoming list: '+JSON.stringify(response.getReturnValue()))
                component.set("v.items", searchingResult.products);
                component.set("v.orgUrl", searchingResult.orgBaseUrl);
            } else {
                this.showErrorToast(component);
            }
        });
        $A.enqueueAction(action);
    },



    showErrorToast: function(component) {
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Error",
            "message": "Could not load products",
            type: "error",
        });
        toastEvent.fire();
    }
})