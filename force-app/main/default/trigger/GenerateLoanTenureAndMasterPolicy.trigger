trigger insuranceValidation on Contact (after insert, after update) { 
  Set<Id> contactsIds = new Set<Id>(); 
  List<Contact> contacts = new List<Contact>(); 
  List<Contact> contactsToUpdate = new List<Contact>(); 
  
  //Get the list of contacts to be processed 
  for(Contact cont : Trigger.new){ 
    if(cont.CRIF_Score__c != NULL && cont.Annual_Income__c != NULL && cont.Other_Demographic_Data__c != NULL){ 
      contactsIds.add(cont.Id); 
    } 
  } 
  
  //Retrieve the contacts from the database 
  contacts = [SELECT id, CRIF_Score__c, Annual_Income__c, Other_Demographic_Data__c, Loan_Tenure__c, Member_Master_Policy_No__c, Spouse_Master_Policy_No__c FROM Contact WHERE Id IN :contactsIds]; 
  
  //Validate the customer's eligibility for insurance coverage 
  for(Contact cont : contacts){ 
    if(cont.CRIF_Score__c > 700 && cont.Annual_Income__c > 20000 && cont.Other_Demographic_Data__c != NULL){ 
      //Generate loan tenure and Member/Spouse master policy no.’s 
      cont.Loan_Tenure__c = 12; 
      cont.Member_Master_Policy_No__c = 'ABC12345'; 
      cont.Spouse_Master_Policy_No__c = 'DEF67890'; 
      contactsToUpdate.add(cont); 
    } 
  } 
  
  //Send a COI to the customer via SMS and email 
  if(contactsToUpdate.size() > 0){ 
    //Send COI to customer via SMS and email 
  } 
  
  //Provide a reverse data feed to Bandhan Bank through Tableau 
  if(contactsToUpdate.size() > 0){ 
    //Send data to Tableau 
  } 
  
  //Update the contact records 
  if(contactsToUpdate.size() > 0){ 
    update contactsToUpdate; 
  } 
}