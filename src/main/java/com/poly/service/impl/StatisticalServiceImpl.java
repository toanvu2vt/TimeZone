package com.poly.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.poly.dao.report.ReportDAO;
import com.poly.service.StatisticalService;

@Service
public class StatisticalServiceImpl implements StatisticalService{
	@Autowired
	ReportDAO reportDAO;

	@Override
	public String totalAccount() {
		return reportDAO.totalAccount();
	}

	@Override
	public String totalOrder() {
		return reportDAO.totalOrder();
	}

	@Override
	public Integer totalProductSold() {
		return reportDAO.totalProductHasSold();
	}

	@Override
	public Double totalRevenue() {
		return reportDAO.totalRevenue();
	}

	@Override
	public List<Object[]> countProductSold() {
		return reportDAO.countProductSold();
	}

	@Override
	public List<Object[]> getRevenuePerProduct() {
		return reportDAO.getRevenuePerProduct();
	}

	@Override
	public List<Object[]> getTotalAmountPaid() {
		return reportDAO.getTotalAmountPaid();
	}

	@Override
	public List<Object[]> getRevenue() {
		return reportDAO.getRevenue();
	}
	
	
}
