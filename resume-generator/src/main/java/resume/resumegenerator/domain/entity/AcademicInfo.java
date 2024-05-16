package resume.resumegenerator.domain.entity;

/**
 * 2. 학력
 * id, highestEdu(최종 학력), schoolName(학교명), major(전공 계열), detailedMajor(세부 전공)
 */
public class AcademicInfo extends BaseEntity{
    private String highestEdu;
    private String schoolName;
    private String major;
    private String detailedMajor;

    public AcademicInfo() {
    }

    public AcademicInfo(String highestEdu, String schoolName) {
        this.highestEdu = highestEdu;
        this.schoolName = schoolName;
    }

    public String getHighestEdu() {
        return highestEdu;
    }

    public void setHighestEdu(String highestEdu) {
        this.highestEdu = highestEdu;
    }

    public String getSchoolName() {
        return schoolName;
    }

    public void setSchoolName(String schoolName) {
        this.schoolName = schoolName;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    public String getDetailedMajor() {
        return detailedMajor;
    }

    public void setDetailedMajor(String detailedMajor) {
        this.detailedMajor = detailedMajor;
    }
}
