package com.ims.service.productService;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.ims.dto.ProductDetailDTO;
import com.ims.dto.ProductGroupMapDTO;
import com.ims.dto.StockDetailDTO;
import com.ims.exception.OperationFailedException;
import com.ims.persistence.hibernate.IPersistenceManager;
import com.ims.persistence.hibernate.PersistenceManagerImpl;
import com.ims.persistence.hibernate.dao.IProductDetailDAO;
import com.ims.persistence.hibernate.dao.IProductGroupMapDAO;
import com.ims.persistence.hibernate.dao.IStockDetailDAO;
import com.ims.persistence.hibernate.dao.ProductDetailDAOImpl;
import com.ims.persistence.hibernate.dao.ProductGroupMapDAOImpl;
import com.ims.persistence.hibernate.dao.StockDetailDAOImpl;

public class ProductDetailServiceImpl implements IProductDetailService {

	public List<ProductDetailDTO> listOfPurchase(int branchcode) throws OperationFailedException {
		Logger logger = Logger.getLogger("com.biz");
		// TODO Auto-generated method stub
		logger.info("ENTRY....");
		List<ProductDetailDTO> dtos = new ArrayList<ProductDetailDTO>();
		// create a session
		Session session = null;
		// create PersistenceManagerImpl
		IPersistenceManager impl = new PersistenceManagerImpl();

		try {
			session = impl.openSessionAndBeginTransaction();
			IProductDetailDAO productDetailDAO = new ProductDetailDAOImpl(session);
			dtos = productDetailDAO.getProductDetail(branchcode);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
			throw new OperationFailedException();

		} finally {
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
	public List<ProductGroupMapDTO> getProductGroupCodeLists() throws OperationFailedException {
		Logger logger = Logger.getLogger("com.biz");
		// TODO Auto-generated method stub
		logger.info("ENTRY....");
		List<ProductGroupMapDTO> dtos = new ArrayList<ProductGroupMapDTO>();
		// create a session
		Session session = null;
		// create PersistenceManagerImpl
		IPersistenceManager impl = new PersistenceManagerImpl();

		try {
			session = impl.openSessionAndBeginTransaction();
			IProductGroupMapDAO iProductGroupMapDAO = new ProductGroupMapDAOImpl(session);
			dtos = iProductGroupMapDAO.getProductGroupCodeLists();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e);
			throw new OperationFailedException();

		} finally {
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
}
