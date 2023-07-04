trigger MemberAndSpouseMasterPolicy on Account (before insert, before update) {
    List<Account> accountList = Trigger.new;
    Map<Id, Account> accountMap = new Map<Id, Account>(accountList);
    List<Master_Policy_Number__c> masterPolicyNumberList = new List<Master_Policy_Number__c>();
 
    for (Account acc:accountList) {
        if (acc.Eligible_Insurance_Coverage__c && acc.CRIF_Score__c != null && acc.Annual_Income__c != null) {
            // Generate loan tenure and Member/Spouse wise master policy no.
            if(acc.Member_Master_Policy_Number__c == null) {
                Master_Policy_Number__c masterPolicyNumber = new Master_Policy_Number__c();
                masterPolicyNumber.Loan_Tenure_in_Years__c = acc.Loan_Tenure_in_Years__c;
                masterPolicyNumber.Name = acc.Name;
                masterPolicyNumber.Account__c = acc.Id;
                masterPolicyNumberList.add(masterPolicyNumber);
            }
            if(acc.Spouse_Master_Policy_Number__c == null) {
                Master_Policy_Number__c masterPolicyNumber = new Master_Policy_Number__c();
                masterPolicyNumber.Loan_Tenure_in_Years__c = acc.Loan_Tenure_in_Years__c;
                masterPolicyNumber.Name = acc.Spouse_Name__c;
                masterPolicyNumber.Account__c = acc.Id;
                masterPolicyNumberList.add(masterPolicyNumber);
            }
            // Generate COI
            if(acc.COI_Number__c == null) {
                COI_Number__c COI = new COI_Number__c();
                COI.Name = acc.Name;
                COI.Account__c = acc.Id;
                COI.Loan_Tenure_in_Years__c = acc.Loan_Tenure_in_Years__c;
                COI.CRIF_Score__c = acc.CRIF_Score__c;
                COI.Annual_Income__c = acc.Annual_Income__c;
                COI.send_COI_via_SMS__c = true;
                COI.send_COI_via_Email__c = true;
                insert COI;
            }
        }
    }
    if(masterPolicyNumberList.size()>0) {
        insert masterPolicyNumberList;
        //Tableau reverse data feed to Bandhan Bank
        for (Master_Policy_Number__c masterPolicyNumber:masterPolicyNumberList) {
            Account account = accountMap.get(masterPolicyNumber.Account__c);
            if(account.Member_Master_Policy_Number__c == null) {
                account.Member_Master_Policy_Number__c = masterPolicyNumber.Id;
            }
            if(account.Spouse_Master_Policy_Number__c == null) {
                account.Spouse_Master_Policy_Number__c = masterPolicyNumber.Id;
            }
        }
        update accountMap.values();
    }
}