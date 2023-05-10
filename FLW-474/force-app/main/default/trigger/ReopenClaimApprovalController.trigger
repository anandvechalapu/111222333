Trigger:

trigger ReopenClaimApproval on Case (before insert, before update) {
 
  //Create a list to store the Approvers 
  List<Id> approverId = new List<Id>();
  //Create a list to store the Maker 
  List<Id> makerId = new List<Id>();
 
  //Start looping through the Cases
  for(Case c : Trigger.new){
    //Check if the Case is in the proper status to initiate the approval process
    if(c.Status == 'Submitted for Reopen'){
      //Populate the approver list
      approverId.add(c.OwnerId);
      //Populate the maker list
      makerId.add(c.CreatedById);
    }
 
  }
 
  //Create a list of the Approvers
  List<User> approvers = [SELECT Id, Name FROM User  WHERE Id IN :approverId];
  //Create a list of the Maker 
  List<User> makers = [SELECT Id, Name FROM User  WHERE Id IN :makerId];
 
  //Start looping through the Cases
  for(Case c : Trigger.new){
    //Check if the Case is in the proper status to initiate the approval process
    if(c.Status == 'Submitted for Reopen'){
      //Start looping through the Approvers
      for(User u : approvers){
        //Check if the user is an Approver
        if(u.Id == c.OwnerId){
          //Set the Approver to Readonly
          c.OwnerId.editable = false;
          //Start looping through the Maker 
          for(User u : makers){
            //Check if the user is a Maker 
            if(u.Id == c.CreatedById){
              //Set the Maker to Readonly
              c.CreatedById.editable = false;
            }
          }
        }
      }
    }
  }
}