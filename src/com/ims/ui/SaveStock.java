package com.ims.ui;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.Date;
import java.util.List;

import javax.mail.Session;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.log4j.Logger;

import com.ims.dto.ProductDetailDTO;
import com.ims.dto.ProductGroupMapDTO;
import com.ims.dto.ProductMasterDTO;
import com.ims.dto.PurchasePaymentInfoDTO;
import com.ims.dto.UserDTO;
import com.ims.exception.OperationFailedException;
import com.ims.persistence.hibernate.dao.IProductDetailDAO;
import com.ims.persistence.hibernate.dao.ProductDetailDAOImpl;
import com.ims.service.productService.IProductDetailService;
import com.ims.service.productService.IProductService;
import com.ims.service.productService.ProductDetailServiceImpl;
import com.ims.service.productService.ProductServiceImpl;
import com.ims.utility.IRequestAttribute;
import com.ims.utility.ISessionAttribute;

/**
 * Servlet implementation class saveStock
 */
public class SaveStock extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Logger logger = Logger.getLogger("com.biz");

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SaveStock() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void editProductDetails(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("/pages/template/editProductDetails.jsp");
		logger.info("in editProduct");
		try {
			IProductDetailService productDetailService = new ProductDetailServiceImpl();
			int id = Integer.parseInt(request.getParameter("id").trim());
			ProductDetailDTO list = productDetailService.loadProductDetails(id);
			request.setAttribute(IRequestAttribute.PRODUCT_DETAILS_LIST_BY_ID, list);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void PopulateType(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		logger.info("Populate data");
		String prodIdStr = (String) request.getParameter("productId");
		int productId = 0;
		logger.info("Populate data-->>"+prodIdStr);
		try {
			productId = Integer.parseInt(prodIdStr);
			IProductService productService = new ProductServiceImpl();
			ProductMasterDTO productMasterDTO = productService.loadProductMaster(productId);
			logger.info("data get=" + productMasterDTO);
			request.setAttribute(IRequestAttribute.PRODUCT_MASTER, productMasterDTO);
		} catch (Exception e) {
			// TODO: handle exception
		}
		RequestDispatcher rd = request.getRequestDispatcher("/pages/template/productType.jsp");
		rd.forward(request, response);

	}

	protected void PopulateEdit(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		logger.info("PopulateEdit Data");
		
		String prodIdStr = (String) request.getParameter("id");
		int productDeatilsId = 0;
		try {
			productDeatilsId = Integer.parseInt(prodIdStr);
			IProductDetailService productDetailService = new ProductDetailServiceImpl();
			ProductDetailDTO productDetailDTO = productDetailService.loadProductDetails(productDeatilsId);
			logger.info("data get=" + productDetailDTO);
			request.setAttribute(IRequestAttribute.PRODUCT_DETAILS_LIST_BY_ID, productDetailDTO);
		} catch (Exception e) {
			// TODO: handle exception
		}

		IProductService productService = new ProductServiceImpl();
		IProductDetailService detailService = new ProductDetailServiceImpl();

		try {
			List<ProductMasterDTO> prMasterDTOs = productService.listProduct();
			List<ProductGroupMapDTO> productGroupMapDTOs = detailService.getProductGroupCodeLists();
			request.setAttribute(IRequestAttribute.PRODUCT_LIST, prMasterDTOs);
			request.setAttribute(IRequestAttribute.PRODUCT_GROUP_LIST, productGroupMapDTOs);

			ProductDetailDTO pd = new ProductDetailDTO();
			BeanUtils.populate(pd, request.getParameterMap());
			IProductDetailService productDetailService = new ProductDetailServiceImpl();
			HttpSession session = request.getSession(true);
			int branchId = (int) session.getAttribute(ISessionAttribute.LOGGEDIN_USER_BRANCHID);
			if (pd != null)
				productDetailService.listOfPurchase(branchId);
			List<ProductDetailDTO> list = productDetailService.listOfPurchase(branchId);
			request.setAttribute(ISessionAttribute.PURCHASE_LIST, list);

		} catch (OperationFailedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		String prodIdStr1 = (String) request.getParameter("productDetailsId");
		int productId = 0;
		try {
			productId = Integer.parseInt(prodIdStr);
			IProductService productService1 = new ProductServiceImpl();
			ProductMasterDTO productMasterDTO = productService1.loadProductMaster(productId);
			logger.info("data get=" + productMasterDTO);
			request.setAttribute(IRequestAttribute.PRODUCT_MASTER, productMasterDTO);
		} catch (Exception e) {
			// TODO: handle exception
		}
		//rd.forward(request, response);
		RequestDispatcher rd = request.getRequestDispatcher("/pages/template/editProductDetails.jsp");
		rd.forward(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		IProductService productService = new ProductServiceImpl();
		IProductDetailService detailService = new ProductDetailServiceImpl();

		try {
			List<ProductMasterDTO> prMasterDTOs = productService.listProduct();
			List<ProductGroupMapDTO> productGroupMapDTOs = detailService.getProductGroupCodeLists();
			request.setAttribute(IRequestAttribute.PRODUCT_LIST, prMasterDTOs);
			request.setAttribute(IRequestAttribute.PRODUCT_GROUP_LIST, productGroupMapDTOs);

			ProductDetailDTO pd = new ProductDetailDTO();
			BeanUtils.populate(pd, request.getParameterMap());
			IProductDetailService productDetailService = new ProductDetailServiceImpl();
			HttpSession session = request.getSession(true);
			int branchId = (int) session.getAttribute(ISessionAttribute.LOGGEDIN_USER_BRANCHID);
			if (pd != null)
				productDetailService.listOfPurchase(branchId);
			List<ProductDetailDTO> list = productDetailService.listOfPurchase(branchId);
			request.setAttribute(ISessionAttribute.PURCHASE_LIST, list);

		} catch (OperationFailedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		RequestDispatcher rd = request.getRequestDispatcher("/pages/enterStock.jsp");
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ProductDetailDTO productDetailDTO = new ProductDetailDTO();
		logger.info("in........" + request.getParameter("selectType"));
		if (request.getParameter("selectType") != null && request.getParameter("selectType").toString().length() > 0) {
			PopulateType(request, response);
		} else if (request.getParameter("editProductDetails") != null
				&& request.getParameter("editProductDetails").toString().length() > 0) {
			PopulateEdit(request, response);

		} else {
			boolean error = false;
			try {
				int productId = Integer.parseInt(request.getParameter("prodId"));
				ProductMasterDTO pm = new ProductMasterDTO();
				pm.setId(productId);
				BeanUtils.populate(productDetailDTO, request.getParameterMap());
				String billno = request.getParameter("billrefid");
				PurchasePaymentInfoDTO paymentInfoDTO = new PurchasePaymentInfoDTO();
				paymentInfoDTO.setBillNo(billno);
				productDetailDTO.setPurchaseRef(paymentInfoDTO);

				productDetailDTO.setProductMaster(pm);
				// Todo set the branchId from session parameter
				HttpSession session = request.getSession(true);
				int branchId = (int) session.getAttribute(ISessionAttribute.LOGGEDIN_USER_BRANCHID);
				productDetailDTO.setBranch(branchId);
				UserDTO user = new UserDTO();
				user.setId(1);
				productDetailDTO.setUser(user);
				productDetailDTO.setPurchaseDate(new Date());
				IProductService productService = new ProductServiceImpl();
				productService.saveProductDetail(productDetailDTO);
				List<ProductMasterDTO> prMasterDTOs = productService.listProduct();
				request.setAttribute(IRequestAttribute.PRODUCT_LIST, prMasterDTOs);
				request.setAttribute("msg", "The value saved successfully");
			} catch (Exception e) {
				error = true;
				e.printStackTrace();
			}
			if (error) {
				response.getWriter().append("error to save: " + productDetailDTO).append(request.getContextPath());
			} else {

				doGet(request, response);
			}
		}

	}

}
