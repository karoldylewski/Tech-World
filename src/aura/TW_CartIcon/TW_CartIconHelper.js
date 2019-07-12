/**
 * Created by BRITENET on 12.07.2019.
 */
({
    onInit: function(component) {
        let storedItems = localStorage.getItem('productList');
        if (storedItems != null) {
            let storedKeysArray = storedItems.split(',');
            component.set("v.cartItems", storedKeysArray.length);
        }
    }
})