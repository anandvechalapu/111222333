.

trigger ReopenClaimApproval on Claim__c (after insert, after update) {
    List<Id> claimIds = new List<Id>();
    for (Claim__c claim : Trigger.new) {
        if (claim.Reopen_Claim__c == true) {
            claimIds.add(claim.Id);
        }
    }
    if (claimIds.size() > 0) {
        // Get the list of Claims to be approved
        List<Claim__c> claimsToBeApproved = [SELECT Id, Maker__c, Status__c, Decision__c, Approver_Notes__c
                                            FROM Claim__c
                                            WHERE Id IN :claimIds
                                            AND Status__c = 'Reopen'];
        // Create a map of Claims to be approved
        Map<Id, Claim__c> claimMap = new Map<Id, Claim__c>();
        for (Claim__c claim : claimsToBeApproved) {
            claimMap.put(claim.Id, claim);
        }
        // Get the list of Approvers assigned to these Claims
        List<Approver_Assignment__c> approverAssignments = [SELECT Id, Claim__c, Approver__c
                                                           FROM Approver_Assignment__c
                                                           WHERE Claim__c IN :claimIds
                                                           AND Approver__c = :UserInfo.getUserId()];
        // Create a map of Approver Assignments
        Map<Id, Approver_Assignment__c> approverAssignmentMap = new Map<Id, Approver_Assignment__c>();
        for (Approver_Assignment__c assignment : approverAssignments) {
            approverAssignmentMap.put(assignment.Claim__c, assignment);
        }
        // If a Claim is in the map of Claims to be approved and 
        // the Approver Assignment Map, then validate the Decision and Notes
        List<Claim__c> claimsToUpdate = new List<Claim__c>();
        for (Claim__c claim : Trigger.new) {
            if (claimMap.containsKey(claim.Id) && approverAssignmentMap.containsKey(claim.Id)) {
                if (claim.Decision__c == 'Settled' || claim.Decision__c == 'Repudiate' || claim.Decision__c == 'On hold'
                    || claim.Decision__c == 'Send to Maker' || claim.Decision__c == 'Rejected') {
                    // Validate the Notes
                    if (claim.Approver_Notes__c == null || claim.Approver_Notes__c == '') {
                        claim.AddError('Approver Notes are required');
                    }
                    else {
                        claimsToUpdate.add(claim);
                    }
                }
                else {
                    claim.AddError('Please select a valid decision');
                }
            }
        }
        if (claimsToUpdate.size() > 0) {
            update claimsToUpdate;
        }
    }
}