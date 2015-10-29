package com.ims.persistence.hibernate.dao;

import com.ims.dto.ProductDetailDTO;
import com.ims.dto.ProductMasterDTO;
import com.ims.dto.UserDTO;
import com.ims.persistence.hibernate.PersistenceException;

public interface IUserDAO {

	public UserDTO saveUser(UserDTO userDTO) throws PersistenceException;

	public UserDTO getUserByUserName(String userId) throws PersistenceException;

	public UserDTO updateUser(UserDTO userDTO) throws PersistenceException;

}
