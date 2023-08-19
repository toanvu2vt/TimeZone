package com.poly.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.poly.entity.Account;
import com.poly.service.AccountService;

@Controller
public class SecurityController {
	@Autowired
	AccountService accountService;

	@Autowired
	HttpServletRequest request;

	@RequestMapping("/security/login/form")
	public String form(Model model) {
		model.addAttribute("message", "Login");
		return "/security/login";
	}

	@RequestMapping("/security/login")
	public String processLogin(Model model, @RequestParam("username") String username,
			@RequestParam("password") String passFromRequest) {
		Account account = accountService.findById(username);
		
		if (account != null ) {
			String password = account.getPassword();
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			if (!encoder.matches(passFromRequest, password) || username != account.getUsername()) {
				model.addAttribute("message", "Username or password incorrect");
				return "redirect:/security/login/error";
			} else {
				return "redirect:/security/login/success";
			}
		} else {
			return "redirect:/security/login/error";
		}

	}

	@RequestMapping("/security/login/success")
	public String success() {
		return "redirect:/home/main";

	}

	@RequestMapping("/security/login/error")
	public String error(Model model) {
		model.addAttribute("message", "Username or password incorrect");
		return "/security/login";
	}

	@RequestMapping("/security/login/unauthoried")
	public String unauthoried(Model model) {
		model.addAttribute("messsage", "Your don't have role to get url");
		return "/security/login";
	}

	@RequestMapping("/security/logoff/success")
	public String logoff() {
		return "redirect:/home/index";
	}
}
