package com.ims.test;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.junit.Before;
import org.junit.Test;

import com.ims.dto.UserDTO;
import com.ims.persistence.hibernate.IPersistenceManager;
import com.ims.persistence.hibernate.PersistenceException;
import com.ims.persistence.hibernate.PersistenceManagerImpl;

import junit.framework.TestCase;

public class UserTest  {
	public Session ses=null;
	private static Logger logger = Logger.getLogger("com.biz");
	//@Before
	/*public void createSession() {

		 IPersistenceManager per=new PersistenceManagerImpl();
		 try {
			 ses= per.openSessionAndBeginTransaction();
		} catch (PersistenceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
*/	@Test
    public void testCompanytechexp() {
		System.out.println("hgjhokt");
		logger.info("entry...");
		UserDTO user=(UserDTO)ses.load(UserDTO.class, 1);
		System.out.println(user);
    }

}
