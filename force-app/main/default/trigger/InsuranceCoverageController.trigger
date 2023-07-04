Trigger Code:

trigger GenerateLoanTenureInsurance on Contact (after insert, after update) {

// Declare Variables

Map<String, String> CRIFScoreMap = new Map<String, String>();

// Populate Map

for(Contact c : Trigger.new) {

CRIFScoreMap.put(c.Id, c.CRIF_Score__c);

}

// Callout to CRIF

CRIF_Score__c response = getCRIFScore(CRIFScoreMap);

for (Contact c : Trigger.new) {

// Check eligibility based on CRIF Score

if (response.CRIF_Score__c > 600) {

// Generate Loan Tenure and Member/Spouse wise Master Policy No.

c.Loan_Tenure__c = response.Loan_Tenure__c;

c.Member_Spouse_wise_Master_Policy_No__c = response.Member_Spouse_wise_Master_Policy_No__c;

// Generate COI and send it to the customer via SMS and email

generateCOI(c.Id);

// Provide reverse data feed to Bandhan Bank through Tableau

Integration.BandhanBankDataFeed.sendDataToTableau(Trigger.new);

}

}

}