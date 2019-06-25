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
            feedItem.addMention(eachLead.OwnerId);
            feedItem.addMessage('ChatterNewLead',eachLead.Title);
            feedItem.addLink(eachLead.Id,eachLead.Title);
            ConnectApi.FeedElement feedElement = ConnectApi.ChatterFeeds.postFeedElement(Network.getNetworkId(), feedItem.buildFeedItem(groupId));
        }

    }

}