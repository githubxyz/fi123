package com.ims.service.productService;

import com.ims.dto.ProductDetailDTO;
import com.ims.dto.ProductMasterDTO;
import com.ims.exception.OperationFailedException;

public interface IProductService {
	public ProductMasterDTO	 saveProduct(ProductMasterDTO productMasterDTO) throws OperationFailedException	;
	public ProductDetailDTO  saveProductDetail(ProductDetailDTO productDetailDTO)throws OperationFailedException ;
		
}
