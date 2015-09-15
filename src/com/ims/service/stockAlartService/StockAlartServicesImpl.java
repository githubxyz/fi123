package com.ims.service.stockAlartService;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.ims.dto.ProductDetailDTO;
import com.ims.dto.ProductMasterDTO;
import com.ims.dto.StockAlertDTO;
import com.ims.exception.OperationFailedException;
import com.ims.persistence.hibernate.IPersistenceManager;
import com.ims.persistence.hibernate.PersistenceException;
import com.ims.persistence.hibernate.PersistenceManagerImpl;
import com.ims.persistence.hibernate.dao.IProductDetailDAO;
import com.ims.persistence.hibernate.dao.IProductMasterDAO;
import com.ims.persistence.hibernate.dao.IStockAlartDAO;
import com.ims.persistence.hibernate.dao.ProductDetailDAOImpl;
import com.ims.persistence.hibernate.dao.ProductMasterDAOImpl;
import com.ims.persistence.hibernate.dao.StockAlartDAOImpl;

public class StockAlartServicesImpl implements IStockAlartService {
	private static Logger logger = Logger.getLogger("com.biz");
/**
 * Save product master
 */
	public StockAlertDTO saveStockAlart(StockAlertDTO stockAlertDTO) throws OperationFailedException {
		// TODO Auto-generated method stub
		logger.info("ENTRY....");
		// create a session
		Session session = null;
		// create PersistenceManagerImpl
		IPersistenceManager impl = new PersistenceManagerImpl();
		
		try {
			session = impl.openSessionAndBeginTransaction();
			IStockAlartDAO stockAlartDAO=new StockAlartDAOImpl(session);
			stockAlartDAO.saveStoclAlart(stockAlertDTO);
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
	

		return stockAlertDTO;
	}

public List<StockAlertDTO> liStockAlertDTOs() throws OperationFailedException {
	logger.info("ENTRY....");
	List<StockAlertDTO> dtos=new ArrayList<StockAlertDTO>();
	// create a session
	Session session = null;
	// create PersistenceManagerImpl
	IPersistenceManager impl = new PersistenceManagerImpl();
	
	try {
		session = impl.openSessionAndBeginTransaction();
		IStockAlartDAO stockAlartDAO=new StockAlartDAOImpl(session);
		dtos=stockAlartDAO.listStockAlart();
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


	return dtos;


}

@Override
public StockAlertDTO saveStockAlert(StockAlertDTO stockAlertDTO) throws OperationFailedException {
	// TODO Auto-generated method stub
	return null;
}

@Override
public List<StockAlertDTO> listStockAlart() throws OperationFailedException {
	// TODO Auto-generated method stub
	return null;
}

}
