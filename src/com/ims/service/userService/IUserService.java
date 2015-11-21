package com.ims.service.userService;

import com.ims.dto.UserDTO;
import com.ims.exception.OperationFailedException;

public interface IUserService {
	public UserDTO getUserByUserName() throws OperationFailedException;
	/**
	 * pass userDTO with user name and password
	 * @param userDTO
	 * @return if user name & password match then return a userDTO with id 
	 * otherwise return null;
	 * @throws OperationFailedException
	 */
	public UserDTO isValidLoginCradential(UserDTO userDTO) throws OperationFailedException;
}
