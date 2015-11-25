package com.ims.persistence.hibernate.dao;

import com.ims.dto.ProductDetailDTO;
import com.ims.dto.SaleItemDTO;
import com.ims.persistence.hibernate.PersistenceException;

public interface ISaleItemDAO {
	public SaleItemDTO saveSaledItem(SaleItemDTO saleItemDTO) throws PersistenceException;
}
