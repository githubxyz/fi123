package com.ims.ui;

import com.ims.dto.StockDetailDTO;
import com.ims.service.viewStock.IViewStockService;
import com.ims.service.viewStock.ViewStockServiceImpl;
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
//@WebServlet("/pages/ViewStock")
public class ViewStock extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ViewStock() {
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
		StockDetailDTO sd=new StockDetailDTO();
		boolean error=false;
		try {
			BeanUtils.populate(sd, request.getParameterMap());
			IViewStockService viewStockService=new ViewStockServiceImpl();
			if(sd!=null)
				viewStockService.getAllStockDetail(1);
			List<StockDetailDTO> list=viewStockService.getAllStockDetail(1);
			request.setAttribute("viewStockList", list);
			
		} catch (Exception e) {
			error=true;
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(error){
			response.getWriter().append("error to save: "+sd).append(request.getContextPath());
		}else{
		
		
		RequestDispatcher rd=request.getRequestDispatcher("/pages/viewStockDetails.jsp");
		rd.forward(request, response);
		}
	}

}
