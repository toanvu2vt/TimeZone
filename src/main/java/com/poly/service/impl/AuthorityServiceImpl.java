package com.poly.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.poly.dao.AccountsDAO;
import com.poly.dao.AuthorityDAO;
import com.poly.entity.Account;
import com.poly.entity.Authority;
import com.poly.service.AuthorityService;

@Service
public class AuthorityServiceImpl implements AuthorityService{
	@Autowired
	AuthorityDAO authorityDAO;
	
	@Autowired
	AccountsDAO accountDAO;
	
	@Override
	public List<Authority> getAdmin() {
		List<Account> accounts = accountDAO.getStaff();
		return authorityDAO.autoritiesOf(accounts);
	}

	@Override
	public List<Authority> findALL() {
		return authorityDAO.findAll();
	}

	@Override
	public void delete(Integer id) {
		authorityDAO.deleteById(id);
	}

	@Override
	public Authority create(Authority authority) {
		return authorityDAO.save(authority);
	}

}
