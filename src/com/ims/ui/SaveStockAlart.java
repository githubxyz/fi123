package com.ims.ui;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.Collection;
import java.util.List;
import org.apache.log4j.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import com.ims.dto.ProductMasterDTO;
import com.ims.dto.StockAlertDTO;
import com.ims.exception.OperationFailedException;
import com.ims.exception.ValidationException;
import com.ims.service.productService.IProductService;
import com.ims.service.productService.ProductServiceImpl;
import com.ims.service.stockAlartService.IStockAlartService;
import com.ims.service.stockAlartService.StockAlartServicesImpl;
import com.ims.utility.IRequestAttribute;
import com.mchange.v2.beans.BeansUtils;

/**
 * Servlet implementation class SaveProduct
 */
//@WebServlet("/SaveStockAlart")
public class SaveStockAlart extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Logger logger = Logger.getLogger("abc");   
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
			IProductService productService=new ProductServiceImpl();
				List<ProductMasterDTO> prMasterDTOs=productService.listProduct();
				request.setAttribute(IRequestAttribute.PRODUCT_LIST, prMasterDTOs);
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
		Collection<String> errors=null;
		boolean error=false;
		try {
			BeanUtils.populate(sad, request.getParameterMap());
			String masterIdString=request.getParameter("prodId");
			int masterid=Integer.parseInt(masterIdString);
			ProductMasterDTO pm = new ProductMasterDTO();
			pm.setId(masterid);
			sad.setProductMaster(pm);
			IStockAlartService stockAlartService=new StockAlartServicesImpl();
			if(sad!=null)
				stockAlartService.saveStockAlert(sad);
			List<StockAlertDTO> list=stockAlartService.listStockAlart();
			request.setAttribute("stockAlarttList", list);
			
		} catch (Exception e) {
		/*	error=true;
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		if(error){
			response.getWriter().append("error to save: "+sad).append(request.getContextPath());
		}else{
		
		
		doGet(request, response);
		}
		*/
		
		
		error=true;
		// TODO Auto-generated catch block
		e.printStackTrace();
		if(e instanceof ValidationException){
			ValidationException v=(ValidationException) e;
			errors=v.getErrorCodes();
		}
	}
	RequestDispatcher rd=null;
	if(error){
		response.setHeader("error", "1");
		request.setAttribute("errors", errors);
		 rd=request.getRequestDispatcher("/pages/error.jsp");
	}else{
	 rd=request.getRequestDispatcher("/pages/SaveStockAlartList.jsp");
	// rd=request.getRequestDispatcher("/pages/SaveStockAlart.jsp");
	}
    rd.forward(request, response);		
	//doGet(request, response);
	}
}
