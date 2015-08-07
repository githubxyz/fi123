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
import com.ims.service.productService.IProductService;
import com.ims.service.productService.ProductServiceImpl;
import com.mchange.v2.beans.BeansUtils;

/**
 * Servlet implementation class SaveProduct
 */
@WebServlet("/pages/saveProduct")
public class SaveProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SaveProduct() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ProductMasterDTO pm=new ProductMasterDTO();
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
		} 
		if(error){
			response.getWriter().append("error to save: "+pm).append(request.getContextPath());
		}else{
		
		
		RequestDispatcher rd=request.getRequestDispatcher("/pages/product.jsp");
		rd.forward(request, response);
		}
	}

}
