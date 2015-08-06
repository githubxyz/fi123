package com.ims.persistence.hibernate.dao;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.ims.dto.ProductDetailDTO;
import com.ims.dto.ProductMasterDTO;
import com.ims.exception.IPersistenceErrorCode;
import com.ims.persistence.hibernate.PersistenceException;

public class ProductDetailDAOImpl implements IProductDetailDAO {
	
	private Logger logger = Logger.getLogger("com.biz");

	private Session session;

	public ProductDetailDAOImpl(Session session) {

		this.session = session;
	}
	@Override
	public ProductDetailDTO saveProductDetail(ProductDetailDTO productDetailDTO) throws PersistenceException {
		logger.info("Entry");
		logger.info("ProductDetailDTO ="+productDetailDTO);
		try {
			session.saveOrUpdate(productDetailDTO);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
			throw new PersistenceException(e,
					IPersistenceErrorCode.DATABASE_PROBLEM);
		}
		
		logger.info("Exit");
		return productDetailDTO;

	}

	@Override
	public ProductDetailDTO getProductDetail(int id) throws PersistenceException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ProductMasterDTO updateProductDetail(ProductMasterDTO productMasterDTO) throws PersistenceException {
		// TODO Auto-generated method stub
		return null;
	}

}
