/**
 * Created by BRITENET on 18.06.2019.
 */

public with sharing class TW_ChatterHelper {

    public static String getInstanceUrl(){
        return System.URL.getSalesforceBaseUrl().toExternalForm();
    }

    public static  List<CollaborationGroup> getGroup(){
        return [SELECT id,name FROM CollaborationGroup WHERE name = 'Sales'];
    }

    public static String getCustomSettingMessageValue(String csName){
        TW_Message__c myCS = TW_Message__c.getInstance(csName);
        return myCS.Value__c;
    }

    public class feedItem{
        ConnectApi.FeedItemInput feedItemInput {get; set;}
        ConnectApi.MentionSegmentInput mentionSegmentInput {get; set;}
        ConnectApi.MessageBodyInput messageBodyInput {get; set;}
        ConnectApi.TextSegmentInput textSegmentInput {get; set;}
        ConnectApi.FeedElementCapabilitiesInput feedElementCapabilitiesInput {get; set;}

        public feedItem(){
            feedItemInput = new ConnectApi.FeedItemInput();
            mentionSegmentInput = new ConnectApi.MentionSegmentInput();
            messageBodyInput = new ConnectApi.MessageBodyInput();
            textSegmentInput = new ConnectApi.TextSegmentInput();
            messageBodyInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();
            feedElementCapabilitiesInput = new ConnectApi.FeedElementCapabilitiesInput();
        }

        public void addMention(String id){
            mentionSegmentInput.id = Id;
            messageBodyInput.messageSegments.add(mentionSegmentInput);
        }

        public void addMessage(String csName,String title){
            textSegmentInput.text = ' '+TW_ChatterHelper.getCustomSettingMessageValue(csName)+' ' + title;
            messageBodyInput.messageSegments.add(textSegmentInput);
        }

        public void addLink(String id, String title){
            ConnectApi.LinkCapabilityInput linkat = new ConnectApi.LinkCapabilityInput();
            linkat.url = TW_ChatterHelper.getInstanceUrl()+'/one/one.app#/sObject/'+id+'/view';
            linkat.urlName = TW_ChatterHelper.getCustomSettingMessageValue('LinkHeader')+' ' +title;
            feedElementCapabilitiesInput.link = linkat;
        }

        public ConnectApi.FeedItemInput buildFeedItem(String groupId){
            feedItemInput.capabilities = feedElementCapabilitiesInput;
            feedItemInput.body = messageBodyInput;
            feedItemInput.feedElementType = ConnectApi.FeedElementType.FeedItem;
            feedItemInput.subjectId = groupId;
            return feedItemInput;
        }
    }
}