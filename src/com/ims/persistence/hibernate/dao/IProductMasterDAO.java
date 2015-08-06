package com.ims.persistence.hibernate.dao;

import com.ims.dto.ProductMasterDTO;
import com.ims.persistence.hibernate.PersistenceException;

public interface IProductMasterDAO {
public ProductMasterDTO saveProductMaster(ProductMasterDTO productMasterDTO)throws PersistenceException;
public ProductMasterDTO getProductMaster(int id) throws PersistenceException;
public ProductMasterDTO updateProductMaster(ProductMasterDTO productMasterDTO) throws PersistenceException;	
}
