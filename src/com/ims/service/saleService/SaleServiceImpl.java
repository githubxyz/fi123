package com.ims.service.saleService;

import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.ims.dto.BuyerDTO;
import com.ims.dto.SaleItemDTO;
import com.ims.dto.SaleMasterDTO;
import com.ims.exception.OperationFailedException;
import com.ims.exception.ValidationException;
import com.ims.persistence.hibernate.IPersistenceManager;
import com.ims.persistence.hibernate.PersistenceManagerImpl;
import com.ims.persistence.hibernate.dao.BuyerDAOImpl;
import com.ims.persistence.hibernate.dao.ISaleMasterlDAO;
import com.ims.persistence.hibernate.dao.SaleMasterDaoImpl;

public class SaleServiceImpl implements ISaleService {
	private static Logger logger = Logger.getLogger("com.biz");

	@Override
	public SaleMasterDTO saveSaleingDetail(SaleMasterDTO saleMasterDTO, BuyerDTO buyerDTO, List<SaleItemDTO> items)
			throws OperationFailedException, ValidationException {
		logger.info("ENTRY....");
		Session session = null;
		// create PersistenceManagerImpl
		IPersistenceManager impl = new PersistenceManagerImpl();
		try {
			session = impl.openSessionAndBeginTransaction();
			BuyerDAOImpl buyerDAOImpl = new BuyerDAOImpl(session);
			buyerDAOImpl.saveBuyerInfo(buyerDTO);
			saleMasterDTO.setBuyer(buyerDTO);
			saleMasterDTO.setBillDate(new Date());
			double totalWithoutVat=saleMasterDTO.getTotalWithVat()-saleMasterDTO.getVatAmount();
			saleMasterDTO.setTotalWithoutVat(totalWithoutVat);
			Set<SaleItemDTO> itemSet = new HashSet<SaleItemDTO>();
			for (Iterator it = items.iterator(); it.hasNext();) {
				SaleItemDTO saleItemDTO=(SaleItemDTO) it.next();
				saleItemDTO.setSaleMasterId(saleMasterDTO);
				itemSet.add(saleItemDTO);
			}

			saleMasterDTO.setItems(itemSet);

			ISaleMasterlDAO saleMasterlDAO = new SaleMasterDaoImpl(session);
			saleMasterDTO = saleMasterlDAO.saveSellingDetail(saleMasterDTO);

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			throw new OperationFailedException();
		} finally {
			try {
				// close session
				impl.closeAndCommitSession();

			} catch (Exception e) {
				e.printStackTrace();
				throw new OperationFailedException();
			}
		}
		// TODO Auto-generated method stub
		logger.info("EXIT....");
		return saleMasterDTO;
	}

}
