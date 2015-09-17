package com.ims.ui;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import com.ims.dto.ProductMasterDTO;
import com.ims.dto.StockAlertDTO;
import com.ims.service.productService.IProductService;
import com.ims.service.productService.ProductServiceImpl;
import com.ims.service.stockAlartService.IStockAlartService;
import com.ims.service.stockAlartService.StockAlartServicesImpl;
import com.mchange.v2.beans.BeansUtils;

/**
 * Servlet implementation class SaveProduct
 */
//@WebServlet("/SaveStockAlart")
public class SaveStockAlart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SaveStockAlart() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
    	RequestDispatcher rd=request.getRequestDispatcher("/pages/SaveStockAlart.jsp");
		try {
			IStockAlartService stockAlartService=new StockAlartServicesImpl();
			List<StockAlertDTO> list=stockAlartService.listStockAlart();
			request.setAttribute("stockAlartList", list);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		rd.forward(request, response);
    }
	 
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		StockAlertDTO sad=new StockAlertDTO();
		boolean error=false;
		try {
			BeanUtils.populate(sad, request.getParameterMap());
			IStockAlartService stockAlartService=new StockAlartServicesImpl();
			if(sad!=null)
				stockAlartService.saveStockAlert(sad);
			List<StockAlertDTO> list=stockAlartService.listStockAlart();
			request.setAttribute("stockAlarttList", list);
			
		} catch (Exception e) {
			error=true;
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		if(error){
			response.getWriter().append("error to save: "+sad).append(request.getContextPath());
		}else{
		
		
		RequestDispatcher rd=request.getRequestDispatcher("/pages/SaveStockAlart.jsp");
		rd.forward(request, response);
		}
	}

}
