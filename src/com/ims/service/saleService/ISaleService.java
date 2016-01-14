package com.ims.service.saleService;

import java.util.Date;
import java.util.List;

import com.ims.dto.BuyerDTO;
import com.ims.dto.SaleItemDTO;
import com.ims.dto.SaleMasterDTO;
import com.ims.dto.UserDTO;
import com.ims.exception.OperationFailedException;
import com.ims.exception.ValidationException;

public interface ISaleService {
	public SaleMasterDTO saveSaleingDetail(SaleMasterDTO saleMasterDTO,BuyerDTO buyerDTO,List<SaleItemDTO> items) throws OperationFailedException,ValidationException	;
	
	public List<SaleMasterDTO> searchSaleRecord(UserDTO searchBy,UserDTO searchFor,String billNo,Date fromDate,Date toDate) throws OperationFailedException,ValidationException	;

}
