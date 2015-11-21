package com.ims.persistence.hibernate.dao;

import java.util.List;
import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;

import com.ims.dto.ProductMasterDTO;
import com.ims.dto.StockAlertDTO;
import com.ims.exception.IPersistenceErrorCode;
import com.ims.persistence.hibernate.PersistenceException;

public class StockAlartDAOImpl implements IStockAlartDAO {

	private static Logger logger = Logger.getLogger("com.biz");

	private Session session;

	public StockAlartDAOImpl(Session session) {

		this.session = session;
	}
	/*public StockAlertDTO  saveAlert(StockAlertDTO stockAlertDTO) throws PersistenceException {
		logger.info("Entry");
		logger.info("xyz ="+stockAlertDTO);
		try {
			session.saveOrUpdate(stockAlertDTO);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
			throw new PersistenceException(e,
					IPersistenceErrorCode.DATABASE_PROBLEM);
		}
		
		logger.info("Exit");
		return stockAlertDTO;

	}*/
	public StockAlertDTO saveStockAlart(StockAlertDTO stockAlertDTO) throws PersistenceException {
		// TODO Auto-generated method stub
		logger.info("Entry");
		logger.info("xyz ="+stockAlertDTO);
		try {
			session.saveOrUpdate(stockAlertDTO);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
			throw new PersistenceException(e,
					IPersistenceErrorCode.DATABASE_PROBLEM);
		}
		
		logger.info("Exit");
		return stockAlertDTO;
	}

	@Override
	public List<StockAlertDTO> listStockAlart() throws PersistenceException {
		// TODO Auto-generated method stub
				logger.info("Entry");
				List<StockAlertDTO> list=null;
				try {
					
					Criteria q=session.createCriteria(StockAlertDTO.class);
					list=q.list();
				} catch (Exception e) {
					e.printStackTrace();
					logger.error(e);
					throw new PersistenceException(e,
							IPersistenceErrorCode.DATABASE_PROBLEM);
				}
				
				logger.info("Exit");
			
		return list;
	}
	
	public StockAlertDTO getStockAlart(int productId,int type) throws PersistenceException {
		// TODO Auto-generated method stub
		StockAlertDTO stockAlertDTO=null;
		logger.info("Entry");
		logger.info("xyz ="+stockAlertDTO);
		try {
			String sql="FROM StockAlertDTO s where s.productMaster.id=:productId and s.type=:type";
			org.hibernate.Query q=session.createQuery(sql);
			q.setParameter("productId", productId);
			q.setParameter("type", type);
			stockAlertDTO=(StockAlertDTO)q.uniqueResult();
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
			throw new PersistenceException(e,
					IPersistenceErrorCode.DATABASE_PROBLEM);
		}
		
		logger.info("Exit");
		return stockAlertDTO;
	}
}
