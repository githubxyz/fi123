package com.ims.ui;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.Collection;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import com.ims.dto.ProductMasterDTO;
import com.ims.exception.ValidationException;
import com.ims.service.productService.IProductService;
import com.ims.service.productService.ProductServiceImpl;
import com.mchange.v2.beans.BeansUtils;

/**
 * Servlet implementation class SaveProduct
 */
//@WebServlet("/saveProduct")
public class SaveProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SaveProduct() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
    	RequestDispatcher rd=request.getRequestDispatcher("/pages/product.jsp");
		try {
			IProductService productService=new ProductServiceImpl();
			List<ProductMasterDTO> list=productService.listProduct();
			request.setAttribute("productList", list);
			
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
		ProductMasterDTO pm=new ProductMasterDTO();
		Collection<String> errors=null;
		boolean error=false;
		try {
			BeanUtils.populate(pm, request.getParameterMap());
			IProductService productService=new ProductServiceImpl();
			if(pm!=null)
			productService.saveProduct(pm);
			List<ProductMasterDTO> list=productService.listProduct();
			request.setAttribute("productList", list);
			
		} catch (Exception e) {
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
		
		
		 rd=request.getRequestDispatcher("/pages/productList.jsp");
		
		}
		rd.forward(request, response);
	}

}
