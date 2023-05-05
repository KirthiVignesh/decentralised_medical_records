pragma solidity >=0.4.22;
pragma experimental ABIEncoderV2;

contract ownable {
    
    address public owner;
    mapping(address=>bool) isAdmin;
    event OwnerChanged(address indexed _from,address indexed _to);
    event AdminAdded(address indexed Admin_Address);
    event AdminRemoved(address indexed Admin_Address);
    constructor() public{
        owner=msg.sender;
        isAdmin[msg.sender]=true;
    }
    
    modifier onlyOwner(){
        require(owner == msg.sender,"Only Owner has permission to do that action");
        _;
    }
    modifier onlyAdmin(){
        require(isAdmin[msg.sender] == true,"Only Admin has permission to do that action");
        _;
    }
    
    function setOwner(address _owner) public onlyOwner returns(bool success){
        require(msg.sender!=_owner,"Already Your the owner");
        owner = _owner;
        emit OwnerChanged(msg.sender, _owner);
        return true;
    }
    function addAdmin(address _address) public onlyOwner returns(bool success){
        require(!isAdmin[_address],"User is already a admin!!!");
        isAdmin[_address]=true;
        emit AdminAdded(_address);
        return true;
    }
    function removeAdmin(address _address) public onlyOwner returns(bool success){
        require(_address!=owner,"Can't remove owner from admin");
        require(isAdmin[_address],"User not admin already!!!");
        isAdmin[_address]=false;
        emit AdminRemoved(_address);
        return true;
    }
}



contract Professional is ownable {
    uint256 public index;
    mapping(address=>bool) isProfessional;
    struct professional {
        string m_name;
        string m_address;
        string m_contact;
        address m_addr;
        bool isApproved;
    }
    mapping(address=>professional) professionals;
    address[] public professionalsList;
        function addProfessional(string memory _hname,string memory _haddress,string memory _hcontact,address _addr) public onlyAdmin{
        require(!isProfessional[_addr],"Already Registered");
        professionalsList.push(_addr);
        index = index + 1;
        isProfessional[_addr]=true;
        professionals[_addr]=professional(_hname,_haddress,_hcontact,_addr,true);
    }
    
    function getProfessionalByAddress(address _address) public view returns(string memory m_name,string memory m_address , string memory m_contact ,address m_addr , bool isApproved) {
        require(professionals[_address].isApproved,"This Medical Professional is not Approved or doesn't exist");
        professional memory tmp = professionals[_address];
        return (tmp.m_name,tmp.m_address,tmp.m_contact,tmp.m_addr,tmp.isApproved);
    }    
    
}


