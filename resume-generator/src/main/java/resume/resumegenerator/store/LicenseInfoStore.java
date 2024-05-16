package resume.resumegenerator.store;

import org.springframework.stereotype.Component;
import resume.resumegenerator.domain.entity.LicenseInfo;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 4. 자격증/면허 정보 저장소
 */
@Component
public class LicenseInfoStore {
    private final ConcurrentHashMap<Long, List<LicenseInfo>> store = new ConcurrentHashMap<>();

    public List<LicenseInfo> save(Long userId, LicenseInfo licenseInfo) {
        List<LicenseInfo> licenseInfos = store.get(userId);
        if (licenseInfos == null) {
            licenseInfos = new ArrayList<>();
            store.put(userId, licenseInfos);
        }

        licenseInfos.add(licenseInfo);
        return licenseInfos;
    }

    public List<LicenseInfo> findById(Long userId) {
        List<LicenseInfo> licenseInfos = store.get(userId);
        if (licenseInfos == null) {
            return new ArrayList<>();
        }
        return licenseInfos;
    }

    public List<LicenseInfo> update(Long userId, List<LicenseInfo> newLicenseInfos) {
        store.put(userId, newLicenseInfos);
        return newLicenseInfos;
    }
}
