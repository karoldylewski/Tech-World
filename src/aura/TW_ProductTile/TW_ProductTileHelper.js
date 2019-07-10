/**
 * Created by BRITENET on 10.07.2019.
 */
({
    displayDetails : function(component){
        let productId = component.get("v.item.product.Id");
        let productName = component.get("v.item.product.Name");
        let productNameConvertedToUrl = productName.replace(/\s+/g, '-').toLowerCase();
        let productItemObject = component.get("v.item");
        console.log('before url redirect '+productId+' , '+productNameConvertedToUrl);
        let urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
        	"url": "/product/"+productId+"/"+productNameConvertedToUrl
//        	url: "/product/01t2p000007p4KAAAY/samsung-galaxy-s8"
        });
        urlEvent.fire();
        console.log('fired url redirect');

        let productSelectedEvent = $A.get("e.c:TW_ProductSelected");
        productSelectedEvent.setParams({
            productObject : productItemObject
        })
        productSelectedEvent.fire();

        console.log('fired obj event');
    }
})