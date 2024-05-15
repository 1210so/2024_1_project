package resume.resumegenerator.store;

import org.springframework.stereotype.Component;
import resume.resumegenerator.domain.entity.AcademicInfo;

import java.util.concurrent.ConcurrentHashMap;

/**
 * 2. 학력 저장소
 */
@Component
public class AcademicInfoStore {

    private final ConcurrentHashMap<Long, AcademicInfo> store = new ConcurrentHashMap<>();

    public AcademicInfo save(Long userId, AcademicInfo academicInfo) {
        store.put(userId, academicInfo);
        return store.get(userId);
    }

    public AcademicInfo findById(Long userId) {
        return store.get(userId);
    }

    public AcademicInfo update(Long userId, AcademicInfo academicInfo) {
        store.put(userId, academicInfo);
        return academicInfo;
    }

    public boolean existsById(Long userId) {
        return store.containsKey(userId);
    }
}
