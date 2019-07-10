/**
 * Created by BRITENET on 10.07.2019.
 */
({
    displayDetails : function(component){
        let productId = component.get("v.item.product.Id");
        let productName = component.get("v.item.product.Nd");
        let productItemObject = component.get("v.item");
        let urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
        	"url": "/product/"+productId+"/"+productName
        });
        urlEvent.fire();
        let productSelectedEvent = $A.get("e.c:TW_ProductSelected");
        productSelectedEvent.setParams({
            productObject : productItemObject
        })
        productSelectedEvent.fire();
    }
})