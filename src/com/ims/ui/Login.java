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

import org.apache.log4j.Logger;

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
 * Servlet implementation class Login
 */
@WebServlet("/login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Logger logger = Logger.getLogger("com.biz");  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		IStockAlartService alartService=new StockAlartServicesImpl();
		try {
			 List<StockDetailDTO> list=alartService.getLowStockProduct();
			 request.setAttribute(IRequestAttribute.LOWALART_LIST, list);
			 List<StockDetailDTO> hlist=alartService.getHighStockProduct();
			 request.setAttribute(IRequestAttribute.HIGHALART_LIST, hlist);
		} catch (Exception e) {
			// TODO: handle exception
		}
		RequestDispatcher requestDispatcher1 = request.getRequestDispatcher("pages/dashboard.jsp");
        requestDispatcher1.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession s = request.getSession(true);
        String login1 = request.getParameter("login1");
        String password = request.getParameter("password");
        String branchIdString=request.getParameter("branchId");
        logger.info("branchId="+branchIdString);
        int branchId=0;
        if(branchIdString!=null){
        	branchIdString=branchIdString.trim();
        	branchId=Integer.parseInt(branchIdString);
        }
        
		UserDTO uDTO = new UserDTO();
		uDTO.setUserName(login1);
		uDTO.setPassword(password);
		IUserService IUS = new UserServiceImpl();
		try {
			UserDTO result = null;
			result = IUS.isValidLoginCradential(uDTO);
			if(result==null)
			{
				RequestDispatcher requestDispatcher1 = request.getRequestDispatcher("/login.jsp");
                requestDispatcher1.forward(request, response);
			}
			else
			{		
				s.setAttribute(ISessionAttribute.LOGGEDINUSER, result);
				s.setAttribute(ISessionAttribute.LOGGEDIN_USER_BRANCHID, branchId);
				doGet(request, response);
			}
		} catch (OperationFailedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	//request.getSession().setAttribute(ISessionAttribute.LOGGEDINUSER, uDTO);
	}
}
