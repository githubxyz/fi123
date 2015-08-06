package com.ims.persistence.hibernate.dao;

import com.ims.dto.ProductDetailDTO;
import com.ims.dto.ProductMasterDTO;
import com.ims.persistence.hibernate.PersistenceException;

public interface IProductDetailDAO {

	public ProductDetailDTO saveProductDetail(ProductDetailDTO productDetailDTO) throws PersistenceException;

	public ProductDetailDTO getProductDetail(int id) throws PersistenceException;

	public ProductMasterDTO updateProductDetail(ProductMasterDTO productMasterDTO) throws PersistenceException;
}
