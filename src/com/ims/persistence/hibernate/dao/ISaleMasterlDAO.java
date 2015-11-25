package com.ims.persistence.hibernate.dao;

import java.util.Date;

import com.ims.dto.ProductDetailDTO;
import com.ims.dto.SaleMasterDTO;
import com.ims.persistence.hibernate.PersistenceException;

public interface ISaleMasterlDAO {
	public SaleMasterDTO saveSellingDetail(SaleMasterDTO saleMasterDTO) throws PersistenceException;
	public SaleMasterDTO getSaleDetailByBillNo(String billNo)throws PersistenceException;
	public SaleMasterDTO getSaleByDate(Date fromDate,Date toDate)throws PersistenceException;

}
