package com.ims.service.userService;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.ims.dto.UserDTO;
import com.ims.exception.OperationFailedException;
import com.ims.persistence.hibernate.IPersistenceManager;
import com.ims.persistence.hibernate.PersistenceManagerImpl;
import com.ims.persistence.hibernate.dao.IProductMasterDAO;
import com.ims.persistence.hibernate.dao.IUserDAO;
import com.ims.persistence.hibernate.dao.ProductMasterDAOImpl;
import com.ims.persistence.hibernate.dao.UserDAOImpl;

public class UserServiceImpl implements IUserService {
	private static Logger logger = Logger.getLogger("com.biz");
	@Override
	public UserDTO getUserByUserName() throws OperationFailedException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public UserDTO isValidLoginCradential(UserDTO userDTO) throws OperationFailedException {
		logger.info("ENTRY....");
		// create a session
		Session session = null;
		// create PersistenceManagerImpl
		IPersistenceManager impl = new PersistenceManagerImpl();
		UserDTO userDTOfromDb=null;
		try {
			session = impl.openSessionAndBeginTransaction();
			IUserDAO userDAO=new UserDAOImpl(session);
			userDTOfromDb=userDAO.getUserByUserName(userDTO.getUserName());
			if(userDTOfromDb!=null && (userDTOfromDb.getPassword()!=null) && 
					(userDTOfromDb.getPassword().equals(userDTO.getPassword()))){
				logger.info("valid login cradential for userName="+userDTO.getUserName());
				
			}else{
				logger.info("Invalid login cradential for userName="+userDTO.getUserName());
				userDTOfromDb=null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
			throw new OperationFailedException();

		}finally {
			try {
				// close session
				impl.closeAndCommitSession();

			} catch (Exception e) {
				e.printStackTrace();
				throw new OperationFailedException();
			}
		}
		logger.info("Exit.........");
	

		return userDTOfromDb;
	}

}
