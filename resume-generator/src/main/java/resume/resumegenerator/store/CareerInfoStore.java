package resume.resumegenerator.store;

import org.springframework.stereotype.Component;
import resume.resumegenerator.domain.entity.CareerInfo;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 3. 경력 저장소
 */

@Component
public class CareerInfoStore {
    private final ConcurrentHashMap<Long, List<CareerInfo>> store = new ConcurrentHashMap<>();

    public List<CareerInfo> save(Long userId, CareerInfo careerInfo) {
        List<CareerInfo> careerInfos = store.get(userId);
        if (careerInfos == null) {
            careerInfos = new ArrayList<>();
            store.put(userId, careerInfos);
        }

        careerInfos.add(careerInfo);
        return careerInfos;
    }


    public List<CareerInfo> findById(Long userId) {
        List<CareerInfo> careerInfos = store.get(userId);
        if (careerInfos == null) {
            return new ArrayList<>();
        }
        return careerInfos;
    }

    public List<CareerInfo> update(Long userId, List<CareerInfo> newCareers) {
        store.put(userId, newCareers);
        return newCareers;
    }
}
