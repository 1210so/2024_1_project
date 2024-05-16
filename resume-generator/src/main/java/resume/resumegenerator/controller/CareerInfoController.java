package resume.resumegenerator.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import resume.resumegenerator.domain.entity.CareerInfo;
import resume.resumegenerator.store.CareerInfoStore;

import java.util.List;

/**
 * 3. 경력 정보 컨트롤러
 * 컨트롤러에서 CareerInfoStore 빈을 주입 받아 데이터 관리
 */
@RestController
@RequestMapping("/career-info")
public class CareerInfoController {
    private final CareerInfoStore careerInfoStore;

    @Autowired
    public CareerInfoController(CareerInfoStore careerInfoStore) {
        this.careerInfoStore = careerInfoStore;
    }

    /**
     * 입력된 경력을 CareerInfoStore에 저장
     */
    @PostMapping("/save/{userId}")
    public ResponseEntity<List<CareerInfo>> saveCareerInfo(@PathVariable Long userId, @RequestBody CareerInfo careerInfo) {
        careerInfo.setUserId(userId);
        List<CareerInfo> savedInfo = careerInfoStore.save(userId, careerInfo);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedInfo);
    }

    /**
     * 수정된 경력을 CareerInfoStore에 업데이트
     * - List<CareerInfo> 형식에 맞춰 JSON 배열로 전송받아야 함
     */
    @PostMapping("/update/{userId}")
    public ResponseEntity<List<CareerInfo>> updateCareerInfo(@PathVariable Long userId, @RequestBody List<CareerInfo> newCareers) {
        if (newCareers == null) {
            return ResponseEntity.notFound().build();
        }

        for (CareerInfo newCareer : newCareers) {
            newCareer.setUserId(userId);
        }
        List<CareerInfo> updateCareers = careerInfoStore.update(userId, newCareers);
        return ResponseEntity.ok(updateCareers);
    }

    /**
     * userId로 저장된 경력 조회
     */
    @GetMapping("/{userId}")
    public ResponseEntity<List<CareerInfo>> getCareerInfo(@PathVariable Long userId) {
        List<CareerInfo> careerInfos = careerInfoStore.findById(userId);
        if (careerInfos == null) {
            return ResponseEntity.notFound().build();
        } else {
            return ResponseEntity.ok(careerInfos);
        }
    }
}
