package resume.resumegenerator.gpt.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.web.client.RestTemplate;

/**
 * ChatGpt에서 사용하는 환경 구성
 */
@Configuration
public class ChatGptConfig {

    @Value("${openai.secret-key}")
    private String secretKey;

    // RestTemplate을 사용하기 위한 객체 구성
    @Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }

    // HttpHeader에서 JWT 토큰으로 Bearer 토큰 값을 입력해서 전송하기 위한 공통 Header 구성
    @Bean
    public HttpHeaders httpHeaders() {
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(secretKey);
        headers.setContentType(MediaType.APPLICATION_JSON);
        return headers;
    }

}
