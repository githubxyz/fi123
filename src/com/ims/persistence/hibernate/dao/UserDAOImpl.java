package com.ims.persistence.hibernate.dao;

import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;

import com.ims.dto.UserDTO;
import com.ims.exception.IPersistenceErrorCode;
import com.ims.persistence.hibernate.PersistenceException;

public class UserDAOImpl implements IUserDAO {
	private Logger logger = Logger.getLogger("com.biz");
	private Session session;

	public UserDAOImpl(Session session) {

		this.session = session;
	}

	@Override
	public UserDTO saveUser(UserDTO userDTO) throws PersistenceException {
		// TODO Auto-generated method stub
				logger.info("Entry");
				logger.info("userDTO recived="+userDTO);
				try {
					session.saveOrUpdate(userDTO);
				} catch (Exception e) {
					e.printStackTrace();
					logger.error(e);
					throw new PersistenceException(e,
							IPersistenceErrorCode.DATABASE_PROBLEM);
				}
				
				logger.info("Exit");
				return userDTO;
	}
/**
 * Get user by userName
 * @param userId
 * @return
 * @throws PersistenceException
 */
	@Override
	public UserDTO getUserByUserName(String userId) throws PersistenceException {
		UserDTO userDTO=new UserDTO();
		logger.info("Entry");
		logger.info("userName recived="+userId);
		try {
			String sql="FROM UserDTO where userName=:userId";
			Query query = session.createQuery(sql);
			query.setParameter("userId", userId);
			userDTO=(UserDTO) query.uniqueResult();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
			throw new PersistenceException(e,
					IPersistenceErrorCode.DATABASE_PROBLEM);
		}
		
		logger.info("Exit");
		return userDTO;
	}

	@Override
	public UserDTO updateUser(UserDTO userDTO) throws PersistenceException {
		// TODO Auto-generated method stub
		return null;
	}

}
