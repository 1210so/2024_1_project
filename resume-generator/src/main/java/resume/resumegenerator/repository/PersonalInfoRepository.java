package resume.resumegenerator.repository;

import resume.resumegenerator.domain.entity.PersonalInfo;

public interface PersonalInfoRepository {
    PersonalInfo save(PersonalInfo personalInfo);
    PersonalInfo findById(Long id);
    PersonalInfo update(Long infoId, PersonalInfo info);
}
