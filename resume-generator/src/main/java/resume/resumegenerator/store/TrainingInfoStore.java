package resume.resumegenerator.store;

import org.springframework.stereotype.Component;
import resume.resumegenerator.domain.entity.TrainingInfo;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 5. 훈련/교육 정보 저장소
 */
@Component
public class TrainingInfoStore {
    private final ConcurrentHashMap<Long, List<TrainingInfo>> store = new ConcurrentHashMap<>();

    public List<TrainingInfo> save(Long userId, TrainingInfo trainingInfo) {
        List<TrainingInfo> trainingInfos = store.get(userId);
        if (trainingInfos == null) {
            trainingInfos = new ArrayList<>();
            store.put(userId, trainingInfos);
        }

        trainingInfos.add(trainingInfo);
        return trainingInfos;
    }

    public List<TrainingInfo> findById(Long userId) {
        List<TrainingInfo> trainingInfos = store.get(userId);
        if (trainingInfos == null) {
            return new ArrayList<>();
        }
        return trainingInfos;
    }

    public List<TrainingInfo> update(Long userId, List<TrainingInfo> newTrainingInfos) {
        store.put(userId, newTrainingInfos);
        return newTrainingInfos;
    }
}
