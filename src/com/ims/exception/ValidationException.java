package com.ims.exception;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;

public class ValidationException extends Exception{

    private Collection errorCodes;
    private HashMap<String, String> errorCodesmap;
    public ValidationException( Collection errorCodes) {
        this.errorCodes = errorCodes;
        errorCodes = new ArrayList();
    }

    public ValidationException(HashMap<String, String> errorCodesmap) {
    	this.errorCodesmap = errorCodesmap;
    	errorCodesmap = new HashMap<String, String>();
	}
    

	public Collection getErrorCodes() {
        return errorCodes;
    }

	public HashMap<String, String> getErrorCodesmap() {
		return errorCodesmap;
	}

    
}