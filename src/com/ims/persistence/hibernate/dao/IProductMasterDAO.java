package com.ims.persistence.hibernate.dao;

import java.util.List;

import com.ims.dto.ProductMasterDTO;
import com.ims.persistence.hibernate.PersistenceException;

public interface IProductMasterDAO {
public ProductMasterDTO saveProductMaster(ProductMasterDTO productMasterDTO)throws PersistenceException;
public ProductMasterDTO getProductMaster(int id) throws PersistenceException;
public ProductMasterDTO updateProductMaster(ProductMasterDTO productMasterDTO) throws PersistenceException;	
public List<ProductMasterDTO> listProductMaster() throws PersistenceException;	
public List<ProductMasterDTO> listProductMasterByGroupId(int groupId) throws PersistenceException;
}
