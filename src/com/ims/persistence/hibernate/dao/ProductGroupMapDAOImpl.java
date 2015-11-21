package com.ims.persistence.hibernate.dao;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Session;

import com.ims.dto.ProductGroupMapDTO;
import com.ims.dto.ProductMasterDTO;
import com.ims.exception.IPersistenceErrorCode;
import com.ims.persistence.hibernate.PersistenceException;

public class ProductGroupMapDAOImpl implements IProductGroupMapDAO {
	private Logger logger = Logger.getLogger("com.biz");

	private Session session;

	public ProductGroupMapDAOImpl(Session session) {

		this.session = session;
	}
	@Override
	public ProductGroupMapDTO saveProductGroup(ProductGroupMapDTO productGroupMapDTO) throws PersistenceException {
		logger.info("Entry");
		logger.info("ProductGroupMapDTO ="+productGroupMapDTO);
		try {
			session.saveOrUpdate(productGroupMapDTO);
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
	public ProductGroupMapDTO getProductGroupByCode(String code) throws PersistenceException {
		ProductGroupMapDTO productGroupMapDTO=null;
		logger.info("Entry");
		try {
			if(code!=null)
				code=code.toUpperCase().trim();
			String sql="from ProductGroupMapDTO  where code= :code";
			logger.info("code="+code);
			org.hibernate.Query q=session.createQuery(sql);
			q.setParameter("code", code);
			productGroupMapDTO=(ProductGroupMapDTO)q.uniqueResult();
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
	public List<ProductGroupMapDTO> getProductGroupCodeLists() throws PersistenceException {
		// TODO Auto-generated method stub
		List<ProductGroupMapDTO> list=null;
		logger.info("Entry");
		try {
			
			Criteria q=session.createCriteria(ProductGroupMapDTO.class);
			list=(List<ProductGroupMapDTO>)q.list();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
			throw new PersistenceException(e,
					IPersistenceErrorCode.DATABASE_PROBLEM);
		}
		
		logger.info("Exit");
	return list;
	}

}
