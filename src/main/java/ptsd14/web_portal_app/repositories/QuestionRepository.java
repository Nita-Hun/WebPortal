package ptsd14.web_portal_app.repositories;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import ptsd14.web_portal_app.models.Question;

public interface QuestionRepository extends JpaRepository<Question, Integer>{
    List<Question> findByTestId(int testId);

}
