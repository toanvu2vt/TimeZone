package com.poly.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.poly.entity.Order;
import com.poly.entity.OrderDetail;
import com.poly.service.OrderDetailService;
import com.poly.service.OrderService;

@Controller
public class OrderController {
	@Autowired
	OrderService orderService;
	
	@Autowired
	OrderDetailService orderDetailService;
	
	@Autowired
	HttpServletRequest request;
	
	@RequestMapping("/home/checkout")
	public String checkout() {
		return "/checkout/checkout";
	}
	@RequestMapping("/home/order")
	public String list(Model model) {
		String username = request.getRemoteUser();
		model.addAttribute("orders", orderService.findByUserName(username));
		return "/order/list";
	}
	
	@RequestMapping("/order/detail/{id}")
	public String detail(@PathVariable("id") Long id, Model model) {
		Order order = orderService.findById(id);
		double totalAmount = caculateTotalAmout(order);
		model.addAttribute("totalAmount", totalAmount);
		model.addAttribute("order", order);
		return "/order/detail";
	}
	
	private double caculateTotalAmout(Order order) {
		double total = 0.0;
		List<OrderDetail> orderDetails = order.getOrderDetails();
		for (OrderDetail detail : orderDetails) {
			total += detail.getQuantity() * detail.getPrice();
		}
		return total;
	}
	
}
