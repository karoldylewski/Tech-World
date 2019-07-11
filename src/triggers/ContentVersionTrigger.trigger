/**
 * Created by BRITENET on 09.07.2019.
 */

trigger ContentVersionTrigger on ContentVersion (before insert, before update, before delete, after insert, after update, after delete) {
    TW_TriggerFactory.createHandler(ContentVersion.getSObjectType());
}