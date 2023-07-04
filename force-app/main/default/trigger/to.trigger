Trigger: BandhanBankInsuranceUpdate

on Loan_Application__c (after update) {

	//Loan Tenure and Master Policy No.
	List<Loan_Application__c> loan_application_list = new List<Loan_Application__c>();
	for(Loan_Application__c loan_application : Trigger.new) {
		//Check customer eligibility
		if(loan_application.Annual_Income__c != null && loan_application.CRIF_Score__c != null && loan_application.Other_Demographic_Data__c != null) {
			//Validate Eligibility
			if(loan_application.Eligible_for_Insurance__c == true) {
				//Generate Loan Tenure and Master Policy No.
				loan_application.Loan_Tenure__c = '12 months';
				loan_application.Member_Master_Policy_No__c = '123456789';
				loan_application.Spouse_Master_Policy_No__c = '987654321';
				loan_application_list.add(loan_application);
			}
		}
	}
	//Generate COI
	if(!loan_application_list.isEmpty()){
		List<COI__c> coi_list = new List<COI__c>();
		for(Loan_Application__c loan_application : loan_application_list) {
			COI__c coi = new COI__c();
			coi.Application_ID__c = loan_application.Id;
			coi.Loan_Tenure__c = loan_application.Loan_Tenure__c;
			coi.Member_Master_Policy_No__c = loan_application.Member_Master_Policy_No__c;
			coi.Spouse_Master_Policy_No__c = loan_application.Spouse_Master_Policy_No__c;
			coi_list.add(coi);
		}
		insert coi_list;
		//Send SMS and Email
		for(COI__c coi : coi_list) {
			//Send SMS to customer
			Messaging.reserveSingleSMS(loan_application.Contact__c.Phone, 'Your COI is ready. Please check your email for more details.');
			//Send Email to customer
			Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
			String[] toAddresses = new String[] {loan_application.Contact__c.Email};
			email.setToAddresses(toAddresses);
			email.setSubject('Your COI is ready');
			email.setPlainTextBody('Your COI is ready. Please check the attached document for more details.');
			Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
		}
		//Reverse data feed to Bandhan Bank through Tableau
		List<String> loan_application_ids = new List<String>();
		for(Loan_Application__c loan_application : loan_application_list) {
			loan_application_ids.add(loan_application.Id);
		}
		BandhanBankInsuranceUpdate.reverseDataFeedToBandhanBankTableau(loan_application_ids);
	}
}