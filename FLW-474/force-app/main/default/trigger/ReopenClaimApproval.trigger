.

trigger ReopenClaimSubmittedByMaker on Acceptance_Criteria__c (after insert) {
    // Get the ids of all Approvers 
    Set<Id> approverIds = new Set<Id>();
    for (Acceptance_Criteria__c ac : Trigger.new) {
        approverIds.add(ac.Approver__c);
    }
    // Query for all the approvers
    List<User> approvers = [SELECT Id, Name FROM User WHERE Id IN :approverIds];
    // Create a map with the approver id and the user object
    Map<Id, User> approverMap = new Map<Id, User>();
    for (User u : approvers) {
        approverMap.put(u.Id, u);
    }
    // Loop through each record and set the approver field
    for (Acceptance_Criteria__c ac : Trigger.new) {
        if (approverMap.containsKey(ac.Approver__c)) {
            ac.Approver_Name__c = approverMap.get(ac.Approver__c).Name;
        }
        ac.is_Frozen__c = true;
    }
    // Update the records
    update Trigger.new;
}