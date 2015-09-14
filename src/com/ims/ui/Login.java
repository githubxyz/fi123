package com.ims.ui;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ims.dto.UserDTO;
import com.ims.exception.OperationFailedException;
import com.ims.service.userService.IUserService;
import com.ims.service.userService.UserServiceImpl;
import com.ims.utility.ISessionAttribute;

/**
 * Servlet implementation class Login
 */
@WebServlet("/login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
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
		RequestDispatcher requestDispatcher1 = request.getRequestDispatcher("./pages/dashboard.jsp");
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
		UserDTO uDTO = new UserDTO();
		uDTO.setUserName(login1);
		uDTO.setPassword(password);
		IUserService IUS = new UserServiceImpl();
		try {
			UserDTO result = null;
			result = IUS.isValidLoginCradential(uDTO);
			if(result==null)
			{
				RequestDispatcher requestDispatcher1 = request.getRequestDispatcher("/failure.jsp");
                requestDispatcher1.forward(request, response);
			}
			else
			{				
				s.setAttribute(ISessionAttribute.LOGGEDINUSER, result);
				RequestDispatcher requestDispatcher1 = request.getRequestDispatcher("./pages/dashboard.jsp");
                requestDispatcher1.forward(request, response);
			}
		} catch (OperationFailedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	//request.getSession().setAttribute(ISessionAttribute.LOGGEDINUSER, uDTO);
	}
}
