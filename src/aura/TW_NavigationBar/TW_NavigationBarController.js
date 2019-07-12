({
    onMenuItemClicked: function(component, event, helper) {
        let menuItemId = event.currentTarget.dataset.id;
        if (menuItemId) {
            helper.navigateToMenuItem(component, menuItemId);
        }
    }
})