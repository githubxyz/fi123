package com.ims.dto;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
@Entity
@Table(name = "stock_deatils")
public class StockDetailDTO implements Serializable {
	private int id;
	private String productCode;
	private String productName;
	private Double quantity;
	private Double weight;
	private int unitOfMesure;
	private int branchId;
	private ProductMasterDTO productMaster;
	private String kndP;
	private int type;
	@Id
	@Column(name = "id")
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	@Column(name="product_code")
	public String getProductCode() {
		return productCode;
	}
	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}
	@Column(name="product_name")
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	@Column(name="quantity")
	public Double getQuantity() {
		return quantity;
	}
	public void setQuantity(Double quantity) {
		this.quantity = quantity;
	}
	@Column(name="weight")
	public Double getWeight() {
		return weight;
	}
	public void setWeight(Double weight) {
		this.weight = weight;
	}
	@Column(name="unit_of_measure")
	public int getUnitOfMesure() {
		return unitOfMesure;
	}
	public void setUnitOfMesure(int unitOfMesure) {
		this.unitOfMesure = unitOfMesure;
	}
	@Column(name="branch_id")
	public int getBranchId() {
		return branchId;
	}
	public void setBranchId(int branchId) {
		this.branchId = branchId;
	}

    @OneToOne(fetch = FetchType.LAZY )
    @JoinColumn(name = "product_master_id", nullable = true)
	public ProductMasterDTO getProductMaster() {
		return productMaster;
	}
	public void setProductMaster(ProductMasterDTO productMaster) {
		this.productMaster = productMaster;
	}
	@Column(name="k_and_p")
	public String getKndP() {
		return kndP;
	}
	public void setKndP(String kndP) {
		this.kndP = kndP;
	}
	@Column(name="type")
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	@Override
	public String toString() {
		return "StockDetailDTO [id=" + id + ", productCode=" + productCode + ", productName=" + productName
				+ ", quantity=" + quantity + ", weight=" + weight + ", unitOfMesure=" + unitOfMesure + ", branchId="
				+ branchId + ", productMaster=" + productMaster + ", kndP=" + kndP + ", type=" + type+"]";
	}
	
	
	
}
