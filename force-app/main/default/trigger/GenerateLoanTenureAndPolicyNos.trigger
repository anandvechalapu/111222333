trigger GenerateLoanTenureAndMasterPolicyNo on Account (after insert, after update) {
    //Declare a set of Id's
    Set<Id> accountIds = new Set<Id>();
    
    //Iterate over the list of new/updated Account records and add them to the set
    for (Account acc : Trigger.new) {
        if (acc.Annual_Income__c != null && acc.CRIF_Score__c != null && acc.Demographic_Data__c != null) {
            accountIds.add(acc.Id);
        }
    }
    
    //Query the Account records
    List<Account> accounts = [SELECT Id, Name, Loan_Tenure__c, Member_Wise_Master_Policy_No__c, Spouse_Wise_Master_Policy_No__c 
                             FROM Account 
                             WHERE Id IN :accountIds];
    
    //Create a list of Account records to be updated
    List<Account> accountsToBeUpdated = new List<Account>();
    
    //Iterate over the list of Accounts returned from the query
    for (Account acc : accounts) {
        //Check if the Account records qualified for insurance coverage
        if (acc.Annual_Income__c > 50000 && acc.CRIF_Score__c >= 750 && acc.Demographic_Data__c = 'Acceptable') {
            //Generate COI for customer
            //Send COI to customer via SMS and email
            //Reverse data feed to Bandhan Bank through Tableau
            //Generate Loan Tenure and Member/Spouse Wise Master Policy No.
            acc.Loan_Tenure__c = '2 Years';
            acc.Member_Wise_Master_Policy_No__c = '12345';
            acc.Spouse_Wise_Master_Policy_No__c = '54321';
            //Add Account record to the list of Accounts to be updated
            accountsToBeUpdated.add(acc);
        }
    }
    
    //Update the list of Account records
    update accountsToBeUpdated;
}