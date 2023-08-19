package com.poly.controller;

import java.time.LocalDateTime;
import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.validation.ConstraintViolation;
import javax.validation.Validator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.poly.dao.VerificationTokenDAO;
import com.poly.entity.Account;
import com.poly.entity.VerificationToken;
import com.poly.service.AccountService;
import com.poly.service.EmailService;
import com.poly.service.VerificationTokenService;

@Controller
public class ForgotPasswordController {
    @Autowired
    private AccountService accountService;

    @Autowired
    private VerificationTokenService verificationTokenService;

    @Autowired 
    VerificationTokenDAO dao;
    
    @Autowired
    private EmailService emailService;

    @Autowired
	BCryptPasswordEncoder pe;
    
    @Autowired
    private Validator validator;
    @GetMapping("/security/forgot")
    public String showForgotPasswordForm() {
        return "/security/forgot";
    }

    @PostMapping("/security/forgot")
    public String processForgotPasswordForm(@RequestParam("username") String username, @RequestParam("email") String email, Model model,HttpSession session) {
        
    	Account account = accountService.findByUsernameAndEmail(username, email);
        if (account == null) {
            model.addAttribute("message", "Invalid username or email");
            return "/security/forgot";
        }
        String token = verificationTokenService.createVerificationTokenForUser(account);
        session.setAttribute("token", token);
        emailService.sendEmail(email, token,account.getFirstname(),account.getLastname());
        model.addAttribute("message", "An email with a reset link has been sent to your email address");
        return "/security/verifi";
    }

    @GetMapping("/security/verifi")
    public String showVerifiForm() {
        return "/security/verifi";
    }

    @PostMapping("/security/verifi")
    public String processVerifiForm(@RequestParam("token") String tokenveri, Model model, HttpSession session) {
        String token = (String) session.getAttribute("token");
        if (tokenveri.equals(token)) {
            VerificationToken verificationToken = verificationTokenService.findByToken(token);
            LocalDateTime expiryDate = verificationToken.getExpiryDate();
            if (LocalDateTime.now().isBefore(expiryDate)) {
                return "redirect:/security/confirmPass";
            } else {
            	delete();
                model.addAttribute("message", "Invalid or expired token");
                return "/security/verifi";
            }
        } else {
            model.addAttribute("message", "Invalid or expired token");
            return "/security/verifi";
        }
    }


    @GetMapping("/security/confirmPass")
    public String confirmPassForm() {
        return "/security/confirmPass";
    }
    
    @PostMapping("/security/confirmPass")
    public String processResetPassword(@RequestParam("password") String password, @RequestParam("password1") String password1, Model model, HttpSession session) {
        String token = (String) session.getAttribute("token");
        VerificationToken verificationToken = verificationTokenService.findByToken(token);
        Account account = verificationToken.getAccount();
        
        if(password.isEmpty() || password1.isEmpty()) {
        	model.addAttribute("message", "Password is empty");
        	return "/security/confirmPass";
        }
        
        Set<ConstraintViolation<Account>> violations = validator.validate(account);
        if (!violations.isEmpty()) {
            for (ConstraintViolation<Account> violation : violations) {
                model.addAttribute("message", violation.getMessage());
            }
            return "/security/confirmPass";
        } else if (!password.equals(password1)) {
        	model.addAttribute("message", "Passwords do not match");
        	return "/security/confirmPass";
        } 
        
        account.setPassword(pe.encode(password));
        accountService.create(account);
        
        delete();
        
        model.addAttribute("message", "Your password has been reset successfully");
        return "/security/login";
    }

    @Transactional
	public void delete() {
		LocalDateTime now = LocalDateTime.now().plusMinutes(1);
		dao.deleteByExpiryDateBefore(now);
	}
    
}