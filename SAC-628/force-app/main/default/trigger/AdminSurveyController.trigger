trigger AdminSurveyControllerTrigger on Survey__c (before insert, before update) {
    List<Id> userIds = new List<Id>();
    for(Survey__c survey : Trigger.new) {
        // Check if the Survey_State__c field is not set to "Started"
        if(survey.Survey_State__c != 'Started') {
            // Check if the user has appropriate permissions
            if(UserInfo.isSystemAdmin() || UserInfo.isCurrentUserLicensed('Admin')) {
                // Populate users ids
                if(Trigger.isInsert) {
                    userIds = survey.Survey_Users__c;
                }
                
                // Create or update survey
                if(Trigger.isInsert) {
                    AdminSurveyController.createSurvey(survey, userIds);
                }
                else if(Trigger.isUpdate) {
                    AdminSurveyController.updateSurvey(survey);
                }
            }
        }
    }
}