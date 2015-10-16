package com.ims.dto;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.CascadeType;
import org.hibernate.type.TrueFalseType;

@Entity
@Table(name = "product_master")
public class ProductMasterDTO implements Serializable {
	int id;
	String productCode;
	String productName;
	int unitOfMesure;
	ProductGroupMapDTO prGroupMapDTO;
	String unitType;
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
	@Column(name = "unit_type")
	public String getunitType() {
		return unitType;
	}
	public void setunitType(String unitType) {
		this.unitType = unitType;
	} 
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "group_id")
	@Cascade({CascadeType.SAVE_UPDATE}) 
	public ProductGroupMapDTO getPrGroupMapDTO() {
		return prGroupMapDTO;
	}
	public void setPrGroupMapDTO(ProductGroupMapDTO prGroupMapDTO) {
		this.prGroupMapDTO = prGroupMapDTO;
	}
	@Override
	public String toString() {
		return "ProductMasterDTO [id=" + id + ", productCode=" + productCode + ", productName=" + productName
				+ ", unitOfMesure=" + unitOfMesure + ", prGroupMapDTO=" + prGroupMapDTO + ", unitType=" + unitType
				+ "]";
	}
	
	
	
	
}
