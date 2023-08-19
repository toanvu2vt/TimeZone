package com.poly.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.poly.dao.report.ReportDAO;
import com.poly.entity.Product;
import com.poly.service.ProductService;
import com.poly.service.StatisticalService;

@Controller
public class HomeAdminController {
	@Autowired
	ProductService productService;

	@Autowired
	ReportDAO reportDAO;

	@Autowired
	StatisticalService service;

	@RequestMapping("/admin/index")
	public String show() {
		return "admin/DashBoard";
	}
	
	@RequestMapping("/admin/order")
	public String orderManager() {
		return "admin/order";
	}

	@RequestMapping("/admin/authority")
	public String authority() {
		return "admin/authority";
	}

	@RequestMapping("/admin/staff")
	public String Profile() {
		return "admin/staff";
	}

	@RequestMapping("/admin/orders")
	public String order() {
		return "admin/orders";
	}

	@RequestMapping("/admin/statistical")
	public String statistical(Model model) {

		String totalAccount = service.totalAccount();
		model.addAttribute("totalAccount", totalAccount);

		String totalOrder = service.totalOrder();
		model.addAttribute("totalOrder", totalOrder);

		Integer productsSold = service.totalProductSold();
		model.addAttribute("totalProductsSold", productsSold);

		Double totaRevenue = service.totalRevenue();
		model.addAttribute("totalRevenue", totaRevenue);

		List<Object[]> countProductSold = service.countProductSold();
		model.addAttribute("countProductSold", countProductSold);

		List<Object[]> getRevenuePerProduct = service.getRevenuePerProduct();
		model.addAttribute("revenuePerProduct", getRevenuePerProduct);

		List<Object[]> totalAmountPaid = service.getTotalAmountPaid();
		model.addAttribute("totalAmountPaid", totalAmountPaid);

		List<Object[]> revenue = service.getRevenue();
		model.addAttribute("revenue", revenue);

		return "admin/statistical";
	}

	@GetMapping("/admin/index/{id}")
	public Product getOne(@PathVariable("id") Integer id) {
		return productService.findById(id);
	}

	@RequestMapping("/admin/report")
	public String getReport(Model model) {
		return "admin/report";
	}
}
