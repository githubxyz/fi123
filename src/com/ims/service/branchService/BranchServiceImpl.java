package com.ims.service.branchService;

import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.ims.dto.BranchDTO;
import com.ims.dto.BuyerDTO;
import com.ims.dto.SaleItemDTO;
import com.ims.exception.OperationFailedException;
import com.ims.persistence.hibernate.IPersistenceManager;
import com.ims.persistence.hibernate.PersistenceManagerImpl;
import com.ims.persistence.hibernate.dao.BranchDAOImpl;
import com.ims.persistence.hibernate.dao.BuyerDAOImpl;
import com.ims.persistence.hibernate.dao.ISaleMasterlDAO;
import com.ims.persistence.hibernate.dao.SaleMasterDaoImpl;

public class BranchServiceImpl implements IBranchService{
	private static Logger logger = Logger.getLogger("com.biz");

	@Override
	public BranchDTO getBranchById() throws OperationFailedException {
		logger.info("ENTRY....");
		Session session = null;
		BranchDTO branchDTO = null;
		// create PersistenceManagerImpl
		IPersistenceManager impl = new PersistenceManagerImpl();
		try{
			session = impl.openSessionAndBeginTransaction();
			BranchDAOImpl branchDAOImpl = new BranchDAOImpl(session);
			branchDAOImpl.getBranchDetail(branchDTO.getId());							
		}
		catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			throw new OperationFailedException();
		}
		return branchDTO;
	}
}
