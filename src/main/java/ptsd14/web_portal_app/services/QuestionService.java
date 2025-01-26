package ptsd14.web_portal_app.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ptsd14.web_portal_app.models.Question;
import ptsd14.web_portal_app.repositories.QuestionRepository;

@Service
public class QuestionService {

    @Autowired
    private QuestionRepository questionRepository;

    public Question saveQuestion(Question question) {
        return questionRepository.save(question);
    }

    public List<Question> getQuestionByTestId(int testId) {
        return questionRepository.findByTestId(testId);
    }

    public Question getQuestionById(int id) {
        return questionRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Question not found"));
    }

    public void deleteQuestion(int id) {
        questionRepository.deleteById(id);
    }

   
}
