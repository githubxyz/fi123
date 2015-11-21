package com.ims.persistence.hibernate.dao;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;

import com.ims.dto.ProductGroupMapDTO;
import com.ims.dto.ProductMasterDTO;
import com.ims.exception.IPersistenceErrorCode;
import com.ims.persistence.hibernate.PersistenceException;

public class ProductMasterDAOImpl implements IProductMasterDAO {

	private Logger logger = Logger.getLogger("com.biz");

	private Session session;

	public ProductMasterDAOImpl(Session session) {

		this.session = session;
	}
	@Override
	public ProductMasterDTO saveProductMaster(ProductMasterDTO productMasterDTO) throws PersistenceException {
		// TODO Auto-generated method stub
		logger.info("Entry");
		logger.info("ProductMasterDTO ="+productMasterDTO);
		try {
			session.saveOrUpdate(productMasterDTO);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
			throw new PersistenceException(e,
					IPersistenceErrorCode.DATABASE_PROBLEM);
		}
		
		logger.info("Exit");
		return productMasterDTO;
	}

	@Override
	public ProductMasterDTO getProductMaster(int id) throws PersistenceException {
		// TODO Auto-generated method stub
		ProductMasterDTO pm=null;
		try {
			pm=(ProductMasterDTO) session.load(ProductMasterDTO.class, id);
			logger.info(pm);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return pm;
	}

	@Override
	public ProductMasterDTO updateProductMaster(ProductMasterDTO productMasterDTO) throws PersistenceException {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public List<ProductMasterDTO> listProductMaster() throws PersistenceException {
		// TODO Auto-generated method stub
				logger.info("Entry");
				List<ProductMasterDTO> list=null;
				try {
					
					Criteria q=session.createCriteria(ProductMasterDTO.class);
					list=q.list();
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
