package resume.resumegenerator.gpt.service;


import org.springframework.stereotype.Service;
import resume.resumegenerator.gpt.dto.CompletionDto;

import java.util.Map;

/**
 * ChatGpt 서비스 인터페이스
 */
@Service
public interface ChatGptService {

    Map<String, Object> prompt(CompletionDto completionDto);

}
