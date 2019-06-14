/**
 * Created by BRITENET on 13.06.2019.
 */
({
    openEditRecordModal : function (component){
//         let accId = component.get("v.item.Id");
//         component.find("navId").navigate({
//                type: 'standard__recordPage',
//                attributes: {
//                   recordId : accId,
//                   actionName: 'edit',
//                   objectApiName: 'Account'
//                }}, true);
        component.set("v.isEditOpen", true);
      var recordId = event.target.dataset.id;
      var editRecordEvent = $A.get("e.force:editRecord");
         editRecordEvent.setParams({
             "recordId": recordId
         });
         editRecordEvent.fire();
    },

//    handleAccountEdition : function (component,event){
//        let msg = event.getParams().message;
//        let begginingPart = msg.substring(0,7);
//        let endPart = msg.substring(msg.length-6,msg.length);
//        if (begginingPart == "Account" && endPart=="saved."){
//         var sendAccountToDetailsPanel = $A.get("e.c:TW_UpdateAccountInList");
//                sendAccountToDetailsPanel.setParams({
//               "account": component.get('v.item'),
//        });
//        sendAccountToDetailsPanel.fire();
//        }
//    },

    deleteRecord : function (component,event){
        component.set("v.isOpen", false);
        var searchInput = component.get("v.item");
        var action = component.get('c.deleteAccount');
        action.setParams({
               acc: searchInput
        });
        action.setCallback(this, function (response) {
             let state = response.getState();
             if (state === "SUCCESS") {
                var sendAccountToResult = $A.get("e.c:TW_RecordDeleted");
                 sendAccountToResult.fire();
             }
        });
        $A.enqueueAction(action);
    },

    saveRecord : function (component,event){
        component.set("v.isEditOpen", false);
        component.find("edit").get("e.recordSave").fire();
//        console.log('saved item: '+saveditem);
//        component.set("v.isEditOpen", false);
//        var searchInput = component.get("v.item");
//        console.log('Object: '+JSON.stringify(searchInput));
//        var action = component.get('c.updateAccount');
//        action.setParams({
//               acc: searchInput
//        });
//        action.setCallback(this, function (response) {
//             let state = response.getState();
//             if (state === "SUCCESS") {
//                 console.log('POSITIVE CALLBACk');
//                var sendAccountToResult = $A.get("e.c:TW_RecordEdited");
//                 sendAccountToResult.fire();
//             }else{
//                 console.log('NEGATIVE -  CALLBACk');
//             }
//        });
//        $A.enqueueAction(action);
//    }

    },
})