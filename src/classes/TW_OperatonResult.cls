/**
 * Created by BRITENET on 13.06.2019.
 */

public with sharing class TW_OperatonResult {
    public String errorMessage {get; set;}
    public Boolean isSuccess {get; set;}

    public TW_OperatonResult(){
        isSuccess=true;
        errorMessage='';
    }
    public TW_OperatonResult(Boolean status, String msg){
        isSuccess=status;
        errorMessage=msg;
    }
}