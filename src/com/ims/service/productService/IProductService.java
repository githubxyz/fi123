package com.ims.service.productService;

import java.util.List;

import com.ims.dto.ProductDetailDTO;
import com.ims.dto.ProductGroupMapDTO;
import com.ims.dto.ProductMasterDTO;
import com.ims.exception.OperationFailedException;
import com.ims.exception.ValidationException;
import com.ims.persistence.hibernate.PersistenceException;

public interface IProductService {
	public ProductMasterDTO	 saveProduct(ProductMasterDTO productMasterDTO) throws OperationFailedException,ValidationException	;
	public ProductDetailDTO  saveProductDetail(ProductDetailDTO productDetailDTO)throws OperationFailedException ;
	public List<ProductMasterDTO> listProduct()throws OperationFailedException;
	public ProductMasterDTO loadProductMaster(int id)throws OperationFailedException;
	public ProductGroupMapDTO getProductGroupByCode(String code) throws OperationFailedException;
		
}
