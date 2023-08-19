package com.poly.service.impl;

import java.time.LocalDateTime;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.poly.dao.VerificationTokenDAO;
import com.poly.entity.Account;
import com.poly.entity.VerificationToken;
import com.poly.service.VerificationTokenService;

@Service
@EnableScheduling
public class VerificationTokenServiceImpl implements VerificationTokenService {

	@Autowired
	VerificationTokenDAO verificationTokenDAO;

	public String createVerificationTokenForUser(Account account) {
		Random random = new Random();
		int tokenInt = random.nextInt(1000000);
		String token = String.format("%06d", tokenInt);

		VerificationToken verificationToken = new VerificationToken();
		verificationToken.setToken(token);
		verificationToken.setAccount(account);

		LocalDateTime expiry_date = LocalDateTime.now().plusSeconds(60);
		verificationToken.setExpiryDate(expiry_date);

		verificationTokenDAO.save(verificationToken);
		return token;
	}
	
	@Override
	public VerificationToken findByToken(String token) {
		return verificationTokenDAO.findByToken(token);
	}
}
