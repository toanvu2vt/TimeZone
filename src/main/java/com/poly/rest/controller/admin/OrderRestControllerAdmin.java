package com.poly.rest.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.poly.entity.Order;
import com.poly.service.OrderService;

@CrossOrigin("*")
@RestController
@RequestMapping("/rest/order")
public class OrderRestControllerAdmin {
	@Autowired
	OrderService orderService;
	
	@GetMapping()
	public List<Order> getOrdered() {
		return orderService.getOrdered();
	}
	
	@GetMapping("/confirm")
	public List<Order> getOrderedConfirmed() {
		return orderService.getOrderedConfirmed();
	}
	
	@GetMapping("/cancelled")
	public List<Order> getOrderedCancelled() {
		return orderService.getOrderedCancelled();
	}
	
	@GetMapping("/successful")
	public List<Order> getOrderedSuccessful() {
		return orderService.getOrderedSuccessful ();
	}
	
	@PutMapping("/{id}")
	public Order updateOrder(@PathVariable("id") Long id,@RequestBody Order updateOrder) {
		return orderService.update(updateOrder);
	}
	
	@PutMapping("/cancel/{id}")
	public Order cancelOrder(@PathVariable("id") Long id, @RequestBody Order orderCancel) {
		return orderService.update(orderCancel);
	}
	
	@PutMapping("/reset/{id}")
	public Order resetOrder(@PathVariable("id") Long id, @RequestBody Order orderReset) {
		return orderService.update(orderReset);
	}
	
	@PutMapping("/success/{id}")
	public Order sucessOrder(@PathVariable("id") Long id, @RequestBody Order orderSuccess) {
		return orderService.update(orderSuccess);
	}
}
