package resume.resumegenerator.store;

import org.springframework.stereotype.Component;
import resume.resumegenerator.domain.entity.PersonalInfo;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;

/**
 * 1. 개인정보 저장소
 * Repository를 쓰니까 메모리가 초기화돼서 다시 로드가 안됨
 * 데이터 영속성 확보 위해 저장소를 싱글톤 패턴으로 관리 (수동 빈 등록)
 */
@Component
public class PersonalInfoStore {
    private final ConcurrentHashMap<Long, PersonalInfo> store = new ConcurrentHashMap<>();
    private AtomicLong currentId = new AtomicLong(0);

    public PersonalInfo save(PersonalInfo personalInfo) {
        long userId = personalInfo.getUserId() != null ? personalInfo.getUserId() : currentId.incrementAndGet();
        personalInfo.setUserId(userId);
        store.put(userId, personalInfo);
        return store.get(userId);
    }

    public PersonalInfo findById(Long userId) {
        return store.get(userId);
    }

    public PersonalInfo update(Long userId, PersonalInfo personalInfo) {
        store.put(userId, personalInfo);
        return personalInfo;
    }

    public boolean existsById(Long userId) {
        return store.containsKey(userId);
    }
}
