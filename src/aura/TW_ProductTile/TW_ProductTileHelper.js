/**
 * Created by BRITENET on 10.07.2019.
 */
({
    displayDetails : function(component){
        let productId = component.get("v.item.product.Id");
        let productName = component.get("v.item.product.Nd");
        let urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
        	"url": "/product/"+productId+"/"+productName
        });
        urlEvent.fire();
    }
})