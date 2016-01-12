package com.ims.service.branchService;

import com.ims.dto.BranchDTO;
import com.ims.exception.OperationFailedException;

public interface IBranchService {
	public BranchDTO getBranchById() throws OperationFailedException;
}
