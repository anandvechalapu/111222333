trigger ReopenClaimApproval on Claim__c (after insert, after update) 
{
    //Create a List to store Claims 
    List<Claim__c> claimList = new List<Claim__c>();
    //Loop through the Trigger.new and add all Claim records to the claimList 
    for(Claim__c claim : Trigger.new)
    {
        if(claim.Status__c == 'Reopen Claim Submitted by Maker')
        {
            claimList.add(claim);
        }
    }
    //Check if the claimList is not empty 
    if(!claimList.isEmpty())
    {
        //Create a List of Approval Process Steps 
        List<Approval_Process_Steps__c> approvalProcessStepsList = new List<Approval_Process_Steps__c>();
        //Query all Approval Process Steps for Reopen Claims
        for(Approval_Process_Steps__c approvalProcessSteps : [SELECT Id, Name, Decision__c, Status__c, Claim__c 
            FROM Approval_Process_Steps__c WHERE Claim__c IN : claimList])
        {
            approvalProcessStepsList.add(approvalProcessSteps);
        }
        //Loop through the approvalProcessStepsList and check if the Approver has taken a decision 
        for(Approval_Process_Steps__c approvalProcessSteps : approvalProcessStepsList)
        {
            //Check if the Approver has taken a decision 
            if(approvalProcessSteps.Decision__c != null)
            {
                //Create a List of Claims 
                List<Claim__c> updatedClaimList = new List<Claim__c>();
                //Loop through the claimList and check if the Ids match
                for(Claim__c claim : claimList)
                {
                    //Check if the Ids match
                    if(approvalProcessSteps.Claim__c == claim.Id)
                    {
                        //Check the Decision taken by the Approver 
                        if(approvalProcessSteps.Decision__c == 'Approve with below mention recommendation')
                        {
                            //Update the Claim Status to Settled 
                            claim.Status__c = 'Settled';
                            //Add the Claim to the updatedClaimList 
                            updatedClaimList.add(claim);
                        }
                        else if(approvalProcessSteps.Decision__c == 'Repudiate')
                        {
                            //Update the Claim Status to Repudiate 
                            claim.Status__c = 'Repudiate';
                            //Add the Claim to the updatedClaimList 
                            updatedClaimList.add(claim);
                        }
                        else if(approvalProcessSteps.Decision__c == 'On Hold')
                        {
                            //Update the Claim Status to On Hold 
                            claim.Status__c = 'On Hold';
                            //Add the Claim to the updatedClaimList 
                            updatedClaimList.add(claim);
                        }
                        else if(approvalProcessSteps.Decision__c == 'Send to Maker')
                        {
                            //Update the Claim Status to Maker 
                            claim.Status__c = 'Send to Maker';
                            //Add the Claim to the updatedClaimList 
                            updatedClaimList.add(claim);
                        }
                        else if(approvalProcessSteps.Decision__c == 'Rejected')
                        {
                            //Update the Claim Status to Rejected 
                            claim.Status__c = 'Rejected';
                            //Add the Claim to the updatedClaimList 
                            updatedClaimList.add(claim);
                        }
                    }
                }
                //Update the Claims in the updatedClaimList 
                if(!updatedClaimList.isEmpty())
                {
                    update updatedClaimList;
                }
            }
        }
    }
}