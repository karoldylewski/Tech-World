/**
 * Created by BRITENET on 12.07.2019.
 */
({
    onInit: function(component) {
        component.find("service").getNewRecord(
            "TW_Product_Review__c",
            null,
            false,
            $A.getCallback(function() {
                let error = component.get("v.recordError");
                let newReview = component.get("v.newReview");
                newReview.Content__c = ' ';
                component.set("v.newReview", newReview);
                if (error || (newReview === null)) {
                    console.log("Error initializing record template: " + error);
                }
            })
        );
    },

    onSave: function(component, event) {
        let obj = component.get("v.newReview");
        obj.Product__c = component.get("v.productId").toString();
        component.find("service").saveRecord(function(saveResult) {
            if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                var resultsToast = $A.get("e.force:showToast");
                if ($A.util.isUndefined(resultsToast)) {
                    alert('Review Saved successfully.');
                } else {
                    resultsToast.setParams({
                        "title": "Posted",
                        "message": "Review posted successfully.",
                        type: "success",
                    });
                    resultsToast.fire();
                }
                let compEvent = component.getEvent("reviewAdded");
                compEvent.fire();
            } else {
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Error",
                    "message": "Could not load product",
                    type: "error",
                });
                toastEvent.fire();
            }
        });
    },

    ratingChanged: function(component,event){
        let eventObject = event.getParam("ratingVal");
        component.set("v.newReview.Rating__c",eventObject);
    }
})