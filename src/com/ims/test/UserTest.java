package com.ims.test;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.junit.Before;
import org.junit.Test;

import com.ims.dto.ProductMasterDTO;
import com.ims.dto.StockAlertDTO;
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
		IStockAlartService alert=new StockAlartServicesImpl();
		StockAlertDTO stockAlertDTO=new StockAlertDTO();
		 ProductMasterDTO pm = new ProductMasterDTO();
		 pm.setId(22);
		stockAlertDTO.setProductMaster(pm);
		stockAlertDTO.setMaxVal(44.00);
		stockAlertDTO.setMinVal(2.0);
		stockAlertDTO.setType(1);
		try {
			alert.saveStockAlert(stockAlertDTO);
			//System.out.println("stockAlertDTO="+stockAlertDTO);
		} catch (OperationFailedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

}
