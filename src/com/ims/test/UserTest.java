package com.ims.test;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.junit.Before;
import org.junit.Test;

import com.ims.dto.ProductMasterDTO;
import com.ims.dto.StockAlertDTO;
import com.ims.dto.StockDetailDTO;
import com.ims.dto.UserDTO;
import com.ims.exception.OperationFailedException;
import com.ims.persistence.hibernate.IPersistenceManager;
import com.ims.persistence.hibernate.PersistenceException;
import com.ims.persistence.hibernate.PersistenceManagerImpl;
import com.ims.service.stockAlartService.IStockAlartService;
import com.ims.service.stockAlartService.StockAlartServicesImpl;

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
*/	
	@Test
    public void testCompanytechexp() {
		logger.info("hgjhokt");
		//logger.info("entry...");
		//UserDTO user=(UserDTO)ses.load(UserDTO.class, 1);
		//System.out.println(user);
		IStockAlartService alartService=new StockAlartServicesImpl();
		try {
			 List<StockDetailDTO> list=alartService.getLowStockProduct();
			 logger.info(list);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

}
