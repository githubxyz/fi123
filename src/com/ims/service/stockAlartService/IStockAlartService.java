package com.ims.service.stockAlartService;

import java.util.List;

import com.ims.dto.ProductDetailDTO;
import com.ims.dto.ProductMasterDTO;
import com.ims.dto.StockAlertDTO;
import com.ims.dto.StockDetailDTO;
import com.ims.exception.OperationFailedException;

public interface IStockAlartService {
	public StockAlertDTO saveStockAlert(StockAlertDTO stockAlertDTO) throws OperationFailedException;
	public List<StockAlertDTO> listStockAlart()throws OperationFailedException;
	public List<StockDetailDTO> getLowStockProduct() throws OperationFailedException ;
		
}