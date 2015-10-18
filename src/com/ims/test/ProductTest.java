package com.ims.test;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.junit.Test;

import com.ims.dto.ProductDetailDTO;
import com.ims.dto.ProductGroupMapDTO;
import com.ims.dto.ProductMasterDTO;
import com.ims.dto.UserDTO;
import com.ims.exception.OperationFailedException;
import com.ims.persistence.hibernate.IPersistenceManager;
import com.ims.persistence.hibernate.PersistenceException;
import com.ims.persistence.hibernate.PersistenceManagerImpl;
import com.ims.persistence.hibernate.dao.IProductMasterDAO;
import com.ims.persistence.hibernate.dao.ProductGroupMapDAOImpl;
import com.ims.persistence.hibernate.dao.ProductMasterDAOImpl;
import com.ims.service.productService.IProductService;
import com.ims.service.productService.ProductServiceImpl;

public class ProductTest {

	private static Logger logger = Logger.getLogger("com.biz");
	public Session ses = null;

	//@Test
	public void testProduct() {
		logger.info("entry...");
		IPersistenceManager per = new PersistenceManagerImpl();
		ProductMasterDTO productMaster = new ProductMasterDTO();
		productMaster.setProductCode("5465");
		productMaster.setProductName("potol");
		productMaster.setUnitOfMesure(1);
		ProductGroupMapDTO name = new ProductGroupMapDTO();
		name.setCode("AL");
		productMaster.setPrGroupMapDTO(name);

		try {
			ses = per.openSessionAndBeginTransaction();
			IProductMasterDAO productMasterDAO = new ProductMasterDAOImpl(ses);
			productMasterDAO.saveProductMaster(productMaster);
		} catch (PersistenceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				// close session
				per.closeAndCommitSession();

			} catch (Exception e) {
				e.printStackTrace();
				// throw new OperationFailedException();
			}
		}

	}
	//@Test
	public void testPurchaseEntry() {
		IProductService productService=new ProductServiceImpl();
		ProductDetailDTO productDetailDTO=new ProductDetailDTO();
		ProductMasterDTO productMasterDTO=new ProductMasterDTO();
		productMasterDTO.setId(2);
		productDetailDTO.setAmount(500.00);
		productDetailDTO.setQuantity(5.0);
		productDetailDTO.setVat(20.0);
		productDetailDTO.setWeight(10.0);
		productDetailDTO.setBranch(1);
		productDetailDTO.setProductMaster(productMasterDTO);
			UserDTO user = new UserDTO(); 
			user.setId(1);
		productDetailDTO.setUser(user);
		productDetailDTO.setType(1);
		 
		try {
			productService.saveProductDetail(productDetailDTO);
			List<ProductMasterDTO> li=productService.listProduct();
			System.out.println(li);
		} catch (OperationFailedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	@Test
	public void testProductCode() {
		ProductServiceImpl productGroupMapDAOImpl=new ProductServiceImpl(); 
		try {
			ProductGroupMapDTO pro=productGroupMapDAOImpl.getProductGroupByCode("AL");
			System.out.println(pro);
		} catch (OperationFailedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}


}
