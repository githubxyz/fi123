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
import com.ims.dto.UserDTO;
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
				double mesure=0.0;
				if(saleItemDTO.getMesure()!=null && saleItemDTO.getMesure()>0.0){
					mesure=saleItemDTO.getMesure();
				}else{
					mesure=saleItemDTO.getQuantity();
				}
				saleItemDTO.setTotalWithoutVat(mesure*saleItemDTO.getUnitPrice());
				saleItemDTO.setVatAmount((mesure*saleItemDTO.getUnitPrice()*saleItemDTO.getVatPercentage())/100);
				saleItemDTO.setTotalWithVat(mesure*saleItemDTO.getUnitPrice()+((mesure*saleItemDTO.getUnitPrice()*saleItemDTO.getVatPercentage())/100));
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
		try {
			session = impl.openSessionAndBeginTransaction();

			saleMasterDTO=(SaleMasterDTO) session.load(SaleMasterDTO.class, saleMasterDTO.getId());
			logger.info("Saved saleMasterDTO="+saleMasterDTO);
		} catch (Exception e) {
			// TODO: handle exception
		}finally{
			try {
				// close session
				impl.closeAndCommitSession();

			} catch (Exception e) {
				e.printStackTrace();
				throw new OperationFailedException();
			}
		}
		logger.info("EXIT....");
		return saleMasterDTO;
	}

	@Override
	public List<SaleMasterDTO> searchSaleRecord(UserDTO searchBy, UserDTO searchFor, String billNo, Date fromDate,
			Date toDate) throws OperationFailedException, ValidationException {
		// TODO Auto-generated method stub
		return null;
	}

}
