package com.ims.persistence.hibernate.dao;

import java.util.Date;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.ims.dto.SaleMasterDTO;
import com.ims.exception.IPersistenceErrorCode;
import com.ims.persistence.hibernate.PersistenceException;

public class SaleMasterDaoImpl implements ISaleMasterlDAO {
	
	private Logger logger = Logger.getLogger("com.biz");

	private Session session;
	
	public SaleMasterDaoImpl(Session session) {
		super();
		this.session = session;
	}

	@Override
	public SaleMasterDTO saveSellingDetail(SaleMasterDTO saleMasterDTO) throws PersistenceException {
		logger.info("entry...");
		logger.info("Save SaleMasterDTO="+saleMasterDTO);
		try {
			session.saveOrUpdate(saleMasterDTO);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			throw new PersistenceException(e,
					IPersistenceErrorCode.DATABASE_PROBLEM);
		}
		logger.info("exit");
		return saleMasterDTO;
	}

	@Override
	public SaleMasterDTO getSaleDetailByBillNo(String billNo) throws PersistenceException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public SaleMasterDTO getSaleByDate(Date fromDate, Date toDate) throws PersistenceException {
		// TODO Auto-generated method stub
		return null;
	}

}
