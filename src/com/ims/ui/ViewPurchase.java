package com.ims.ui;

import com.ims.dto.ProductDetailDTO;
import com.ims.dto.StockDetailDTO;
import com.ims.service.productService.IProductDetailService;
import com.ims.service.productService.ProductDetailServiceImpl;
import com.ims.service.viewStock.IViewStockService;
import com.ims.service.viewStock.ViewStockServiceImpl;
import com.ims.utility.ISessionAttribute;

import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class SaveProduct
 */
//@WebServlet("/ViewPurchase")
public class ViewPurchase extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ViewPurchase() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	ProductDetailDTO pd=new ProductDetailDTO();
		boolean error=false;
		try {
			BeanUtils.populate(pd, request.getParameterMap());
			IProductDetailService productDetailService=new ProductDetailServiceImpl();
			if(pd!=null)
				productDetailService.listOfPurchase(1);
			List<ProductDetailDTO> list=productDetailService.listOfPurchase(1);
			request.setAttribute(ISessionAttribute.PURCHASE_LIST, list);
			
		} catch (Exception e) {
			error=true;
			// TODO Auto-generated catch block 
			e.printStackTrace();
		}
		if(error){
			response.getWriter().append("error to save: "+pd).append(request.getContextPath());
		}else{
		
		
		RequestDispatcher rd=request.getRequestDispatcher("/pages/viewPurchaseDetails.jsp");
		rd.forward(request, response);
		}
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ProductDetailDTO pd=new ProductDetailDTO();
		boolean error=false;
		try {
			BeanUtils.populate(pd, request.getParameterMap());
			IProductDetailService productDetailService=new ProductDetailServiceImpl();
			if(pd!=null)
				productDetailService.listOfPurchase(1);
			List<ProductDetailDTO> list=productDetailService.listOfPurchase(1);
			request.setAttribute(ISessionAttribute.PURCHASE_LIST, list);
			
		} catch (Exception e) {
			error=true;
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(error){
			response.getWriter().append("error to save: "+pd).append(request.getContextPath());
		}else{
		
		
		RequestDispatcher rd=request.getRequestDispatcher("/pages/viewPurchaseDetails.jsp");
		rd.forward(request, response);
		}
	}
}
