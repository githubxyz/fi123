package com.ims.service.stockAlartService;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.ims.dto.ProductDetailDTO;
import com.ims.dto.ProductMasterDTO;
import com.ims.dto.StockAlertDTO;
import com.ims.dto.StockDetailDTO;
import com.ims.exception.OperationFailedException;
import com.ims.persistence.hibernate.IPersistenceManager;
import com.ims.persistence.hibernate.PersistenceException;
import com.ims.persistence.hibernate.PersistenceManagerImpl;
import com.ims.persistence.hibernate.dao.IProductDetailDAO;
import com.ims.persistence.hibernate.dao.IProductMasterDAO;
import com.ims.persistence.hibernate.dao.IStockAlartDAO;
import com.ims.persistence.hibernate.dao.IStockDetailDAO;
import com.ims.persistence.hibernate.dao.ProductDetailDAOImpl;
import com.ims.persistence.hibernate.dao.ProductMasterDAOImpl;
import com.ims.persistence.hibernate.dao.StockAlartDAOImpl;
import com.ims.persistence.hibernate.dao.StockDetailDAOImpl;

public class StockAlartServicesImpl implements IStockAlartService {
	private static Logger logger = Logger.getLogger("com.biz");

	/**
	 * Save product master
	 */
	public StockAlertDTO saveStockAlert(StockAlertDTO stockAlertDTO) throws OperationFailedException {
		// TODO Auto-generated method stub
		logger.info("ENTRY....");
		// create a session
		Session session = null;
		// create PersistenceManagerImpl
		IPersistenceManager impl = new PersistenceManagerImpl();

		try {
			session = impl.openSessionAndBeginTransaction();
			StockAlartDAOImpl stockAlartDAO = new StockAlartDAOImpl(session);
			stockAlartDAO.saveAlert(stockAlertDTO);
			logger.info("saving=" + stockAlertDTO);
			stockAlartDAO.saveStoclAlart(stockAlertDTO);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
			throw new OperationFailedException();

		} finally {
			try {
				// close session
				impl.closeAndCommitSession();
				logger.info("commit");
			} catch (Exception e) {
				e.printStackTrace();
				logger.info("ff");
				throw new OperationFailedException();
			}
		}
		logger.info("Exit.........");

		return stockAlertDTO;
	}

	public List<StockAlertDTO> listStockAlart() throws OperationFailedException {
		logger.info("ENTRY....");
		List<StockAlertDTO> dtos = new ArrayList<StockAlertDTO>();
		// create a session
		Session session = null;
		// create PersistenceManagerImpl
		IPersistenceManager impl = new PersistenceManagerImpl();

		try {
			session = impl.openSessionAndBeginTransaction();
			IStockAlartDAO stockAlartDAO = new StockAlartDAOImpl(session);
			dtos = stockAlartDAO.listStockAlart();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
			throw new OperationFailedException();

		} finally {
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
	public List<StockDetailDTO> getLowStockProduct() throws OperationFailedException {
		List<StockDetailDTO> stockDetails=new ArrayList<>();
		List<StockDetailDTO> lowStocks=new ArrayList<>();
		Session session = null;
		// create PersistenceManagerImpl
		IPersistenceManager impl = new PersistenceManagerImpl();

		try {
			session = impl.openSessionAndBeginTransaction();
			IStockDetailDAO detailDAO=new StockDetailDAOImpl(session);
			stockDetails=detailDAO.getStockForAlertCheck();
			IStockAlartDAO stockAlartDAO=new StockAlartDAOImpl(session);
			List<StockAlertDTO> stockAlerts=stockAlartDAO.listStockAlart();
			for(Iterator it=stockAlerts.iterator();it.hasNext();){
				StockAlertDTO stockAlertDTO=(StockAlertDTO) it.next();
				for(Iterator stocDetIt=stockDetails.iterator();stocDetIt.hasNext();){
					StockDetailDTO stockDetailDTO=(StockDetailDTO) stocDetIt.next();
					if(stockAlertDTO.getProductMaster().getId()==stockDetailDTO.getProductMaster().getId()){
						if(stockDetailDTO.getUnitOfMesure()==1||stockDetailDTO.getUnitOfMesure()==3){
							if(stockDetailDTO.getWeight()<stockAlertDTO.getMinVal()){
								lowStocks.add(stockDetailDTO);
							}
						}else {
							if(stockDetailDTO.getQuantity()<stockAlertDTO.getMinVal()){
								lowStocks.add(stockDetailDTO);
							}
						}
					}
				}
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			throw new OperationFailedException();
		}
		return lowStocks;
	}

}
