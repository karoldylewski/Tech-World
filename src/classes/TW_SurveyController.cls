/**
 * Created by BRITENET on 14.06.2019.
 */

global class TW_SurveyController {

    public TW_SurveyController(){
    }

    public List<SelectOption> getInterestedOptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Yes','Yes'));
        options.add(new SelectOption('No','No'));
        return options;
    }

    public List<SelectOption> getSatisfactionOptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('1','1'));
        options.add(new SelectOption('2','2'));
        options.add(new SelectOption('3','3'));
        options.add(new SelectOption('4','4'));
        options.add(new SelectOption('5','5'));
        options.add(new SelectOption('6','6'));
        options.add(new SelectOption('7','7'));
        options.add(new SelectOption('8','8'));
        options.add(new SelectOption('9','9'));
        options.add(new SelectOption('10','10'));
        return options;
    }

    public PageReference submit() {
        String interest = ApexPages.currentPage().getParameters().get('interestSelected');
        String satisfied = ApexPages.currentPage().getParameters().get('satisfactionSelected');
        TW_Survey__c surv = new TW_Survey__c();
        surv.Interested__c = interest;
        surv.Satisfied__c = Integer.valueOf(satisfied);
        insert surv;
        return null;
    }
}