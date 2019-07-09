/**
 * Created by BRITENET on 09.07.2019.
 */

public with sharing class TW_ProductWrapper {
    public Product2 product {get; set;}
    public Integer originalPrice {get; set;}
    public Integer currentPrice {get; set;}
    public TW_ProductWrapper(Product2 product, Integer orgPrice, Integer currPrice){
        this.product = product;
        this.originalPrice = orgPrice;
        this.currentPrice = currPrice;
    }
}