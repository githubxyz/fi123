package com.ims.persistence.hibernate.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

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
	@Override
	public List<PurchasePaymentInfoDTO> getVendorList(Date fromDate, Date toDate,String billNo) throws PersistenceException {
		// TODO Auto-generated method stub
		List<PurchasePaymentInfoDTO> infoDTOs=new ArrayList<>();
		logger.info("entry");
		try{
			Criteria orderCrit = session.createCriteria(PurchasePaymentInfoDTO.class, "MASTER");
			//orderCrit.add(Restrictions.between("invoiceStartDate",));
			if(billNo!=null && (!billNo.trim().equals(""))){
				orderCrit.add(Restrictions.eq("billNo", billNo.trim().toUpperCase()));
			}
			infoDTOs=orderCrit.list();
			
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e);
			throw new PersistenceException(e,
					IPersistenceErrorCode.DATABASE_PROBLEM);
		}
		
		logger.info("Exit");
		return infoDTOs;
	}

}
