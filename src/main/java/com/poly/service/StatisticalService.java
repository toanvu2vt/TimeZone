package com.poly.service;

import java.util.List;

public interface StatisticalService {

	String totalAccount();

	String totalOrder();

	Integer totalProductSold();

	Double totalRevenue();

	List<Object[]> countProductSold();

	List<Object[]> getRevenuePerProduct();

	List<Object[]> getTotalAmountPaid();

	List<Object[]> getRevenue();

}
