package resume.resumegenerator.domain.entity;

/**
 * 1. 개인정보 entity
 * userId, name(이름), birth(생년월일), ssn(주민등록번호), contact(전화번호), emergencyContact(비상연락처), email(이메일주소), address(집주소)
 * emergencyContact - 필수 X
 */
public class PersonalInfo extends BaseEntity {
    private String name;
    private String birth;
    private String ssn;
    private String contact;
    private String emergencyContact;
    private String email;
    private String address;

    public PersonalInfo() {
    }

    public PersonalInfo(String name, String birth, String ssn, String contact, String email, String address) {
        this.name = name;
        this.birth = birth;
        this.ssn = ssn;
        this.contact = contact;
        this.email = email;
        this.address = address;
    }


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBirth() {
        return birth;
    }

    public void setBirth(String birth) {
        this.birth = birth;
    }

    public String getSsn() {
        return ssn;
    }

    public void setSsn(String ssn) {
        this.ssn = ssn;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getEmergencyContact() {
        return emergencyContact;
    }

    public void setEmergencyContact(String emergencyContact) {
        this.emergencyContact = emergencyContact;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
