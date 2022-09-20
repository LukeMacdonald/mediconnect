package com.example.ndtelemedecine.Service;

import com.example.ndtelemedecine.Models.User;
import com.example.ndtelemedecine.Repositories.UserRepo;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Collections;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class UserServiceImpl implements UserService, UserDetailsService {

    private final UserRepo userRepo;
    private final PasswordEncoder passwordEncoder;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        User user  = userRepo.findUserByEmail(email);
        if(user == null){
            log.error("User Not Found in the Database!");
            throw new UsernameNotFoundException("User not found in the database");
        }
        else{
            log.info("User {} Found in the Database!",email);
        }
        SimpleGrantedAuthority authority = new SimpleGrantedAuthority(user.getRole().getRoleName());
        return new org.springframework.security.core.userdetails.User(user.getEmail(),user.getPassword(), Collections.singleton(authority));
    }

    @Override
    public User saveUser(User user) {
        log.info("Saving new user {} to database: ", user.getEmail());
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        return userRepo.save(user);
    }

    @Override
    public User getUser(String email) {
        log.info("Getting user {} from database: ", email);
        return userRepo.findUserByEmail(email);
    }

    @Override
    public List<User> getUsers() {
        log.info("Getting All users from database: ");
        return userRepo.findAll();
    }

}
