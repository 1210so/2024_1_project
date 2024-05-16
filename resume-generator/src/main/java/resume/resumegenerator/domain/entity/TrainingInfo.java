package resume.resumegenerator.domain.entity;

/**
 * 5. 훈련/교육
 * trainingName(훈련명/교육명), date(훈련 기간), agency(훈련 기관)
 */
public class TrainingInfo extends BaseEntity {
    private String trainingName;
    private String date;
    private String agency;

    public TrainingInfo() {
    }

    public TrainingInfo(String trainingName, String date, String agency) {
        this.trainingName = trainingName;
        this.date = date;
        this.agency = agency;
    }

    public String getTrainingName() {
        return trainingName;
    }

    public void setTrainingName(String trainingName) {
        this.trainingName = trainingName;
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
