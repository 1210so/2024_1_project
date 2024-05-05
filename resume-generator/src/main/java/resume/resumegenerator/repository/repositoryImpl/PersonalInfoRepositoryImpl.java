package resume.resumegenerator.repository.repositoryImpl;

import org.springframework.stereotype.Repository;
import resume.resumegenerator.domain.entity.PersonalInfo;
import resume.resumegenerator.repository.PersonalInfoRepository;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;

/**
 * PersonalInfoRepsitory 구현체
 * save, findById, update
 * 별도의 db 없이 메모리에 데이터 저장
 */

@Repository
public class PersonalInfoRepositoryImpl implements PersonalInfoRepository {

    private ConcurrentHashMap<Long, PersonalInfo> storage = new ConcurrentHashMap<>(); // 동시성 고려
    private AtomicLong currentId = new AtomicLong(0);

    public PersonalInfo save(PersonalInfo info) {
        long id = currentId.incrementAndGet();
        info.setId(id);
        storage.put(id, info);
        return info;
    }

    public PersonalInfo findById(Long id) {
        return storage.get(id);
    }

    public PersonalInfo update(Long id, PersonalInfo info) {
        if (storage.containsKey(id)) {
            storage.put(id, info);
            return info;
        }
        return null;
    }
}
