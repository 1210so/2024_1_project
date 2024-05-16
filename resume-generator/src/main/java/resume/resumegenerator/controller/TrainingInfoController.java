package resume.resumegenerator.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import resume.resumegenerator.domain.entity.TrainingInfo;
import resume.resumegenerator.store.TrainingInfoStore;

import java.util.List;

/**
 * 4. 훈련/교육 정보 컨트롤러
 * 컨트롤러에서 TrainingInfoStore 빈을 주입 받아 데이터 관리
 */
@RestController
@RequestMapping("/training-info")
public class TrainingInfoController {
    private final TrainingInfoStore trainingInfoStore;

    @Autowired
    public TrainingInfoController(TrainingInfoStore trainingInfoStore) {
        this.trainingInfoStore = trainingInfoStore;
    }

    /**
     * 입력된 훈련/교육 정보를 TrainingInfoStore에 저장
     */
    @PostMapping("/save/{userId}")
    public ResponseEntity<List<TrainingInfo>> saveTrainingInfos(@PathVariable Long userId, @RequestBody TrainingInfo trainingInfo) {
        trainingInfo.setUserId(userId);
        List<TrainingInfo> savedInfo = trainingInfoStore.save(userId, trainingInfo);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedInfo);
    }

    /**
     * 수정된 훈련/교육 정보를 TrainingInfoStore에 업데이트
     * - List<TrainigInfo> 형식에 맞춰 JSON 배열로 전송받아야 함
     */
    @PostMapping("/update/{userId}")
    public ResponseEntity<List<TrainingInfo>> updateTrainingInfos(@PathVariable Long userId, @RequestBody List<TrainingInfo> newTrainings) {
        if (newTrainings == null) {
            return ResponseEntity.notFound().build();
        }

        for (TrainingInfo newTraining : newTrainings) {
            newTraining.setUserId(userId);
        }

        List<TrainingInfo> updatedInfos = trainingInfoStore.update(userId, newTrainings);
        return ResponseEntity.ok(updatedInfos);
    }

    /**
     * userId로 저장된 훈련/교육 정보 조회
     */
    @GetMapping("/{userId}")
    public ResponseEntity<List<TrainingInfo>> getTrainingInfos(@PathVariable Long userId) {
        List<TrainingInfo> trainingInfos = trainingInfoStore.findById(userId);
        if (trainingInfos == null) {
            return ResponseEntity.notFound().build();
        } else {
            return ResponseEntity.ok(trainingInfos);
        }
    }
}
