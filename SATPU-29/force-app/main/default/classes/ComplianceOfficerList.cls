public with sharing class ComplianceOfficerList { 
	
	//Variables to store user information 
	public String firstName;
	public String lastName;
	public String middleName;
	public String email;
	public String mobileNumber;
	public String phoneNumber;
	public String PAN;
	public String Aadhar;
	public String otherID;
	public String action;
	
	//List of records to store the user information
	public List<ComplianceOfficerList> records;
	
	//Constructor
	public ComplianceOfficerList(){
		records = new List<ComplianceOfficerList>();
	}
	
	//Method to add new compliance officer
	public void addComplianceOfficer(String firstName, String lastName, String middleName, String email, String mobileNumber, String phoneNumber, String PAN, String Aadhar, String otherID, String action){
		records.add(new ComplianceOfficerList(firstName, lastName, middleName, email, mobileNumber, phoneNumber, PAN, Aadhar, otherID, action));
	}
	
	//Method to search the compliance officer by username and email
	public List<ComplianceOfficerList> searchComplianceOfficer(String username, String email){
		List<ComplianceOfficerList> result = new List<ComplianceOfficerList>();
		for(ComplianceOfficerList record : records){
			if(record.username == username || record.email == email){
				result.add(record);
			}
		}
		return result;
	}
	
	//Method to edit existing compliance officer
	public void editComplianceOfficer(String username, String firstName, String lastName, String middleName, String email, String mobileNumber, String phoneNumber, String PAN, String Aadhar, String otherID, String action){
		for(ComplianceOfficerList record : records){
			if(record.username == username){
				record.firstName = firstName;
				record.lastName = lastName;
				record.middleName = middleName;
				record.email = email;
				record.mobileNumber = mobileNumber;
				record.phoneNumber = phoneNumber;
				record.PAN = PAN;
				record.Aadhar = Aadhar;
				record.otherID = otherID;
				record.action = action;
			}
		}
	}
	
	//Method to archive the user
	public void archiveUser(String username){
		for(ComplianceOfficerList record : records){
			if(record.username == username){
				record.isArchived = true;
			}
		}
	}
	
	//Method to change role of user
	public void changeUserRole(String username, String role){
		for(ComplianceOfficerList record : records){
			if(record.username == username){
				record.role = role;
			}
		}
	}
	
	//Method to import data from file
	public void importDataFromFile(String filePath){
		//Read data from file
		//Parse data and store in records
	}
	
	//Method to get list of compliance officers
	public List<ComplianceOfficerList> getComplianceOfficers(Integer limit){
		Integer count = 0;
		List<ComplianceOfficerList> result = new List<ComplianceOfficerList>();
		for(ComplianceOfficerList record : records){
			if(count < limit){
				result.add(record);
			}
			count++;
		}
		return result;
	}
	
	//Method to paginate record
	public List<ComplianceOfficerList> paginate(Integer pageNumber, Integer pageSize){
		Integer startIndex = (pageNumber - 1) * pageSize;
		Integer endIndex = startIndex + pageSize;
		
		List<ComplianceOfficerList> result = new List<ComplianceOfficerList>();
		for(Integer i = startIndex; i < endIndex; i++){
			if