package ptsd14.web_portal_app.repositories;



import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import ptsd14.web_portal_app.models.Test;

@Repository
public interface TestRepository extends JpaRepository<Test, Integer> {
    //List<Test> getAllTests();
    //Test saveTest(Test test);
}
