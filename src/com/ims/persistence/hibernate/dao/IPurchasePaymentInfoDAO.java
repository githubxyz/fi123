package com.ims.persistence.hibernate.dao;

import com.ims.dto.ProductGroupMapDTO;
import com.ims.dto.PurchasePaymentInfoDTO;
import com.ims.persistence.hibernate.PersistenceException;

public interface IPurchasePaymentInfoDAO {
	public PurchasePaymentInfoDTO savePaymentInfo(PurchasePaymentInfoDTO purchasePaymentInfoDTO) throws PersistenceException;
	public PurchasePaymentInfoDTO getPaymentInfo(String code) throws PersistenceException;
}
