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

import org.apache.commons.beanutils.BeanUtils;
import org.apache.log4j.Logger;

import com.ims.dto.ProductMasterDTO;
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
	private static Logger logger = Logger.getLogger("com.biz");   
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
		logger.info("entry");
		String type=request.getParameter("type");
		logger.info("request type="+type);
		if("save".equalsIgnoreCase(type)){
			saveVendor(request, response);
		}else if("edit".equalsIgnoreCase(type)){
		editVendor(request, response);
	}else{
			doGet(request, response);
		}
	}
	
	protected void saveVendor(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PurchasePaymentInfoDTO purchasePaymentInfoDTO= new PurchasePaymentInfoDTO();
		logger.info("entry");
		try{
		BeanUtils.populate(purchasePaymentInfoDTO, request.getParameterMap());
		logger.info(purchasePaymentInfoDTO);
		IPurchasePaymentService purchasePaymentService=new PurchasePaymentInfoServiceImpl();
		purchasePaymentService.saveVendorDetail(purchasePaymentInfoDTO);
		}catch(Exception e){
			e.printStackTrace();
		}
		logger.info("exit");
		doGet(request, response);
		
	}
	
	protected void editVendor(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		logger.info("entry");
		PurchasePaymentInfoDTO puDto=new PurchasePaymentInfoDTO();
		try{
			String billNo=request.getParameter("billNo");
			IPurchasePaymentService purchasePaymentService=new PurchasePaymentInfoServiceImpl();
			 puDto=purchasePaymentService.loadByBillNo(billNo);
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
		request.setAttribute(IRequestAttribute.EDIT_VENDOR_DETAIL, puDto);
		logger.info(puDto);
		logger.info("exit");
		RequestDispatcher rd=request.getRequestDispatcher("/pages/vendorDetail.jsp");
		rd.forward(request, response);
		
	}

}
