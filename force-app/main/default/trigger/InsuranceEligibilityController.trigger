Trigger: 

trigger LoanTenureandMemberSpouseWiseMasterPolicyNoGeneration on Account (before insert) {
 
  //Create a list of accounts to be inserted
  List<Account> accounts = Trigger.new;
  
  //Fetch the list of customers who are eligible for insurance coverage based on their annual income, CRIF score, and other demographic data
  List<Account> eligibleCustomers = [SELECT Id, Annual_Income__c, CRIF_Score__c, Other_Demographic_Data__c FROM Account WHERE Id IN :accounts AND Annual_Income__c > 0 AND CRIF_Score__c >= 0 AND Other_Demographic_Data__c != null];
  
   //Loop through each eligible customer
   for(Account account : eligibleCustomers) {
     //Generate loan tenure and Member/Spouse wise master policy no.’s
     account.Loan_Tenure__c = generateLoanTenure();
     account.Member_Spouse_Wise_Master_Policy_No__c = generateMasterPolicyNo();
     
     //Generate a COI for customers who are eligible for insurance coverage
     generateCOI(account.Id);
     
     //Send the COI to the customer via SMS and email.
     sendCOI(account.Id);
     
     //Provide a reverse data feed to Bandhan Bank through Tableau
     provideReverseDataFeed();
   }
}

public void generateCOI(Id accountId) {
 //Generate the COI
}

public void sendCOI(Id accountId) {
 //Send the COI to the customer via SMS and email
}

public void provideReverseDataFeed(){
 //Provide a reverse data feed to Bandhan Bank through Tableau
}

public Integer generateLoanTenure() {
 //Generate the loan tenure
}

public String generateMasterPolicyNo() {
 //Generate the Member/Spouse wise master policy no.’s
}