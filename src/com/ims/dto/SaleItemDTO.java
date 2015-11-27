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

@Entity
@Table(name = "sales_details")
public class SaleItemDTO implements Serializable {
	private int id;
	private ProductMasterDTO productMaster; 
	private double quantity;
	private Double mesure;
	private double vatAmount;
	private double totalWithVat;
	private double totalWithoutVat;
	private int branchId;
	private double vatPercentage;
	private SaleMasterDTO saleMasterId;
	private double unitPrice=0.0;
	
	@Id
	@Column(name = "id")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sales_details_seqs_gen")
	@SequenceGenerator(name = "sales_details_seqs_gen", sequenceName = "sales_details_seqs", allocationSize = 1)
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "product_master_id", nullable = false)
	public ProductMasterDTO getProductMaster() {
		return productMaster;
	}
	public void setProductMaster(ProductMasterDTO productMaster) {
		this.productMaster = productMaster;
	}
	@Column(name="quantity")
	public double getQuantity() {
		return quantity;
	}
	public void setQuantity(double quantity) {
		this.quantity = quantity;
	}
	@Column(name="measure")
	public Double getMesure() {
		return mesure;
	}
	public void setMesure(Double mesure) {
		this.mesure = mesure;
	}
	@Column(name="vat_amount")
	public double getVatAmount() {
		return vatAmount;
	}
	public void setVatAmount(double vatAmount) {
		this.vatAmount = vatAmount;
	}
	@Column(name="total_amount_with_vat")
	public double getTotalWithVat() {
		return totalWithVat;
	}
	public void setTotalWithVat(double totalWithVat) {
		this.totalWithVat = totalWithVat;
	}
	@Column(name="total_amount_without_vat")
	public double getTotalWithoutVat() {
		return totalWithoutVat;
	}
	public void setTotalWithoutVat(double totalWithoutVat) {
		this.totalWithoutVat = totalWithoutVat;
	}
	@Column(name="braanch_id")
	public int getBranchId() {
		return branchId;
	}
	public void setBranchId(int branchId) {
		this.branchId = branchId;
	}
	@Column(name="vat_percentage")
	public double getVatPercentage() {
		return vatPercentage;
	}
	public void setVatPercentage(double vatPercentage) {
		this.vatPercentage = vatPercentage;
	}
	
	
	@ManyToOne(fetch=FetchType.EAGER)
    @JoinColumn(name="sale_master_id",nullable = false)
	public SaleMasterDTO getSaleMasterId() {
		return saleMasterId;
	}
	public void setSaleMasterId(SaleMasterDTO saleMasterId) {
		this.saleMasterId = saleMasterId;
	}
	@Column(name="unit_price")
	public double getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(double unitPrice) {
		this.unitPrice = unitPrice;
	}
	@Override
	public String toString() {
		return "SaleItemDTO [id=" + id + ", productMaster=" + productMaster + ", quantity=" + quantity + ", mesure="
				+ mesure + ", vatAmount=" + vatAmount + ", totalWithVat=" + totalWithVat + ", totalWithoutVat="
				+ totalWithoutVat + ", branchId=" + branchId + ", vatPercentage=" + vatPercentage + "]";
	}
	
	
	
}
