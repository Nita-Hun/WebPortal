package ptsd14.web_portal_app.services;

import java.util.List;

import org.springframework.stereotype.Service;

import ptsd14.web_portal_app.models.Test;
import ptsd14.web_portal_app.repositories.TestRepository;

@Service
public class TestService {
    
    private TestRepository testRepository;

    public Test saveTest(Test test) {
        return testRepository.save(test);
        
    }
    public List<Test> getAllTests() {
        return testRepository.findAll();
    }
    public Test getTestById(int id) {
        return testRepository.findById(id)
        .orElseThrow(() -> new RuntimeException("Test not found"));
        
    }

    public void deleteTest(int id) {
        testRepository.deleteById(id);
    }
    
}
