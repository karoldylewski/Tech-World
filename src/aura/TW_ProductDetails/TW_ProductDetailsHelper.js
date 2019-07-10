/**
 * Created by BRITENET on 10.07.2019.
 */
({
    getProductDetails: function(component, event){
       let productObject = event.getParam("productObject");
       component.set("v.item",productObject);
    }
})