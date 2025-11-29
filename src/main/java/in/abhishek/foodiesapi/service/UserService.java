package in.abhishek.foodiesapi.service;

import in.abhishek.foodiesapi.io.UserRequest;
import in.abhishek.foodiesapi.io.UserResponse;

public interface UserService {

    UserResponse registerUser(UserRequest request);

    String findByUserId();
}
