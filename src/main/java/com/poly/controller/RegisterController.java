package com.poly.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.poly.entity.Account;
import com.poly.service.AccountService;
import com.poly.service.EmailService;

@Controller
public class RegisterController {
	@Autowired
	AccountService accountService;

	@Autowired
	BCryptPasswordEncoder pe;

	@Autowired
	EmailService emailService;

	@RequestMapping(value = "/security/register", method = RequestMethod.GET)
	public String registerForm(Model model) {
		model.addAttribute("account", new Account());
		return "/security/register";
	}

	@RequestMapping(value = "/security/register", method = RequestMethod.POST)
	public String register(Model model, @RequestParam("password") String Password,
			@RequestParam("password1") String Password1, @Valid Account account, BindingResult bindingResult) {
		if (accountService.checkUsernameExists(account.getUsername())) {
			model.addAttribute("message", "Username already exists");
			return "/security/register";
		}
		if (bindingResult.hasErrors()) {
			model.addAttribute("message", "Please review registration information");
			model.addAttribute("account", account);
			return "/security/register";
		}
		if (Password.equals(Password1) && !bindingResult.hasErrors() ) {
			account.setPassword(pe.encode(Password));
			String fullname = account.getFirstname() + " " + account.getLastname();
			account.setFullname(fullname);
			accountService.create(account);
			emailService.sendWelcomeEmail(account.getEmail(), account.getFirstname(), account.getLastname());
			model.addAttribute("message", "Register Success");
			return "/security/login";
		} else {
			model.addAttribute("message", "Wrong Password");
			return "/security/register";
		}
		
	}

}