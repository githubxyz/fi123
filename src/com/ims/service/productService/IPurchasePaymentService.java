package com.ims.service.productService;

import java.util.Date;
import java.util.List;

import com.ims.dto.ProductMasterDTO;
import com.ims.dto.PurchasePaymentInfoDTO;
import com.ims.exception.OperationFailedException;
import com.ims.exception.ValidationException;

public interface IPurchasePaymentService {
	public PurchasePaymentInfoDTO loadByBillNo(String billNo)throws OperationFailedException,ValidationException	;
	public List<PurchasePaymentInfoDTO>	 searchVendorDetail(Date fromDate,Date toDate,String billNo) throws OperationFailedException,ValidationException	;
	public PurchasePaymentInfoDTO	 saveVendorDetail(PurchasePaymentInfoDTO pInfoDTO) throws OperationFailedException,ValidationException	;
}
