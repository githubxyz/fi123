package com.ims.ui;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import com.ims.dto.ProductDetailDTO;
import com.ims.dto.ProductMasterDTO;
import com.ims.dto.UserDTO;
import com.ims.persistence.hibernate.dao.IProductDetailDAO;
import com.ims.persistence.hibernate.dao.ProductDetailDAOImpl;
import com.ims.service.productService.IProductService;
import com.ims.service.productService.ProductServiceImpl;

/**
 * Servlet implementation class saveStock
 */
public class SaveStock extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SaveStock() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		RequestDispatcher rd=request.getRequestDispatcher("/pages/enterStock.jsp");
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ProductDetailDTO productDetailDTO=new ProductDetailDTO();
		boolean error=false;
		try{
			int productId=Integer.parseInt(request.getParameter("prodId"));
			ProductMasterDTO pm=new ProductMasterDTO();
			pm.setId(productId);
			BeanUtils.populate(productDetailDTO, request.getParameterMap());
			productDetailDTO.setProductMaster(pm);
			//Todo set the branchId from session parameter
			productDetailDTO.setBranch(1);
			UserDTO user=new UserDTO();
			user.setId(1);
			productDetailDTO.setUser(user);
			IProductService productService=new ProductServiceImpl();
			productService.saveProductDetail(productDetailDTO);
			
		}catch(Exception e){
			error=true;
			e.printStackTrace();
		}
		if(error){
			response.getWriter().append("error to save: "+productDetailDTO).append(request.getContextPath());
		}else{
		
		
		RequestDispatcher rd=request.getRequestDispatcher("/pages/enterStock.jsp");
		rd.forward(request, response);
		}

	}

}
