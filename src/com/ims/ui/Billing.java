package com.ims.ui;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.ws.RequestWrapper;

//import org.apache.catalina.connector.Request;

import com.ims.dto.StockDetailDTO;
import com.ims.dto.UserDTO;
import com.ims.exception.OperationFailedException;
import com.ims.service.stockAlartService.IStockAlartService;
import com.ims.service.stockAlartService.StockAlartServicesImpl;
import com.ims.service.userService.IUserService;
import com.ims.service.userService.UserServiceImpl;
import com.ims.utility.IRequestAttribute;
import com.ims.utility.ISessionAttribute;

/**
 * Servlet implementation class Billing
 */
@WebServlet("/billing")
public class Billing extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Billing() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		RequestDispatcher requestDispatcher1 = request.getRequestDispatcher("/pages/billing.jsp");
        requestDispatcher1.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
			
				RequestDispatcher requestDispatcher1 = request.getRequestDispatcher("/pages/billing.jsp");
                requestDispatcher1.forward(request, response);
			
		} 
	//request.getSession().setAttribute(ISessionAttribute.LOGGEDINUSER, uDTO);
	}

