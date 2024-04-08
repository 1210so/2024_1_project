package resume.resumegenerator.gpt.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import resume.resumegenerator.gpt.dto.CompletionDto;
import resume.resumegenerator.gpt.service.ChatGptService;

import java.util.Map;

@Slf4j
@RestController
@RequestMapping(value = "/api/v1/chatGpt")
public class ChatGptController {

    private final ChatGptService chatGptService;

    public ChatGptController(ChatGptService chatGptService) {
        this.chatGptService = chatGptService;
    }

    /**
     * ChatGpt 프롬프트 명령을 수행
     */
    @PostMapping("/prompt")
    public ResponseEntity<Map<String, Object>> selectLegacyPrompt(@RequestBody CompletionDto completionDto) {
        log.debug("param :: " + completionDto.toString());
        Map<String, Object> result = chatGptService.prompt(completionDto);
        return new ResponseEntity<>(result, HttpStatus.OK);
    }
}
