/**
 * Created by BRITENET on 14.06.2019.
 */

public with sharing class TW_PostToChatter {
    @InvocableMethod
    public static void createNewChatterPost(List<String> leadId) {
        List<CollaborationGroup> publicGroups = TW_ChatterHelper.getGroup();
        String groupId = publicGroups[0].Id;
        List<Lead> givenLeads = TW_LeadHandler.getLeadsByIds(leadId);

        for (Lead eachLead : givenLeads) {
            TW_ChatterHelper.feedItem feedItem = new TW_ChatterHelper.feedItem();
            feedItem.addMention(eachLead.CreatedBy.Id);
            feedItem.addMessage('ChatterNewLead',eachLead.Title);
            feedItem.addLink(eachLead.Id,eachLead.Title);
            ConnectApi.FeedElement feedElement = ConnectApi.ChatterFeeds.postFeedElement(Network.getNetworkId(), feedItem.buildFeedItem(groupId));
        }

    }
//    @InvocableMethod
//    public static void createNewChatterPost(List<String> leadId) {
//        List<CollaborationGroup> publicGroups = [SELECT id,name FROM CollaborationGroup WHERE name = 'Sales'];
//        String groupId = publicGroups[0].Id;
//        String instanceUrl = TW_ChatterHelper.getInstanceUrl();
//        List<Lead> givenLeads = [SELECT id,Name,Owner.Name, company,status,CreatedDate,CreatedBy.Name, LeadSource, Title FROM Lead WHERE id IN :leadId];
//        for (Lead eachLead : givenLeads) {
//
//            ConnectApi.FeedItemInput feedItemInput = new ConnectApi.FeedItemInput();
//            ConnectApi.MentionSegmentInput mentionSegmentInput = new ConnectApi.MentionSegmentInput();
//
//            ConnectApi.MessageBodyInput messageBodyInput = new ConnectApi.MessageBodyInput();
//            ConnectApi.TextSegmentInput textSegmentInput = new ConnectApi.TextSegmentInput();
//
//            messageBodyInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();
//
//            mentionSegmentInput.id = eachLead.CreatedBy.Id;
//            messageBodyInput.messageSegments.add(mentionSegmentInput);
//
//            textSegmentInput.text = ' has created a new lead: ' + eachLead.Title;
//            messageBodyInput.messageSegments.add(textSegmentInput);
//
//            ConnectApi.LinkCapabilityInput linkat = new ConnectApi.LinkCapabilityInput();
//            linkat.url = instanceUrl+'/one/one.app#/sObject/'+eachLead.Id+'/view';
//            linkat.urlName = 'Go to Lead ' +eachLead.Title;
//            ConnectApi.FeedElementCapabilitiesInput feedElementCapabilitiesInput = new ConnectApi.FeedElementCapabilitiesInput();
//            feedElementCapabilitiesInput.link = linkat;
//
//
//            feedItemInput.capabilities = feedElementCapabilitiesInput;
//
//            feedItemInput.body = messageBodyInput;
//            feedItemInput.feedElementType = ConnectApi.FeedElementType.FeedItem;
//            feedItemInput.subjectId = groupId;
//
//            ConnectApi.FeedElement feedElement = ConnectApi.ChatterFeeds.postFeedElement(Network.getNetworkId(), feedItemInput);
//
//        }
//
//    }

//    private static String setPostBody(String leadStatus, String leadName, String leadCompany, String leadOwnerName, String leadCreateDate, String leadSource, String leadCreatedByName, String leadTitle) {
//        String postBody = '';
//
//        if (leadStatus == 'New' && leadSource != 'Web to Lead') {
//            postBody = '@' + leadCreatedByName + ' has created a new Lead - ' + leadTitle;
//            return postBody;
//        } else if (leadStatus == 'New' && leadSource == 'Web to Lead') {
//            postBody = 'New Lead ' + leadName + ' was created at ' + leadCreateDate + ' by Web-to-Lead';
//            return postBody;
//        } else if (leadStatus == 'Send an offer') {
//            postBody = 'An Offer was send to ' + leadName + '\r\nCompany: ' + leadCompany;
//            return postBody;
//        } else return null;
//    }
//    @InvocableMethod
//    public static void createNewChatterPost(List<String> leadId) {
//        List<CollaborationGroup> publicGroups = [SELECT id,name FROM CollaborationGroup WHERE name = 'Sales'];
//        String groupId = publicGroups[0].Id;
//
//        String instanceUrl = System.URL.getSalesforceBaseUrl().toExternalForm();
//        List<Lead> givenLeads = [SELECT id,Name,Owner.Name, company,status,CreatedDate,CreatedBy.Name, LeadSource FROM Lead WHERE id IN :leadId];
//        List<FeedItem> postsItems = new List<FeedItem>();
//
//        for (Lead eachLead : givenLeads) {
//            String createDate = String.valueOf(eachLead.CreatedDate.date());
//            String postBody = setPostBody(eachLead.Status, eachLead.Name, eachLead.Company, eachLead.Owner.Name, createDate, eachLead.LeadSource, eachLead.CreatedBy.Name, eachLead.Title);
//            String postLinkUrl = instanceUrl + '/one/one.app#/sObject/' + eachLead.Id + '/view';
//            postsItems.add(new FeedItem(
//                    body = postBody,
//                    type = 'LinkPost',
//                    LinkUrl = postLinkUrl,
//                    ParentId = groupId,
//                    Title = 'Go to Lead ' + eachLead.Name
//            ));
//        }
//        upsert postsItems;
//    }
//
//    private static String setPostBody(String leadStatus, String leadName, String leadCompany, String leadOwnerName, String leadCreateDate, String leadSource, String leadCreatedByName, String leadTitle) {
//        String postBody = '';
//
//        if (leadStatus == 'New' && leadSource != 'Web to Lead') {
//            postBody = '@['+leadCreatedByName + '] has created a new Lead - ' + leadTitle;
//            return postBody;
//        } else if (leadStatus == 'New' && leadSource == 'Web to Lead') {
//            postBody = 'New Lead ' + leadName + ' was created at ' + leadCreateDate + ' by Web-to-Lead';
//            return postBody;
//        } else if (leadStatus == 'Send an offer') {
//            postBody = 'An Offer was send to ' + leadName + '\r\nCompany: ' + leadCompany;
//            return postBody;
//        } else return null;
//    }

}