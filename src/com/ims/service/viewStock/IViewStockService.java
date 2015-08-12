package com.ims.service.viewStock;

import com.ims.dto.StockDetailDTO;
import com.ims.exception.OperationFailedException;

import java.util.List;

public interface IViewStockService {
	//public ProductMasterDTO	 saveProduct(ProductMasterDTO productMasterDTO) throws OperationFailedException	;
	//public ProductDetailDTO  saveProductDetail(ProductDetailDTO productDetailDTO)throws OperationFailedException ;
	//public List<StockDetailDTO> listViewStock()throws OperationFailedException;

	List<StockDetailDTO> getAllStockDetail(int branchcode) throws OperationFailedException;
}
