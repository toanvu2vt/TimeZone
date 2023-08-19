package com.poly.service.impl;

import java.util.Optional;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.poly.dao.AccountsDAO;
import com.poly.dao.AuthorityDAO;
import com.poly.entity.Account;
import com.poly.entity.Authority;
import com.poly.entity.Order;
import com.poly.entity.Product;
import com.poly.entity.Role;
import com.poly.service.AccountService;
import com.poly.service.AuthorityService;

@Service
public class AccountServiceImpl implements AccountService {
	@Autowired
	AccountsDAO accountsDAO;

	@Autowired
	AuthorityDAO authorityDAO;
	
	@Autowired
	BCryptPasswordEncoder encoder;
	
	@Override
	public Account findById(String username) {
		return accountsDAO.findById(username).get();
	}

	@Override
	public Account update(Account account) {
		return accountsDAO.save(account);
	}

	@Override
	public void delete(String username) {
		accountsDAO.deleteById(username);
	}

	@Override
	public void create(Account account) {
		accountsDAO.save(account);
	}

	@Override
    public Account findByUsernameAndEmail(String username, String email) {
        return accountsDAO.findByUsernameAndEmail(username, email);
    }

	@Override
	public Optional<Account> findByUsername(String username) {
		return accountsDAO.findByUsername(username);
	}

	@Override
	public boolean checkUsernameExists(String username) {
		return accountsDAO.findByUsername(username).isPresent();
	}

	@Override
	public List<Account> getStaff() {
		return accountsDAO.getStaff();
	}

	@Override
	public List<Account> findALL() {
		return accountsDAO.findAll();
	}

	@Override
	public Account create(JsonNode account) {
		ObjectMapper mapper = new ObjectMapper();
		Account newAccount = mapper.convertValue(account, Account.class);
		
		String password = account.get("password").asText();
		newAccount.setPassword(encoder.encode(password));
		
		Role role = new Role();
		role.setId("STA");
		
		Authority authority = new Authority();
		authority.setRole(role);
		
		Account savedAccount = accountsDAO.save(newAccount);

		authority.setAccount(savedAccount);
	    Authority savedAuthority = authorityDAO.save(authority);

	   return savedAccount;
	}
	  	 
}
