package ptsd14.web_portal_app.controllers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import ptsd14.web_portal_app.models.Test;
import ptsd14.web_portal_app.services.TestService;

import java.util.List;

@RestController
@RequestMapping("/api/tests")
public class TestController {

    @Autowired
    private TestService testService;

    // Get all tests
    @GetMapping
    public ResponseEntity<List<Test>> getAllTests() {
        List<Test> tests = testService.getAllTests();
        return ResponseEntity.ok(tests);
    }

    // Get a test by ID
    @GetMapping("/{id}")
    public ResponseEntity<Test> getTestById(@PathVariable int id) {
        Test test = testService.getTestById(id);
        return ResponseEntity.ok(test);
    }

    // Create a new test
    @PostMapping
    public ResponseEntity<Test> createTest(@RequestBody Test test) {
        Test savedTest = testService.saveTest(test);
        return ResponseEntity.ok(savedTest);
    }

    // Delete a test by ID
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteTest(@PathVariable int id) {
        testService.deleteTest(id);
        return ResponseEntity.ok("Test deleted successfully!");
    }
}
