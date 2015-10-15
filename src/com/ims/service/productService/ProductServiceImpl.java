package com.ims.service.productService;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.ims.dto.ProductDetailDTO;
import com.ims.dto.ProductGroupMapDTO;
import com.ims.dto.ProductMasterDTO;
import com.ims.exception.OperationFailedException;
import com.ims.exception.ValidationException;
import com.ims.persistence.hibernate.IPersistenceManager;
import com.ims.persistence.hibernate.PersistenceException;
import com.ims.persistence.hibernate.PersistenceManagerImpl;
import com.ims.persistence.hibernate.dao.IProductDetailDAO;
import com.ims.persistence.hibernate.dao.IProductGroupMapDAO;
import com.ims.persistence.hibernate.dao.IProductMasterDAO;
import com.ims.persistence.hibernate.dao.ProductDetailDAOImpl;
import com.ims.persistence.hibernate.dao.ProductGroupMapDAOImpl;
import com.ims.persistence.hibernate.dao.ProductMasterDAOImpl;

public class ProductServiceImpl implements IProductService {
	private static Logger logger = Logger.getLogger("com.biz");
/**
 * Save product master
 */
	public ProductMasterDTO saveProduct(ProductMasterDTO productMasterDTO) throws OperationFailedException,ValidationException {
		// TODO Auto-generated method stub
		logger.info("ENTRY....");
		// create a session
		Session session = null;
		// create PersistenceManagerImpl
		IPersistenceManager impl = new PersistenceManagerImpl();
		Collection errorCodes=new ArrayList();
		try {
			
			if(productMasterDTO.getProductName()==null || productMasterDTO.getProductName().equals("")){
				errorCodes.add("Product name should not be empty");
			}
			if(productMasterDTO.getProductCode()==null || productMasterDTO.getProductCode().equals("")){
				errorCodes.add("Product code should not be empty");
			}
			if(errorCodes.size()>0){
				throw new ValidationException(errorCodes);
			}
			session = impl.openSessionAndBeginTransaction();
			IProductMasterDAO productMasterDAO=new ProductMasterDAOImpl(session);
			productMasterDAO.saveProductMaster(productMasterDTO);
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
@Override
public List<ProductMasterDTO> listProduct() throws OperationFailedException {
	logger.info("ENTRY....");
	List<ProductMasterDTO> dtos=new ArrayList<ProductMasterDTO>();
	// create a session
	Session session = null;
	// create PersistenceManagerImpl
	IPersistenceManager impl = new PersistenceManagerImpl();
	
	try {
		session = impl.openSessionAndBeginTransaction();
		IProductMasterDAO productMasterDAO=new ProductMasterDAOImpl(session);
		dtos=productMasterDAO.listProductMaster();
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
public ProductMasterDTO loadProductMaster(int id) throws OperationFailedException {
	logger.info("ENTRY....");
	ProductMasterDTO dtos=null;
	// create a session
	Session session = null;
	// create PersistenceManagerImpl
	IPersistenceManager impl = new PersistenceManagerImpl();
	
	try {
		session = impl.openSessionAndBeginTransaction();
		IProductMasterDAO productMasterDAO=new ProductMasterDAOImpl(session);
		dtos=productMasterDAO.getProductMaster(id);
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
public ProductGroupMapDTO getProductGroupByCode(String code) throws OperationFailedException {
	// TODO Auto-generated method stub
	logger.info("ENTRY....");
	ProductGroupMapDTO dto=null;
	// create a session
	Session session = null;
	// create PersistenceManagerImpl
	IPersistenceManager impl = new PersistenceManagerImpl();
	
	try {
		session = impl.openSessionAndBeginTransaction();
		IProductGroupMapDAO dao=new ProductGroupMapDAOImpl(session);
		dto=dao.getProductGroupByCode(code);
	} catch (Exception e) {
		// TODO: handle exception
	}finally {
		try {
			// close session
			impl.closeAndCommitSession();

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
			throw new OperationFailedException();

		}

	}
	return dto;
}

}
