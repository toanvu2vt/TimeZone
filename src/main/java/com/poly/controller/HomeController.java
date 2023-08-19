package com.poly.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

	@RequestMapping({ "/", "/home/index" })
	public String index() {
		return "redirect:/home/main";
	}

	@RequestMapping("/home/main")
	public String main() {
		return "/home/main";
	}

	@RequestMapping("/home/login")
	public String login() {
		return "/security/login";
	}

	@RequestMapping("/home/detail")
	public String detail() {
		return "/product/detail";
	}

	@RequestMapping("/home/account")
	public String profile() {
		return "home/profile";
	}

}
