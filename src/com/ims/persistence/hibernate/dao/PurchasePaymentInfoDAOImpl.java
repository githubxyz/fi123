package com.ims.persistence.hibernate.dao;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.ims.dto.ProductGroupMapDTO;
import com.ims.dto.PurchasePaymentInfoDTO;
import com.ims.exception.IPersistenceErrorCode;
import com.ims.persistence.hibernate.PersistenceException;

public class PurchasePaymentInfoDAOImpl implements IPurchasePaymentInfoDAO {
	private Logger logger = Logger.getLogger("com.biz");

	private Session session;
	public PurchasePaymentInfoDAOImpl(Session session){
		this.session=session;
	}
	@Override
	public PurchasePaymentInfoDTO savePaymentInfo(PurchasePaymentInfoDTO purchasePaymentInfoDTO)
			throws PersistenceException {
		logger.info("Entry");
		logger.info("PurchasePaymentInfoDTO ="+purchasePaymentInfoDTO);
		try {
			session.saveOrUpdate(purchasePaymentInfoDTO);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
			throw new PersistenceException(e,
					IPersistenceErrorCode.DATABASE_PROBLEM);
		}
		
		logger.info("Exit");
		return purchasePaymentInfoDTO;
	}

	@Override
	public PurchasePaymentInfoDTO getPaymentInfo(String billNo) throws PersistenceException {
		PurchasePaymentInfoDTO productGroupMapDTO=null;
		logger.info("Entry");
		try {
			if(billNo!=null)
				billNo=billNo.toUpperCase().trim();
			String sql="from PurchasePaymentInfoDTO  where billNo= :billNo";
			logger.info("billNo="+billNo);
			org.hibernate.Query q=session.createQuery(sql);
			q.setParameter("billNo", billNo);
			productGroupMapDTO=(PurchasePaymentInfoDTO)q.uniqueResult();
			logger.info(productGroupMapDTO);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
			throw new PersistenceException(e,
					IPersistenceErrorCode.DATABASE_PROBLEM);
		}
		
		logger.info("Exit");
		return productGroupMapDTO;

	}

}
