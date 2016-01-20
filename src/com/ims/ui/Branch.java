package com.ims.ui;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ims.dto.BranchDTO;
import com.ims.dto.ProductMasterDTO;
import com.ims.service.branchService.BranchServiceImpl;
import com.ims.service.branchService.IBranchService;
import com.ims.service.productService.IProductService;
import com.ims.service.productService.ProductServiceImpl;
import com.ims.utility.ISessionAttribute;

/**
 * Servlet implementation class Branch
 */
@WebServlet("/Branch")
public class Branch extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Branch() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			String branchlist=null;
			int branchId=Integer.parseInt(ISessionAttribute.LOGGEDIN_USER_BRANCHID);
			IBranchService branchService=new BranchServiceImpl();
			List<BranchDTO> list=(List<BranchDTO>) branchService.getBranchById(branchId);
			request.setAttribute(ISessionAttribute.BRANCH_LIST, branchlist);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
