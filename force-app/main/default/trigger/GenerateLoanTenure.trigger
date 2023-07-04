trigger LoanTenureAndMemberPolicyNo on Bandhan_Bank__c (Before Insert, Before Update) {

// Create a Set to store all the eligible customers
Set<Id> eligibleCustomerIds = new Set<Id>(); 

// Loop through the records
for(Bandhan_Bank__c bankRecord : Trigger.new) {

    // Check if the customer is eligible for insurance coverage
    if(bankRecord.Annual_Income__c != null && bankRecord.CRIF_Score__c != null && bankRecord.Other_Demographic_Data__c != null) {
    
        // Calculate the eligibility
        Boolean isEligible = bankRecord.Annual_Income__c > 50000 && bankRecord.CRIF_Score__c > 650 && bankRecord.Other_Demographic_Data__c == 'Eligible';
        
        // If customer is eligible, add them to the set
        if(isEligible) {
            eligibleCustomerIds.add(bankRecord.Id);
        }
    }
} 

// Check if there are any eligible customers
if(!eligibleCustomerIds.isEmpty()) {
    
    // Query all the eligible customers
    List<Bandhan_Bank__c> eligibleCustomers = [SELECT Id, Loan_Tenure__c, Member_Master_Policy_No__c, Spouse_Master_Policy_No__c
                                              FROM Bandhan_Bank__c
                                              WHERE Id IN :eligibleCustomerIds];
    
    // Loop through the eligible customers
    for(Bandhan_Bank__c bankRecord : eligibleCustomers) {
        
        // Create the loan tenure and master policy no.’s
        bankRecord.Loan_Tenure__c = 12;
        bankRecord.Member_Master_Policy_No__c = 'MMPN_' + bankRecord.Id;
        bankRecord.Spouse_Master_Policy_No__c = 'SMPN_' + bankRecord.Id;
    
        // Generate the COI
        generateCOI(bankRecord);
    }
    
    // Update the eligible customers with the loan tenure and master policy no.’s
    update eligibleCustomers;
    
    // Send the reverse data feed to Bandhan Bank through Tableau
    sendDataFeedToTableau();
}

// Method to generate the COI
private void generateCOI(Bandhan_Bank__c bandhanBankRecord) {
    // Generate the COI
    // Send COI to customer via SMS and email
}

// Method to send the reverse data feed to Bandhan Bank through Tableau
private void sendDataFeedToTableau() {
    // Send the reverse data feed to Bandhan Bank through Tableau
}
}