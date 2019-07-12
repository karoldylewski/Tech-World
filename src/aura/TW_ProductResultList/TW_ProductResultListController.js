/**
 * Created by BRITENET on 09.07.2019.
 */
({
      doInit: function(component, event, helper){
        console.log('Searching for: '+component.get("v.searchQuery"));
        helper.getProducts(component);
      }
})