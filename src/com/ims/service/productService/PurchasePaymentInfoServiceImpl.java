package com.ims.service.productService;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.ims.dto.ProductGroupMapDTO;
import com.ims.dto.PurchasePaymentInfoDTO;
import com.ims.exception.OperationFailedException;
import com.ims.exception.ValidationException;
import com.ims.persistence.hibernate.IPersistenceManager;
import com.ims.persistence.hibernate.PersistenceManagerImpl;
import com.ims.persistence.hibernate.dao.IProductGroupMapDAO;
import com.ims.persistence.hibernate.dao.IProductMasterDAO;
import com.ims.persistence.hibernate.dao.IPurchasePaymentInfoDAO;
import com.ims.persistence.hibernate.dao.ProductGroupMapDAOImpl;
import com.ims.persistence.hibernate.dao.ProductMasterDAOImpl;
import com.ims.persistence.hibernate.dao.PurchasePaymentInfoDAOImpl;

public class PurchasePaymentInfoServiceImpl implements IPurchasePaymentService {
	private static Logger logger = Logger.getLogger("com.biz");

	@Override
	public List<PurchasePaymentInfoDTO> searchVendorDetail(Date fromDate, Date toDate, String billNo)
			throws OperationFailedException, ValidationException {
		logger.info("ENTRY....");
		// create a session
		Session session = null;
		// create PersistenceManagerImpl
		IPersistenceManager impl = new PersistenceManagerImpl();
		List<PurchasePaymentInfoDTO> paymentInfoDTOs=new ArrayList<>();
		try {
			
			
			session = impl.openSessionAndBeginTransaction();
			IPurchasePaymentInfoDAO dao=new PurchasePaymentInfoDAOImpl(session);
			paymentInfoDTOs=dao.getVendorList(fromDate, toDate, billNo);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
			if(e instanceof ValidationException)
				throw (ValidationException) e;
			

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
	

		return paymentInfoDTOs;
	}

	@Override
	public PurchasePaymentInfoDTO saveVendorDetail(PurchasePaymentInfoDTO pInfoDTO)
			throws OperationFailedException, ValidationException {
		logger.info("ENTRY....");
		PurchasePaymentInfoDTO paymentInfoSaved=null;
		// create a session
		Session session = null;
		// create PersistenceManagerImpl
		IPersistenceManager impl = new PersistenceManagerImpl();
		Collection errorCodes=new ArrayList();
		try {
			
			
			session = impl.openSessionAndBeginTransaction();
			IPurchasePaymentInfoDAO dao=new PurchasePaymentInfoDAOImpl(session);
			paymentInfoSaved=dao.savePaymentInfo(pInfoDTO);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
			if(e instanceof ValidationException)
				throw (ValidationException) e;
			else{
				errorCodes.add("Product name or product code already exist");
				throw new ValidationException(errorCodes);
			}

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
		return paymentInfoSaved;
	}

}
