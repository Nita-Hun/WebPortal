package ptsd14.web_portal_app.repositories;

import java.util.Optional;

import ptsd14.web_portal_app.models.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    @Autowired
    Optional<User> findByUsername(String username);
    boolean existsByUsername(String username);
    //Optional<User> findById(Long id);
    //Object findByEmail(String email);
    //User findByEmail(String email);
    
}
