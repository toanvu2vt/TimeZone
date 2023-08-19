package com.poly.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.poly.entity.Account;
import com.poly.service.AccountService;
import com.poly.service.EmailService;
import com.poly.service.VNPayService;
import com.poly.service.VerificationTokenService;

@Controller
public class VNPayController {
	
    @Autowired
    private VNPayService vnPayService;

    @SuppressWarnings("unused")
	@Autowired
    private EmailService emailService;

    @Autowired
    AccountService accountService;
    
    @Autowired
    VerificationTokenService verificationTokenService;
    
    @GetMapping("/pay")
    public String home(){
        return "pay/index";
    }

    @PostMapping("/submitOrder")
    public String submidOrder(@RequestParam("amount") int orderTotal,
                            @RequestParam("orderInfo") String orderInfo,
                            HttpServletRequest request){
        String baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
        String vnpayUrl = vnPayService.createOrder(orderTotal, orderInfo, baseUrl);
        return "redirect:" + vnpayUrl;
    }

    @GetMapping("/vnpay-payment")
    public String GetMapping(HttpServletRequest request, Model model){
        int paymentStatus = vnPayService.orderReturn(request);

        String orderInfo = request.getParameter("vnp_OrderInfo");
        String paymentTime = request.getParameter("vnp_PayDate");
        String transactionId = request.getParameter("vnp_TransactionNo");
        String totalPrice = request.getParameter("vnp_Amount");

        model.addAttribute("orderId", orderInfo);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("paymentTime", paymentTime);
        model.addAttribute("transactionId", transactionId);

        if(paymentStatus == 1) {
        	Account account = accountService.findById(request.getRemoteUser());
        	String token = verificationTokenService.createVerificationTokenForUser(account);
        	emailService.sendPaymentSuccess(account.getEmail(), token, account.getFullname(), transactionId);
        	emailService.sendPaymentStatus("cuongkvps25207@fpt.edu.vn", token, transactionId);
        	return "/pay/ordersuccess";
        } else {
        	return "/pay/orderfail";
        }
        
        
        
        
    }
}
