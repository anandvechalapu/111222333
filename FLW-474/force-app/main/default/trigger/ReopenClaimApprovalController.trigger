.

trigger ReopenClaimApproval on Case (before update, after update) {
    // map to store all the cases assigned to Approver
    Map<Id, Case> caseToApprove = new Map<Id, Case>();

    // check if new case is created or existing one is updated
    if(Trigger.isBefore && Trigger.isUpdate){
        // get list of Cases to Approve
        for(Case ApprovalCase : Trigger.new){
            if(ApprovalCase.Status == 'Reopen Claim Submitted by Maker'){
                caseToApprove.put(ApprovalCase.Id, ApprovalCase);
            }
        }
    }

    // check if all the required fields for Approval is filled
    if(Trigger.isAfter && Trigger.isUpdate){
        for(Case ApprovalCase : Trigger.new){
            // check if decision is selected
            if(ApprovalCase.Decision__c != NULL){
                // check if approver notes are entered
                if(ApprovalCase.Approver_Notes__c != NULL){
                    // check for selected decision
                    if(ApprovalCase.Decision__c == 'Settled'){
                        // set Case status, Provision and Booking Amount
                        ApprovalCase.Claim_Status__c = 'Settled';
                        ApprovalCase.Provision__c = NULL;
                        ApprovalCase.Booking_Amount__c = ApprovalCase.Approver_Booking_Amount__c;
                    }
                    else if(ApprovalCase.Decision__c == 'Repudiate'){
                        // set Case status and Rejection letter
                        ApprovalCase.Claim_Status__c = 'Repudiate';
                        ApprovalCase.Rejection_Letter__c = 'Generated by System';
                    }
                    else if(ApprovalCase.Decision__c == 'On Hold'){
                        // set Case status
                        ApprovalCase.Claim_Status__c = 'On Hold';
                    }
                    else if(ApprovalCase.Decision__c == 'Send to Maker'){
                        // set Case status
                        ApprovalCase.Status = 'Reopen Claim Submitted by Maker';
                    }
                    else if(ApprovalCase.Decision__c == 'Rejected'){
                        // set Case status
                        ApprovalCase.Claim_Status__c = 'Rejected';
                    }
                }
                else{
                    // throw validation error if notes are not entered
                    ApprovalCase.addError('Approver Notes are mandatory before giving decision');
                }
            }
        }
    }
}