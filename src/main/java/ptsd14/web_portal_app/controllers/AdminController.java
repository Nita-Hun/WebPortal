// package ptsd14.web_portal_app.controllers;

// import java.util.List;

// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.web.bind.annotation.DeleteMapping;
// import org.springframework.web.bind.annotation.GetMapping;
// import org.springframework.web.bind.annotation.PathVariable;
// import org.springframework.web.bind.annotation.PutMapping;
// import org.springframework.web.bind.annotation.RequestBody;
// import org.springframework.web.bind.annotation.RequestMapping;
// import org.springframework.web.bind.annotation.RestController;

// import ptsd14.web_portal_app.models.User;
// import ptsd14.web_portal_app.repositories.UserRepository;

// @RestController
// @RequestMapping("/api/admin")
// public class AdminController {

//     @Autowired
//     private UserRepository userRepository;

//     // Get all users
//     @GetMapping("/users")
//     public List<User> getAllUsers() {
//         return userRepository.findAll();
//     }

//     // Update user details
//     @PutMapping("/users/{id}")
//     public User updateUser(@PathVariable Long id, @RequestBody User updatedUser) {
//         return userRepository.findById(id).map(user -> {
//             user.setUsername(updatedUser.getUsername());
//             user.setEmail(updatedUser.getEmail());
//             user.setRole(updatedUser.getRole());
//             return userRepository.save(user);
//         }).orElseThrow(() -> new RuntimeException("User not found"));
//     }

//     // Delete a user
//     @DeleteMapping("/users/{id}")
//     public void deleteUser(@PathVariable Long id) {
//         //userRepository.deleteById(id);
//     }
// }

