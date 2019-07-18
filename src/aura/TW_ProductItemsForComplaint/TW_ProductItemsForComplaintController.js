/**
 * Created by BRITENET on 15.07.2019.
 */
({
     handleEvent: function(component, event, helper) {
           console.log('event captured.');
           let orderIdToDisplay = event.getParam("orderId");
//           component.set("v.OrderId",orderId);
           console.log('order ID: s. '+orderIdToDisplay);
     },
})