contract Pharm is ownable{
    mapping(address=>bool) isPharm;
        mapping(address=>pharm) pharms;

    struct pharm {
        string ph_name;
        string ph_address;
        string ph_contact;
        address ph_addr;
        bool isApproved;
        medicine[] issued;
    }
    struct medicine{
        string id;
        string  name;
        string batch;
        string dosage;
        }
    address[] public pharmList;
    function addPharm(string memory _hname,string memory _haddress,string memory _hcontact,address _addr) public onlyAdmin{
        require(!isPharm[_addr],"Already Registered");
        pharmList.push(_addr);
        isPharm[_addr]=true;
        pharms[_addr].ph_name=_hname;
        pharms[_addr].ph_address=_haddress;
        pharms[_addr].ph_contact=_hcontact;
        pharms[_addr].ph_addr=_addr;
        pharms[_addr].isApproved=true;

    }

    function issueMedicine(string memory id,string memory name,string memory batch,string memory dosage)public{
        require(isPharm[msg.sender],"Not a Pharmaceutical institution");
        medicine memory med=medicine(id,name,batch,dosage);
        pharms[msg.sender].issued.push(med);
    }

}
contract Patient is Professional,Pharm{
    
    uint256 public pindex=0;
    
    struct Records {
    string reg;
    string m_name;
    string reason;
    string ipfs;
    address[] medicines;
    address patient;
    }
    
    struct patient{
        uint256 id;
        string name;
        string phone;
        string gender;
        string dob;
        string bloodgroup;
        string[] complications;
        Records[] records;
        medicine[] presciptions;
        address addr;
    }

    address[] private patientList;
    mapping(address=>mapping(address=>bool)) isAuth;
    mapping(address=>patient) patients;
    mapping(address=>bool) isPatient;
    mapping(address=>address[]) medicines;
    mapping(string=>Records[]) med_data;

    
    function addRecord(address _addr,string memory m_name,string memory _reason,string memory _ipfs,address[] memory med,string memory reg) public{
        require(isPatient[_addr],"User Not registered");
        require(isAuth[_addr][msg.sender],"No permission to add Records");
        Records memory r=Records(reg,m_name,_reason,_ipfs,med,_addr);
        patients[_addr].records.push(r);
        for (uint i=0;i<med.length;i++){
            medicines[med[i]].push(_addr);
        }
        med_data[reg].push(r);
    }
    
    function addPatient(string memory _name,string memory _phone,string memory _gender,string memory _dob,string memory _bloodgroup,string[] memory _allergies) public {
        require(!isPatient[msg.sender],"Already Patient account exists");
        patientList.push(msg.sender);
        pindex = pindex + 1;
        isPatient[msg.sender]=true;
        isAuth[msg.sender][msg.sender]=true;
        patients[msg.sender].id=pindex;
        patients[msg.sender].name=_name;
        patients[msg.sender].phone=_phone;
        patients[msg.sender].gender=_gender;
        patients[msg.sender].dob=_dob;
        patients[msg.sender].bloodgroup=_bloodgroup;
        patients[msg.sender].complications=_allergies;
        patients[msg.sender].addr=msg.sender;
    }
    
    function getPatientDetails(address _addr) public view returns(string memory _name,string memory _phone,string memory _gender,string memory _dob,string memory _bloodgroup,string[] memory _complications){
        require(isAuth[_addr][msg.sender],"No permission to get Records");
        require(isPatient[_addr],"No Patients found at the given address");
        patient memory tmp = patients[_addr];
        return (tmp.name,tmp.phone,tmp.gender,tmp.dob,tmp.bloodgroup,tmp.complications);
    }
    
    function getPatientRecords(address _addr) public view returns(string[] memory m_name,string[] memory _reason,string[] memory ipfs){
        require(isAuth[_addr][msg.sender],"No permission to get Records");
        require(isPatient[_addr],"patient not signed in to our network");
        require(patients[_addr].records.length>0,"patient record doesn't exist");
        string[] memory reg = new string[](patients[_addr].records.length);
        string[] memory m_name = new string[](patients[_addr].records.length);
        string[] memory Reason = new string[](patients[_addr].records.length);
        string[] memory IPFS = new string[](patients[_addr].records.length);
        address[][] memory meds = new address[][](patients[_addr].records.length);

        for(uint256 i=0;i<patients[_addr].records.length;i++){
            reg[i]=patients[_addr].records[i].reg;
            m_name[i]=patients[_addr].records[i].m_name;
            Reason[i]=patients[_addr].records[i].reason;
            IPFS[i]=patients[_addr].records[i].ipfs;
            meds[i]=patients[_addr].records[i].medicines;
        }
        return(m_name,Reason,IPFS);
    }

    function getMedicineFromPatients(address med)public view returns(address[] memory medPatients){
        require(isPharm[msg.sender],"Not a Pharmaceutical institution");
        return medicines[med];
    }

    function getRecordsfromType(string memory reg,address _addr)public view returns(Records[] memory rec){
        require(isPharm[msg.sender],"Not a Pharmaceutical institution");
        require(isAuth[msg.sender][_addr],"Not Authorised");
        return med_data[reg];
    }
    function getAllRecordsfromType(string memory reg)public view returns(Records[][] memory rec){
        require(isPharm[msg.sender],"Not a Pharmaceutical institution");
        Records[][] memory recs;
        uint ctr=0;
        for(uint i=0;i<patientList.length;i++){
            recs[ctr++]=getRecordsfromType(reg, patientList[i]);
        }
        return recs;
    }
    function addAuth(address _addr) public returns(bool success) {
        require(!isAuth[msg.sender][_addr],"Already Authorised");
        require(msg.sender!=_addr,"Cant add yourself");
        isAuth[msg.sender][_addr] = true;
        return true;
    }

    function revokeAuth(address _addr) public returns(bool success) {
        require(msg.sender!=_addr,"Cant remove yourself");
        require(isAuth[msg.sender][_addr],"Already Not Authorised");
        isAuth[msg.sender][_addr] = false;
        return true;
    }
    
    function addAuthFromTo(address _from,address _to) public returns(bool success) {
        require(!isAuth[_from][_to],"Already  Auth!!!");
        require(_from!=_to,"can't add same person");
        require(isAuth[_from][msg.sender],"You don't have permission to access");
        require(isPatient[_from],"User Not Registered yet");
        isAuth[_from][_to] = true;
        return true;
    }
    
    function removeAuthFromTo(address _from,address _to) public returns(bool success) {
        require(isAuth[_from][_to],"Already No Auth!!!");
        require(_from!=_to,"can't remove same person");
        require(isAuth[_from][msg.sender],"You don't have permission to access");
        require(isPatient[_from],"User Not Registered yet");
        isAuth[_from][_to] = false;
        return true;
    }
    

}