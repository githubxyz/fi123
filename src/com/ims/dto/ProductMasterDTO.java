package com.ims.dto;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.type.TrueFalseType;

@Entity
@Table(name = "product_master")
public class ProductMasterDTO implements Serializable {
	int id;
	String productCode;
	String productName;
	int unitOfMesure;
	
	@Id
	@Column(name = "id")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="product_master_seq_gen")
	@SequenceGenerator(
		name="product_master_seq_gen",
		sequenceName="product_master_seqs",
		allocationSize=1
	)
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	@Column(name = "product_code" ,unique=true)
	public String getProductCode() {
		if(productCode!=null)
			productCode=productCode.trim();
		return productCode;
	}
	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}
	@Column(name = "product_name",unique=true)
	public String getProductName() {
		if(productName!=null)
			productName=productName.trim();
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	@Column(name = "unit_of_measure")
	public int getUnitOfMesure() {
		return unitOfMesure;
	}
	public void setUnitOfMesure(int unitOfMesure) {
		this.unitOfMesure = unitOfMesure;
	}
	@Override
	public String toString() {
		return "ProductMasterDTO [id=" + id + ", productCode=" + productCode + ", productName=" + productName
				+ ", unitOfMesure=" + unitOfMesure + "]";
	}
	
	
}
