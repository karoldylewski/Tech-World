/**
 * Created by BRITENET on 12.07.2019.
 */
({
    onInit: function(component) {
        component.set("v.cartItems",null);
        let storedItems = localStorage.getItem('productList');
        if (storedItems != null) {
            let storedKeysArray = storedItems.split(',');
            component.set("v.cartItems", storedKeysArray.length);
        }else{
            component.set("v.cartItems",'');
        }
    }
})