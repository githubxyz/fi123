package com.ims.service.productService;

import java.util.Date;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.ims.dto.ProductDetailDTO;
import com.ims.dto.ProductMasterDTO;
import com.ims.exception.OperationFailedException;
import com.ims.persistence.hibernate.IPersistenceManager;
import com.ims.persistence.hibernate.PersistenceException;
import com.ims.persistence.hibernate.PersistenceManagerImpl;
import com.ims.persistence.hibernate.dao.IProductDetailDAO;
import com.ims.persistence.hibernate.dao.IProductMasterDAO;
import com.ims.persistence.hibernate.dao.ProductDetailDAOImpl;
import com.ims.persistence.hibernate.dao.ProductMasterDAOImpl;

public class ProductServiceImpl implements IProductService {
	private static Logger logger = Logger.getLogger("com.biz");
/**
 * Save product master
 */
	public ProductMasterDTO saveProduct(ProductMasterDTO productMasterDTO) throws OperationFailedException {
		// TODO Auto-generated method stub
		logger.info("ENTRY....");
		// create a session
		Session session = null;
		// create PersistenceManagerImpl
		IPersistenceManager impl = new PersistenceManagerImpl();
		
		try {
			session = impl.openSessionAndBeginTransaction();
			IProductMasterDAO productMasterDAO=new ProductMasterDAOImpl(session);
			productMasterDAO.saveProductMaster(productMasterDTO);
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
	

		return productMasterDTO;
	}
@Override
public ProductDetailDTO saveProductDetail(ProductDetailDTO productDetailDTO) throws OperationFailedException {
	logger.info("ENTRY....");
	// create a session
	Session session = null;
	// create PersistenceManagerImpl
	IPersistenceManager impl = new PersistenceManagerImpl();
	
	try {
		session = impl.openSessionAndBeginTransaction();
		IProductDetailDAO productDetailDAO=new ProductDetailDAOImpl(session);
		if(productDetailDTO.getPurchaseDate()==null)
			productDetailDTO.setPurchaseDate(new Date());
		productDetailDAO.saveProductDetail(productDetailDTO);
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


	return productDetailDTO;

}

}
