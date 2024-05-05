package resume.resumegenerator.domain.entity;

/**
 * 1. 개인정보 entity
 * id, name, birth, ssn, contact, email, address
 * emergencyContact - 필수 X
 */

public class PersonalInfo {
    private Long id;
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

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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
