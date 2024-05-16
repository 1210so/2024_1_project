package resume.resumegenerator.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import resume.resumegenerator.domain.entity.AcademicInfo;
import resume.resumegenerator.store.AcademicInfoStore;

/**
 * 2. 학력 정보 컨트롤러
 * 컨트롤러에서 AcademicInfoStore 빈을 주입 받아 데이터 관리
 */
@RestController
@RequestMapping("/academic-info")
public class AcademicInfoController {
    private final AcademicInfoStore academicInfoStore;

    @Autowired
    public AcademicInfoController(AcademicInfoStore academicInfoStore) {
        this.academicInfoStore = academicInfoStore;
    }

    /**
     * 입력된 학력을 AcademicInfoStore에 저장
     */
    @PostMapping("/save/{userId}")
    public ResponseEntity<AcademicInfo> saveAcademicInfo(@PathVariable Long userId, @RequestBody AcademicInfo academicInfo) {
        academicInfo.setUserId(userId);
        AcademicInfo savedInfo = academicInfoStore.save(userId, academicInfo);
        if (savedInfo != null) {
            return ResponseEntity.status(HttpStatus.CREATED).body(savedInfo);
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    /**
     * 수정된 학력을 AcademicInfoStore에 업데이트
     */
    @PostMapping("/update/{userId}")
    public ResponseEntity<AcademicInfo> updateAcademicInfo(@PathVariable Long userId, @RequestBody AcademicInfo academicInfo) {
        if (!academicInfoStore.existsById(userId)) {
            return ResponseEntity.notFound().build();
        }

        academicInfo.setUserId(userId);
        AcademicInfo updatedInfo = academicInfoStore.update(userId, academicInfo);
        return ResponseEntity.ok(updatedInfo);
    }

    /**
     * userId로 저장된 학력 조회
     */
    @GetMapping("/{userId}")
    public ResponseEntity<AcademicInfo> getAcademicInfo(@PathVariable Long userId) {
        AcademicInfo academicInfo = academicInfoStore.findById(userId);
        if (academicInfo == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(academicInfo);
    }
}

