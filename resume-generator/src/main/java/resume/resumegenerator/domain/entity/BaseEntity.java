package resume.resumegenerator.domain.entity;

public abstract class BaseEntity {
    protected Long userId;
    public Long getUserId() {
        return userId;
    }
    public void setUserId(Long userId) {
        this.userId = userId;
    }
}
