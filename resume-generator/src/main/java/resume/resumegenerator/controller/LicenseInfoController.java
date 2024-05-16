package resume.resumegenerator.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import resume.resumegenerator.domain.entity.LicenseInfo;
import resume.resumegenerator.store.LicenseInfoStore;

import java.util.List;

/**
 * 4. 자격증/면허 정보 컨트롤러
 * 컨트롤러에서 LicenseInfoStore 빈을 주입 받아 데이터 관리
 */
@RestController
@RequestMapping("/license-info")
public class LicenseInfoController {
    private final LicenseInfoStore licenseInfoStore;

    @Autowired
    public LicenseInfoController(LicenseInfoStore licenseInfoStore) {
        this.licenseInfoStore = licenseInfoStore;
    }

    /**
     * 입력된 자격증/면허 정보를 LicenseInfoStore에 저장
     */
    @PostMapping("/save/{userId}")
    public ResponseEntity<List<LicenseInfo>> saveLicenseInfo(@PathVariable Long userId, @RequestBody LicenseInfo licenseInfo) {
        licenseInfo.setUserId(userId);
        List<LicenseInfo> savedInfo = licenseInfoStore.save(userId, licenseInfo);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedInfo);
    }

    /**
     * 수정된 자격증/면허 정보를 LicenseInfoStore에 업데이트
     * - List<LicenseInfo> 형식에 맞춰 JSON 배열로 전송받아야 함
     */
    @PostMapping("/update/{userId}")
    public ResponseEntity<List<LicenseInfo>> updateLicenseInfo(@PathVariable Long userId, @RequestBody List<LicenseInfo> newLicenses) {
        if (newLicenses == null) {
            return ResponseEntity.notFound().build();
        }

        for (LicenseInfo newLicense : newLicenses) {
            newLicense.setUserId(userId);
        }

        List<LicenseInfo> updatedLicenses = licenseInfoStore.update(userId, newLicenses);
        return ResponseEntity.ok(updatedLicenses);
    }

    /**
     * userId로 저장된 자격증/면허 정보 조회
     */
    @GetMapping("/{userId}")
    public ResponseEntity<List<LicenseInfo>> getLicenseInfos(@PathVariable Long userId) {
        List<LicenseInfo> licenseInfos = licenseInfoStore.findById(userId);
        if (licenseInfos == null) {
            return ResponseEntity.notFound().build();
        } else {
            return ResponseEntity.ok(licenseInfos);
        }
    }
}
