package com.poly.controller;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.poly.entity.Category;
import com.poly.entity.Product;
import com.poly.service.CategoryService;
import com.poly.service.ProductService;

@Controller
public class ProductController {
	@Autowired
	ProductService productService;
	
	@Autowired
	CategoryService categoryService;
	
	@RequestMapping("/home/shop")
	public String shop(Model model,@RequestParam("cid") Optional<String> cid) {
		if(cid.isPresent()) {
			List<Category> listCates = categoryService.findAll();
			model.addAttribute("cates", listCates);
		} else {
			List<Product> listProduct = productService.findAll();
			model.addAttribute("items", listProduct);	

		}

		return "/product/shop";
	}
	
	@RequestMapping("/home/shop/sortByPrice")
	public String sortByPrice(Model model) {
		List<Product> listProductSortByPrice = productService.findAll();
		Collections.sort(listProductSortByPrice,Comparator.comparing(Product::getPrice).reversed());
		model.addAttribute("items", listProductSortByPrice);	
		return "/product/shop";
	}
	
	@RequestMapping("/home/shop/sortByName")
	public String sortByName(Model model) {
		List<Product> listProductSortByName = productService.findAll();
		
		Collections.sort(listProductSortByName,Comparator.comparing(Product::getName));
		model.addAttribute("items", listProductSortByName);	
			
		return "/product/shop";
	}
	
	@RequestMapping("/home/shop/detail/{id}")
	public String detail(Model model, @PathVariable("id") Integer id) {
		Product item = productService.findById(id);
		model.addAttribute("item", item);
		return "product/detail";
	}
	
	@RequestMapping("/home/shop/findByName")
	public String product(Model model,@RequestParam("keyword") String kw) {
		List<Product> list = productService.findByName("%" + kw + "%");
		model.addAttribute("items", list);
		return "/product/shop";
	}
	
}
