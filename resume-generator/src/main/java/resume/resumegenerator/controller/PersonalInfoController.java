package resume.resumegenerator.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import resume.resumegenerator.domain.entity.PersonalInfo;
import resume.resumegenerator.repository.PersonalInfoRepository;
import resume.resumegenerator.repository.repositoryImpl.PersonalInfoRepositoryImpl;

/**
 * HTTP API 사용 버전
 * application/x-www-form-urlencoded 방식으로 서버에 데이터를 전송하면 JSON 방식으로 데이터 반환
 */

@RestController
@RequestMapping("/personal-info")
@RequiredArgsConstructor
public class PersonalInfoController {
    private final PersonalInfoRepository repository = new PersonalInfoRepositoryImpl();

    /**
     * 클라이언트가 처음 정보를 입력 시작시 호출
     * 새 PersonalInfo 객체 생성 후 저장
     */
    @PostMapping("/start")
    public ResponseEntity<PersonalInfo> start() {
        PersonalInfo info = new PersonalInfo();
        info = repository.save(info);
        return ResponseEntity.ok(info);
    }

    /**
     * 클라이언트의 이름 필드를 입력
     * @param infoId
     * @param name
     * @return
     */

    @PostMapping("/name")
    public ResponseEntity<PersonalInfo> submitName(@RequestParam Long infoId, @RequestParam String name) {
        PersonalInfo info = repository.findById(infoId);
        if (info != null) {
            info.setName(name);
            repository.update(infoId, info);
            return ResponseEntity.ok(info);
        }
        return ResponseEntity.notFound().build();
    }

    /**
     * 클라이언트의 생년월일을 입력
     * @param infoId
     * @param birth
     * @return
     */

    @PostMapping("/birth")
    public ResponseEntity<PersonalInfo> submitBirth(@RequestParam Long infoId, @RequestParam String birth) {
        PersonalInfo info = repository.findById(infoId);
        if (info != null) {
            info.setBirth(birth);
            repository.update(infoId, info);
            return ResponseEntity.ok(info);
        }
        return ResponseEntity.notFound().build();
    }

    /**
     * 클라이언트의 주민등록번호 입력
     * @param infoId
     * @param ssn
     * @return
     */

    @PostMapping("/ssn")
    public ResponseEntity<PersonalInfo> submitSsn(@RequestParam Long infoId, @RequestParam String ssn) {
        PersonalInfo info = repository.findById(infoId);
        if (info != null) {
            info.setSsn(ssn);
            repository.update(infoId, info);
            return ResponseEntity.ok(info);
        }
        return ResponseEntity.notFound().build();
    }

    /**
     * 클라이언트의 전화번호 입력
     * @param infoId
     * @param contact
     * @return
     */

    @PostMapping("/contact")
    public ResponseEntity<PersonalInfo> submitContact(@RequestParam Long infoId, @RequestParam String contact){
        PersonalInfo info = repository.findById(infoId);
        if (info != null) {
            info.setContact(contact);
            repository.update(infoId, info);
            return ResponseEntity.ok(info);
        }
        return ResponseEntity.notFound().build();
    }

    /**
     * 클라이언트의 이메일 주소 입력
     * @param infoId
     * @param email
     * @return
     */

    @PostMapping("/email")
    public ResponseEntity<PersonalInfo> submitEmail(@RequestParam Long infoId, @RequestParam String email) {
        PersonalInfo info = repository.findById(infoId);
        if (info != null) {
            info.setEmail(email);
            repository.update(infoId, info);
            return ResponseEntity.ok(info);
        }
        return ResponseEntity.notFound().build();
    }

    /**
     * 클라이언트의 주소 입력
     * @param infoId
     * @param address
     * @return
     */

    @PostMapping("/address")
    public ResponseEntity<PersonalInfo> submitAddress(@RequestParam Long infoId, @RequestParam String address) {
        PersonalInfo info = repository.findById(infoId);
        if (info != null) {
            info.setAddress(address);
            repository.update(infoId, info);
            return ResponseEntity.ok(info);
        }
        return ResponseEntity.notFound().build();
    }

    /**
     * infoId에 해당하는 PersonalInfo 객체 정보를 조회하여 반환
     * @param infoId
     * @return
     */
    @GetMapping("/review/{infoId}")
    public ResponseEntity<PersonalInfo> reviewPersonalInfo(@PathVariable Long infoId) {
        PersonalInfo info = repository.findById(infoId);
        if (info != null) {
            return ResponseEntity.ok(info);
        }
        return ResponseEntity.notFound().build();
    }
}
