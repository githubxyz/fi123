package com.ims.persistence.hibernate.dao;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.ims.dto.BranchDTO;
import com.ims.persistence.hibernate.PersistenceException;

public class BranchDAOImpl implements IBranchDAO{
	private Logger logger = Logger.getLogger("com.biz");

	private Session session;

	public BranchDAOImpl(Session session) {

		this.session = session;
	}

	@Override
	public BranchDTO getBranchDetail(int id) throws PersistenceException {
		// TODO Auto-generated method stub
				BranchDTO br=new BranchDTO();
				try {
					br=(BranchDTO) session.load(BranchDTO.class, id);
					logger.info(br);
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				return br;

	}
	}
