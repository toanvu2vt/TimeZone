package com.poly.service.impl;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.poly.dao.AccountsDAO;
import com.poly.dao.OrderDAO;
import com.poly.dao.OrderDetailDAO;
import com.poly.dao.OrderStatusDAO;
import com.poly.entity.Order;
import com.poly.entity.OrderDetail;
import com.poly.service.OrderService;

@Service
public class OrderServiceImpl implements OrderService {
	@Autowired
	AccountsDAO accountDAO;

	@Autowired
	OrderDAO orderDAO;

	@Autowired
	OrderDetailDAO orderDetailDAO;
	
	@Override
	public Order create(JsonNode orderData) {
		ObjectMapper mapper = new ObjectMapper();

		Order order = mapper.convertValue(orderData, Order.class);
		orderDAO.save(order);

		TypeReference<List<OrderDetail>> type = new TypeReference<List<OrderDetail>>() {
		};
		List<OrderDetail> details = mapper.convertValue(orderData.get("orderDetails"), type)
				.stream().peek(d -> d.setOrder(order))
				.collect(Collectors.toList());
		orderDetailDAO.saveAll(details);

		return order;
	}

	@Override
	public List<Order> findByUserName(String username) {
		return orderDAO.findByUserName(username);
	}

	@Override
	public Order findById(Long id) {
		return orderDAO.findById(id).get();
	}

	@Override
	public List<Order> getOrdered() {
		return orderDAO.findByOrderStatusId(1);
	}

	@Override
	public List<Order> getOrderedConfirmed() {
		return orderDAO.findByOrderStatusId(2);
	}

	@Override
	public List<Order> getOrderedCancelled() {
		return orderDAO.findByOrderStatusId(3);
	}

	@Override
	public List<Order> getOrderedSuccessful() {
		return orderDAO.findByOrderStatusId(4);
	}

	@Override
	public Order update(Order updateOrder) {
		return orderDAO.save(updateOrder);
	}

}
