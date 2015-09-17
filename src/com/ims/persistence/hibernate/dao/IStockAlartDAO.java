package com.ims.persistence.hibernate.dao;

import java.util.List;

import com.ims.dto.ProductMasterDTO;
import com.ims.dto.StockAlertDTO;
import com.ims.persistence.hibernate.PersistenceException;

public interface IStockAlartDAO {
public StockAlertDTO saveStoclAlart(StockAlertDTO stockAlertDTO)throws PersistenceException;
public List<StockAlertDTO> listStockAlart() throws PersistenceException;
}
