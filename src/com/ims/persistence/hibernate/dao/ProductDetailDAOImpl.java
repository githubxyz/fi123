package com.ims.persistence.hibernate.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import com.ims.dto.ProductDetailDTO;
import com.ims.dto.ProductMasterDTO;
import com.ims.dto.StockDetailDTO;
import com.ims.exception.IPersistenceErrorCode;
import com.ims.exception.OperationFailedException;
import com.ims.persistence.hibernate.IPersistenceManager;
import com.ims.persistence.hibernate.PersistenceException;
import com.ims.persistence.hibernate.PersistenceManagerImpl;

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
	public List<ProductDetailDTO> getProductDetail(int branchId) throws PersistenceException {
		// TODO Auto-generated method stub
		logger.info("Entry");
		List<ProductDetailDTO> productDetailDTOs=new ArrayList<ProductDetailDTO>();
		logger.info("find stock for branchId ="+branchId);
		try {
			Criteria criteria=session.createCriteria(ProductDetailDTO.class);
			criteria.add(Restrictions.eq("branch", branchId));
			productDetailDTOs=(List<ProductDetailDTO>)criteria.list();
			logger.info(productDetailDTOs);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
			throw new PersistenceException(e,
					IPersistenceErrorCode.DATABASE_PROBLEM);
		}
		
		logger.info("Exit");
		return productDetailDTOs;
		}

	@Override
	public ProductMasterDTO updateProductDetail(ProductMasterDTO productMasterDTO) throws PersistenceException {
		// TODO Auto-generated method stub
		return null;
	}

}
