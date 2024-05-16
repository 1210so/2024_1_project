//package resume.resumegenerator.controller;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.*;
//import resume.resumegenerator.domain.entity.PersonalInfo;
//import resume.resumegenerator.store.PersonalInfoStore;
//
///**
// * 1. 개인정보 컨트롤러
// * 컨트롤러에서 PersonalInfoStore 빈을 주입 받아 데이터 관리
// */
//
//@RestController
//@RequestMapping("/personal-info")
//public class PersonalInfoController1 {
//
//    private final PersonalInfoStore personalInfoStore;
//
//    @Autowired
//    public PersonalInfoController1(PersonalInfoStore personalInfoStore) {
//        this.personalInfoStore = personalInfoStore;
//    }
//
//    /**
//     * 입력된 개인정보를 personalInfoStore에 저장
//     */
//    @PostMapping("/save")
//    public ResponseEntity<PersonalInfo> savePersonalInfo(@RequestParam(required = false) Long userId,
//                                                         @RequestParam String name,
//                                                         @RequestParam String birth,
//                                                         @RequestParam String ssn,
//                                                         @RequestParam String contact,
//                                                         @RequestParam String email,
//                                                         @RequestParam String address) {
//        PersonalInfo personalInfo = new PersonalInfo();
//        if (userId != null) {
//            personalInfo.setUserId(userId);
//        }
//
//        personalInfo.setName(name);
//        personalInfo.setBirth(birth);
//        personalInfo.setSsn(ssn);
//        personalInfo.setContact(contact);
//        personalInfo.setEmail(email);
//        personalInfo.setAddress(address);
//
//        PersonalInfo savedInfo = personalInfoStore.save(personalInfo);
//        if (savedInfo != null) {
//            return ResponseEntity.status(HttpStatus.CREATED).body(savedInfo);
//        } else {
//            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
//        }
//    }
//
//    /**
//     * 수정된 개인정보를 personalInfoStore에 업데이트
//     */
//    @PostMapping("/update")
//    public ResponseEntity<PersonalInfo> updatePersonalInfo(@RequestParam Long userId,
//                                                           @RequestParam String name,
//                                                           @RequestParam String birth,
//                                                           @RequestParam String ssn,
//                                                           @RequestParam String contact,
//                                                           @RequestParam String email,
//                                                           @RequestParam String address) {
//        PersonalInfo info = personalInfoStore.findById(userId);
//        if (info == null) {
//            return ResponseEntity.notFound().build();
//        }
//
//        info.setName(name);
//        info.setBirth(birth);
//        info.setSsn(ssn);
//        info.setContact(contact);
//        info.setEmail(email);
//        info.setAddress(address);
//
//        PersonalInfo updatedInfo = personalInfoStore.update(userId, info);
//        return ResponseEntity.ok(updatedInfo);
//    }
//
//    /**
//     * userId로 저장된 개인정보 조회
//     */
//    @GetMapping("/{userId}")
//    public ResponseEntity<PersonalInfo> getPersonalInfo(@PathVariable Long userId) {
//        PersonalInfo personalInfo = personalInfoStore.findById(userId);
//        if (personalInfo == null) {
//            return ResponseEntity.notFound().build();
//        } else {
//            return ResponseEntity.ok(personalInfo);
//        }
//    }
//}

package resume.resumegenerator.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import resume.resumegenerator.domain.entity.PersonalInfo;
import resume.resumegenerator.store.PersonalInfoStore;

/**
 * 1. 개인 정보 컨트롤러
 * 컨트롤러에서 PersonalInfoStore 빈을 주입 받아 데이터 관리
 */
@RestController
@RequestMapping("/personal-info")
public class PersonalInfoController {

    private final PersonalInfoStore personalInfoStore;

    @Autowired
    public PersonalInfoController(PersonalInfoStore personalInfoStore) {
        this.personalInfoStore = personalInfoStore;
    }

    /**
     * 입력된 개인정보를 personalInfoStore에 저장
     */
    @PostMapping("/save")
    public ResponseEntity<PersonalInfo> savePersonalInfo(@RequestBody PersonalInfo personalInfo) {
        PersonalInfo savedInfo = personalInfoStore.save(personalInfo);
        if (savedInfo != null) {
            return ResponseEntity.status(HttpStatus.CREATED).body(savedInfo);
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    /**
     * 수정된 개인정보를 personalInfoStore에 업데이트
     */
    @PostMapping("/update/{userId}")
    public ResponseEntity<PersonalInfo> updatePersonalInfo(@PathVariable Long userId, @RequestBody PersonalInfo personalInfo) {
        if (!personalInfoStore.existsById(userId)) {
            return ResponseEntity.notFound().build();
        }

        personalInfo.setUserId(userId);
        PersonalInfo updatedInfo = personalInfoStore.update(userId, personalInfo);
        return ResponseEntity.ok(updatedInfo);
    }

    /**
     * userId로 저장된 개인정보 조회
     */
    @GetMapping("/{userId}")
    public ResponseEntity<PersonalInfo> getPersonalInfo(@PathVariable Long userId) {
        PersonalInfo personalInfo = personalInfoStore.findById(userId);
        if (personalInfo == null) {
            return ResponseEntity.notFound().build();
        } else {
            return ResponseEntity.ok(personalInfo);
        }
    }
}
