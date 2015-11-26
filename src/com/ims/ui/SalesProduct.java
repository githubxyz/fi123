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
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.log4j.Logger;

import com.ims.dto.ProductGroupMapDTO;
import com.ims.dto.ProductMasterDTO;
import com.ims.dto.SaleItemDTO;
import com.ims.exception.OperationFailedException;
import com.ims.service.productService.IProductDetailService;
import com.ims.service.productService.IProductService;
import com.ims.service.productService.ProductDetailServiceImpl;
import com.ims.service.productService.ProductServiceImpl;
import com.ims.utility.IRequestAttribute;
import com.ims.utility.ISessionAttribute;

/**
 * Servlet implementation class SalesProduct
 */
@WebServlet("/SalesProduct")
public class SalesProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Logger logger = Logger.getLogger("com.biz");   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SalesProduct() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		IProductDetailService detailService=new ProductDetailServiceImpl();
		try {
			HttpSession session = request.getSession(true);
			session.setAttribute(ISessionAttribute.SALE_ITEM_LIST,null);
			List<ProductGroupMapDTO> productGroupMapDTOs = detailService.getProductGroupCodeLists();
			request.setAttribute(IRequestAttribute.PRODUCT_GROUP_LIST, productGroupMapDTOs);
			logger.info("PRODUCT_GROUP_LIST="+productGroupMapDTOs);
			IProductService productService = new ProductServiceImpl();
			List<ProductMasterDTO> prMasterDTOs = productService.listProduct();
			request.setAttribute(IRequestAttribute.PRODUCT_LIST, prMasterDTOs);
		} catch (OperationFailedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		RequestDispatcher rd=request.getRequestDispatcher("/pages/productSales.jsp");
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String requestType=request.getParameter("requestType");
		if(requestType!=null&& requestType.equals("addItem")){
			addItem(request,response);
		}else {
			doGet(request,response);
		}
	}
	
	protected void addItem(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try{
			SaleItemDTO saleItemDTO = new SaleItemDTO();
			BeanUtils.populate(saleItemDTO, request.getParameterMap());
			String productMasterId=request.getParameter("productMasterId");
			int masterId=Integer.parseInt(productMasterId);
			IProductService productService=new ProductServiceImpl();
			ProductMasterDTO productMasterDTO=productService.loadProductMaster(masterId);
			
			saleItemDTO.setProductMaster(productMasterDTO);
			HttpSession session = request.getSession(true);
			List<SaleItemDTO> saleItemDTOs=(List<SaleItemDTO>) session.getAttribute(ISessionAttribute.SALE_ITEM_LIST);
			if(saleItemDTOs!=null){
				saleItemDTOs.add(saleItemDTO);
			}else {
				saleItemDTOs=new ArrayList<SaleItemDTO>();
				saleItemDTOs.add(saleItemDTO);
			}
			session.setAttribute(ISessionAttribute.SALE_ITEM_LIST,saleItemDTOs);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		RequestDispatcher rd=request.getRequestDispatcher("/pages/template/orderedItem.jsp");
		rd.forward(request, response);
	}

}
