package com.ims.service.productService;

import java.util.List;

import com.ims.dto.ProductDetailDTO;
import com.ims.dto.ProductGroupMapDTO;
import com.ims.dto.ProductMasterDTO;
import com.ims.exception.OperationFailedException;
import com.ims.persistence.hibernate.PersistenceException;

public interface IProductDetailService {
	public List<ProductDetailDTO> listOfPurchase(int branchcode)throws OperationFailedException;
	public List<ProductGroupMapDTO> getProductGroupCodeLists() throws OperationFailedException;
	public ProductDetailDTO loadProductDetails(int id)throws OperationFailedException;
}
