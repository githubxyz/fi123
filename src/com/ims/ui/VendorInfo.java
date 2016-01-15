package com.ims.ui;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ims.dto.PurchasePaymentInfoDTO;
import com.ims.exception.OperationFailedException;
import com.ims.exception.ValidationException;
import com.ims.service.productService.IPurchasePaymentService;
import com.ims.service.productService.PurchasePaymentInfoServiceImpl;
import com.ims.utility.IRequestAttribute;

/**
 * Servlet implementation class VendorInfo
 */
//@WebServlet("/VendorInfo")
public class VendorInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public VendorInfo() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		IPurchasePaymentService purchasePaymentService=new PurchasePaymentInfoServiceImpl();
		 List<PurchasePaymentInfoDTO> purchasePaymentInfoDTOs=new ArrayList<>();
		try {
			purchasePaymentInfoDTOs=purchasePaymentService.searchVendorDetail(null, null, null);
		} catch (OperationFailedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ValidationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
		request.setAttribute(IRequestAttribute.VENDOR_LIST, purchasePaymentInfoDTOs);
		RequestDispatcher rd=request.getRequestDispatcher("/pages/vendorPayment.jsp");
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
