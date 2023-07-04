Trigger: 

trigger InsuranceTrigger on Insurance_Application__c (after insert, after update) {

  // Creates list to store customers eligible for insurance coverage
  List<Insurance_Application__c> usersEligibleForInsurance = new List<Insurance_Application__c>();

  // Checks if customer meets criteria to be eligible for insurance coverage
  for(Insurance_Application__c app : Trigger.new) {
    if(app.Annual_Income__c > 200000 && app.CRIF_Score__c > 750 && app.Demographic_Data__c != null) {
      usersEligibleForInsurance.add(app);
    }
  }

  // Generates loan tenure and Member/Spouse wise master policy no. for users eligible for insurance coverage
  if(usersEligibleForInsurance.size() > 0) {
    generateLoanTenureAndMasterPolicyNoForUsers(usersEligibleForInsurance); 
  }

  // Generates COI for users eligible for insurance coverage
  if(usersEligibleForInsurance.size() > 0) {
    generateCOIForUsers(usersEligibleForInsurance); 
  }

  // Sends COI to users eligible for insurance coverage
  if(usersEligibleForInsurance.size() > 0) {
    sendCOIToUsers(usersEligibleForInsurance); 
  }

  // Provides reverse data feed to Bandhan Bank through Tableau
  if(usersEligibleForInsurance.size() > 0) {
    provideReverseDataFeedToBank(usersEligibleForInsurance); 
  }

}

public void generateLoanTenureAndMasterPolicyNoForUsers(List<Insurance_Application__c> usersEligibleForInsurance) {
  // Generates loan tenure and Member/Spouse wise master policy no. for users eligible for insurance coverage
  for(Insurance_Application__c app : usersEligibleForInsurance) {
    // Generates loan tenure
    app.Loan_Tenure__c = generateLoanTenure(); 
    // Generates Member/Spouse wise master policy no.
    app.Member_Spouse_wise_Master_Policy_No__c = generateMasterPolicyNo(); 
    update app;
  }
}

public void generateCOIForUsers(List<Insurance_Application__c> usersEligibleForInsurance) {
  // Generates COI for users eligible for insurance coverage
  for(Insurance_Application__c app : usersEligibleForInsurance) {
    // Generates COI
    app.Certificate_of_Insurance__c = generateCOI(); 
    update app;
  }
}

public void sendCOIToUsers(List<Insurance_Application__c> usersEligibleForInsurance) {
  // Sends COI to users eligible for insurance coverage
  for(Insurance_Application__c app : usersEligibleForInsurance) {
    // Sends COI via SMS
    sendSMSWithCOI(app.Certificate_of_Insurance__c); 
    // Sends COI via Email
    sendEmailWithCOI(app.Certificate_of_Insurance__c); 
  }
}

public void provideReverseDataFeedToBank(List<Insurance_Application__c> usersEligibleForInsurance) {
  // Provides reverse data feed to Bandhan Bank through Tableau
  List<Tableau_Data__c> tableauDataList = new List<Tableau_Data__c>();
  for(Insurance_Application__c app : usersEligibleForInsurance) {
    // Creates Tableau_Data__c object and adds to list
    Tableau_Data__c tableauData = new Tableau_Data__c(Name = app.Name, Loan_Tenure__c = app.Loan_Tenure__c, Member_Spouse_wise_Master_Policy_No__c = app.Member_Spouse_wise_Master_Policy_No__c);
    tableauDataList.add(tableauData);
  }
  // Inserts Tableau_Data__c records
  if(tableauDataList.size() > 0) {
    insert tableauDataList; 
  }
}