package com.poly.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.poly.entity.Product;
import com.poly.service.ProductService;

@Controller
public class CategoryController {
	@Autowired
	ProductService productService;
	
	@RequestMapping("/category/list")
	public String getCateListById(Model model,@RequestParam("cid") Optional<String> cid) {
		if (cid.isPresent()) {
			List<Product> listProduct = productService.findByCategory(cid.get());
			model.addAttribute("items", listProduct);
			return "product/shop";
		} else {
			return "product/shop";
		}
	}
}
