package ptsd14.web_portal_app.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import ptsd14.web_portal_app.models.User;
import ptsd14.web_portal_app.services.UserService;

import java.util.Optional;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private UserService userService;

    // User registration API
    @PostMapping("/register")
    public ResponseEntity<User> registerUser(@RequestBody User user) {
    if (userService.usernameExists(user.getUsername())) {
        return ResponseEntity.badRequest().body(null);
    }
    User savedUser = userService.saveUser(user);
    return ResponseEntity.ok(savedUser);
    }


    // User login API
    @PostMapping("/login")
    public ResponseEntity<?> loginUser(@RequestBody User loginRequest) {
    Optional<User> user = userService.findByUsername(loginRequest.getUsername());
    if (user.isPresent() && user.get().getPassword().equals(loginRequest.getPassword())) {
        return ResponseEntity.ok("Login successful");
    } else {
        return ResponseEntity.status(404).body("Invalid username or password");
    }
    }
}
