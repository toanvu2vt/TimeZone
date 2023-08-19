package com.poly.entity;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Getter;
import lombok.Setter;

@SuppressWarnings("serial")
@Getter
@Setter
@Entity
@Table(name = "Accounts")
public class Account implements Serializable {
    @Id
    @NotBlank(message = "Username is required")
    String username;

    @NotBlank(message = "Password is required")
    @Size(min = 8, message = "Password must be at least 8 characters long")
    @Pattern(regexp = "^(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\\d]){1,})(?=(.*[\\W]){1,})(?!.*\\s).{8,}$", message = "Password must contain at least one lowercase letter, one uppercase letter, one digit and one special character")
    String password;

    String fullname;

    @NotBlank(message = "Surname and middle name is required")
    String firstname;

    @NotBlank(message = "Lastname is required")
    String lastname;

    @NotBlank(message = "Email is required")
    @Email(message = "Email must be in the correct format")
    String email;
    @Pattern(regexp = "^[0-9]*$", message = "Phone number must only contain digits")
    @Size(min = 9, max = 10, message = "Phone number must be between 9 and 10 digits")
    String phone;
    
    @JsonIgnore
    @OneToMany(mappedBy = "account")
    List<Order> orders;

    @JsonIgnore
    @OneToMany(mappedBy = "account", fetch = FetchType.EAGER)
    List<Authority> authorities;

}
