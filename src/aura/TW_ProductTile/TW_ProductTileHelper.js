/**
 * Created by BRITENET on 10.07.2019.
 */
({
    displayDetails : function(component){
        let productId = component.get("v.item.product.Id");
        let productName = component.get("v.item.product.Name");
        let productNameConvertedToUrl = productName.replace(/\s+/g, '-').toLowerCase();
        let productItemObject = component.get("v.item");
        let orgBaseUrl = component.get("v.orgUrl");
        let urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
        	"url": "/product/"+productId+"/"+productNameConvertedToUrl
        });
        urlEvent.fire();
        let productSelectedEvent = $A.get("e.c:TW_ProductSelected");
        productSelectedEvent.setParams({
            productObject : productItemObject,
            orgUrl : orgBaseUrl
        })
        productSelectedEvent.fire();
    }
})