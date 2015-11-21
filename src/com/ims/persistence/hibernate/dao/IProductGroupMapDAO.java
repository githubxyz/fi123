package com.ims.persistence.hibernate.dao;

import java.util.List;

import com.ims.dto.ProductDetailDTO;
import com.ims.dto.ProductGroupMapDTO;
import com.ims.persistence.hibernate.PersistenceException;

public interface IProductGroupMapDAO {
	public ProductGroupMapDTO saveProductGroup(ProductGroupMapDTO productGroupMapDTO) throws PersistenceException;
	public ProductGroupMapDTO getProductGroupByCode(String code) throws PersistenceException;
	public List<ProductGroupMapDTO> getProductGroupCodeLists() throws PersistenceException;
}
