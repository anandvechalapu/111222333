Trigger code:

trigger LoanTenureAndMPMasterPolicyNo on Account (after insert, after update) {
  //list to store account id's
  List<Id> accIds = new List<Id>();
  
  // loop through all accounts
  for (Account acc : Trigger.new) {
    if(acc.Annual_Income__c > 0 && acc.CRIF_Score__c > 0) {
      //check eligibility for insurance coverage
      if(acc.Is_Eligible_for_Insurance_Coverage__c == true) {
        //store account Id
        accIds.add(acc.Id);
      }
    }
  }
  
  //query Contacts related to the accounts
  List<Contact> cnts = [SELECT Id, AccountId, Loan_Tenure__c, Member_Master_Policy_No__c, Spouse_Master_Policy_No__c 
                        FROM Contact
                        WHERE AccountId IN :accIds];
  
  //loop through contacts
  for (Contact con : cnts) {
    //create a COI
    CoI__c coi = new CoI__c();
    coi.Loan_Tenure__c = con.Loan_Tenure__c;
    coi.Member_Master_Policy_No__c = con.Member_Master_Policy_No__c;
    coi.Spouse_Master_Policy_No__c = con.Spouse_Master_Policy_No__c;
    //insert COI
    insert coi;
  }
  
  //send COI to customers via SMS and email
  SendCoI.sendCoIToCustomers(accIds);
  
  //provide reverse data feed to Bandhan Bank through Tableau
  UpdateTableau.updateTableauData(accIds);
  
}