package com.ims.service.saleService;

import com.ims.dto.SaleMasterDTO;
import com.ims.exception.OperationFailedException;
import com.ims.exception.ValidationException;

public interface ISaleService {
	public SaleMasterDTO saveSaleingDetail(SaleMasterDTO saleMasterDTO) throws OperationFailedException,ValidationException	;

}
