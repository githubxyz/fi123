package com.ims.persistence.hibernate.dao;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Query;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import com.ims.dto.ProductMasterDTO;
import com.ims.dto.StockDetailDTO;
import com.ims.dto.UserDTO;
import com.ims.exception.IPersistenceErrorCode;
import com.ims.persistence.hibernate.PersistenceException;

public class StockDetailDAOImpl implements IStockDetailDAO {
	private Logger logger = Logger.getLogger("com.biz");

	private Session session;

	public StockDetailDAOImpl(Session session) {

		this.session = session;
	}
	@Override
	public List<StockDetailDTO> getAllStockDetail(int branchId) throws PersistenceException {
		logger.info("Entry");
		List<StockDetailDTO> stockDetailDTOs=new ArrayList<StockDetailDTO>();
		logger.info("find stock for branchId ="+branchId);
		try {
			Criteria criteria=session.createCriteria(StockDetailDTO.class);
			criteria.add(Restrictions.eq("branchId", branchId));
			stockDetailDTOs=(List<StockDetailDTO>)criteria.list();
			logger.info(stockDetailDTOs);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
			throw new PersistenceException(e,
					IPersistenceErrorCode.DATABASE_PROBLEM);
		}
		
		logger.info("Exit");
		return stockDetailDTOs;
	}

	@Override
	public List<StockDetailDTO> getStockDetailOfProduct(ProductMasterDTO productMasterDTO, int branchId)
			throws PersistenceException {
		logger.info("Entry");
		List<StockDetailDTO> stockDetailDTOs=new ArrayList<StockDetailDTO>();
		logger.info("find stock for branchId ="+branchId +" productMasterDTO="+productMasterDTO);
		try {
			Criteria criteria=session.createCriteria(StockDetailDTO.class);
			criteria.add(Restrictions.eq("branchId", branchId));
			criteria.add(Restrictions.eq("productMaster", productMasterDTO));
			stockDetailDTOs=(List<StockDetailDTO>)criteria.list();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
			throw new PersistenceException(e,
					IPersistenceErrorCode.DATABASE_PROBLEM);
		}
		
		logger.info("Exit");
		return stockDetailDTOs;
	}
	@Override
	public List<StockDetailDTO> getStockForAlertCheck() throws PersistenceException {
		logger.info("Entry");
		List<StockDetailDTO> stockDetailDTOs=new ArrayList<StockDetailDTO>();
		try {
			String sql="from StockDetailDTO where productMaster.id in (select productMaster.id from StockAlertDTO)";
			org.hibernate.Query q=session.createQuery(sql);
			stockDetailDTOs=q.list();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
			throw new PersistenceException(e,
					IPersistenceErrorCode.DATABASE_PROBLEM);
		}
		
		logger.info("Exit");
		return stockDetailDTOs;
	}

}
