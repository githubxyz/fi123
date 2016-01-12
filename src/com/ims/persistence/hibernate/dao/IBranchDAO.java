
package com.ims.persistence.hibernate.dao;

import java.util.List;

import com.ims.dto.BranchDTO;
import com.ims.persistence.hibernate.PersistenceException;

public interface IBranchDAO {
	public BranchDTO getBranchDetail(int id) throws PersistenceException;

}
