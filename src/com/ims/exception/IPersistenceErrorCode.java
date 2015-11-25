package com.ims.exception;

public interface IPersistenceErrorCode {
	public static final String DATABASE_PROBLEM = "PER_001";

	public static final String DATABASE_CONSTRAINT_ERROR = "PER_002";

	public static final String YOU_R_USING_STALE_DATA = "PER_003";

	

	public static final String DUPLICATE_USER_NAME = "PER_005";

	public static final String USERNAME_IS_BLANK_OR_NULL = "PER_006";

	public static final String USER_IS_NULL = "PER_007";

}
