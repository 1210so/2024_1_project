package resume.resumegenerator.domain.entity;

/**
 * 4. 자격증/면허
 * licenseName(자격증명), date(취득일), agency(시행 기관)
 */
public class LicenseInfo extends BaseEntity {
    private String licenseName;
    private String date;
    private String agency;

    public LicenseInfo() {
    }

    public LicenseInfo(String licenseName, String date, String agency) {
        this.licenseName = licenseName;
        this.date = date;
        this.agency = agency;
    }

    public String getLicenseName() {
        return licenseName;
    }

    public void setLicenseName(String licenseName) {
        this.licenseName = licenseName;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getAgency() {
        return agency;
    }

    public void setAgency(String agency) {
        this.agency = agency;
    }
}
