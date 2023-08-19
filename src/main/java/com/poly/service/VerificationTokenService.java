package com.poly.service;

import com.poly.entity.Account;
import com.poly.entity.VerificationToken;

public interface VerificationTokenService {
	public String createVerificationTokenForUser(Account account);
	
	public VerificationToken findByToken(String token);
	
	
}
