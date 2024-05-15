package resume.resumegenerator.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import resume.resumegenerator.domain.entity.AcademicInfo;
import resume.resumegenerator.domain.entity.CareerInfo;
import resume.resumegenerator.domain.entity.PersonalInfo;
import resume.resumegenerator.store.AcademicInfoStore;
import resume.resumegenerator.store.CareerInfoStore;
import resume.resumegenerator.store.PersonalInfoStore;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 전체 이력서 정보를 통합하여 조회
 */
@RestController
@RequestMapping("/resume")
public class ResumeController {

    private final PersonalInfoStore personalInfoStore;
    private final AcademicInfoStore academicInfoStore;
    private final CareerInfoStore careerInfoStore;

    @Autowired
    public ResumeController(PersonalInfoStore personalInfoStore, AcademicInfoStore academicInfoStore, CareerInfoStore careerInfoStore) {
        this.personalInfoStore = personalInfoStore;
        this.academicInfoStore = academicInfoStore;
        this.careerInfoStore = careerInfoStore;
    }

    @GetMapping("/{userId}")
    public ResponseEntity<Map<String, Object>> getCompleteResume(@PathVariable Long userId) {
        Map<String, Object> resume = new HashMap<>();
        PersonalInfo personalInfo = personalInfoStore.findById(userId);
        AcademicInfo academicInfo = academicInfoStore.findById(userId);
        List<CareerInfo> careerInfos = careerInfoStore.findById(userId);

        if (personalInfo != null) {
            resume.put("PersonalInfo", personalInfo);
        }
        if (academicInfo != null) {
            resume.put("AcademicInfo", academicInfo);
        }
        if (careerInfos != null) {
            resume.put("CareerInfos", careerInfos);
        }
        if (resume.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.ok(resume);
    }
}
