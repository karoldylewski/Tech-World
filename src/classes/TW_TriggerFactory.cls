/**
 * Created by BRITENET on 09.07.2019.
 */


public with sharing class TW_TriggerFactory {
    public static void createHandler(Schema.sObjectType soType) {
        TW_ITrigger handler = getHandler(soType);
        execute(handler);

    }
    private static void execute(TW_ITrigger handler) {
        if (Trigger.isBefore) {
            handler.bulkBefore();
        } else {
            handler.bulkAfter();
        }
    }

    private static TW_ITrigger getHandler(Schema.sObjectType soType) {
        if (soType == ContentVersion.sObjectType) {
            return new TW_ContentVersionTriggerHandler();
        }
        return null;
    }
}