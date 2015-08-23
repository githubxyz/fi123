package com.ims.service.productService;

import java.util.List;

import com.ims.dto.ProductDetailDTO;
import com.ims.dto.ProductMasterDTO;
import com.ims.exception.OperationFailedException;

public interface IProductDetailService {
	public List<ProductDetailDTO> listOfPurchase(int branchcode)throws OperationFailedException;
}
