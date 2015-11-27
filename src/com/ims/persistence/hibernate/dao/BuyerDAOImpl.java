package com.ims.persistence.hibernate.dao;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.ims.dto.BuyerDTO;
import com.ims.dto.ProductDetailDTO;
import com.ims.exception.IPersistenceErrorCode;
import com.ims.persistence.hibernate.PersistenceException;

public class BuyerDAOImpl {
	private Logger logger = Logger.getLogger("com.biz");

	private Session session;

	public BuyerDAOImpl(Session session) {

		this.session = session;
	}
	
	public BuyerDTO saveBuyerInfo(BuyerDTO buyerDTO) throws PersistenceException {
		logger.info("Entry");
		logger.info("buyerDTO ="+buyerDTO);
		try {
			session.saveOrUpdate(buyerDTO);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
			throw new PersistenceException(e,
					IPersistenceErrorCode.DATABASE_PROBLEM);
		}
		
		logger.info("Exit");
		return buyerDTO;

	}

}
