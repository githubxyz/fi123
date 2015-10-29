package com.ims.persistence.hibernate.dao;

import java.util.List;

import com.ims.dto.ProductMasterDTO;
import com.ims.dto.StockDetailDTO;
import com.ims.persistence.hibernate.PersistenceException;

public interface IStockDetailDAO {
	public List<StockDetailDTO> getAllStockDetail(int branchId) throws PersistenceException;
	public List<StockDetailDTO> getStockDetailOfProduct(ProductMasterDTO productMasterDTO,int branchId) throws PersistenceException;
	public  List<StockDetailDTO> getStockForAlertCheck() throws PersistenceException;

}
