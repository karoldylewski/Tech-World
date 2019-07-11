/**
 * Created by BRITENET on 09.07.2019.
 */

public with sharing class TW_ProductServiceResult {

    public List<TW_ProductWrapper> products {get; set;}

    public TW_ProductServiceResult(List<TW_ProductWrapper> prodList){
        this.products = prodList;
    }
}