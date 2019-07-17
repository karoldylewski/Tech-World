/**
 * Created by BRITENET on 15.07.2019.
 */
({
        onInit: function(component, event) {
            console.log('complaint page on init');
            let orderId = event.getParam("orderId");
            component.set("v.OrderId",orderId);
            console.log('order ID: '+orderId);
        },
})