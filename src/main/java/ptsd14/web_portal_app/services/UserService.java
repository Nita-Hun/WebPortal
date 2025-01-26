package ptsd14.web_portal_app.services;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ptsd14.web_portal_app.models.User;
import ptsd14.web_portal_app.repositories.UserRepository;

import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    // Save a new user (e.g., during registration)
    public User saveUser(User user) {
        return userRepository.save(user);
    }

    // Find a user by username (e.g., for authentication)
    public Optional<User> findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    // Check if a username already exists
    public boolean usernameExists(String username) {
        return userRepository.existsByUsername(username);
    }

    // Get all users (admin use case)
    public Iterable<User> getAllUsers() {
        return userRepository.findAll();
    }
}
