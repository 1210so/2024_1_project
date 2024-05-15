package resume.resumegenerator.domain.entity;

/**
 * 3. 경력
 * place(근무처), period(근무 기간), task(업무 내용)
 */
public class CareerInfo extends BaseEntity {

    private String place;
    private String period;
    private String task;

    public CareerInfo() {
    }

    public CareerInfo(String place, String period, String task) {
        this.place = place;
        this.period = period;
        this.task = task;
    }

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }

    public String getPeriod() {
        return period;
    }

    public void setPeriod(String period) {
        this.period = period;
    }

    public String getTask() {
        return task;
    }

    public void setTask(String task) {
        this.task = task;
    }
}
