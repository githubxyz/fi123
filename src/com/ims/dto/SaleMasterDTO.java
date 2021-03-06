package com.ims.dto;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.CascadeType;
@Entity
@Table(name = "sales_master")
public class SaleMasterDTO implements Serializable {
	private int id;
	private Set<SaleItemDTO> items; 
	
	private double vatAmount;
	private double totalWithVat;
	private double totalWithoutVat;
	private int branchId;
	private UserDTO saleBy;
	private double discount;
	private Date billDate;
	private String customerVatNo;
	private String billNo;
	private BuyerDTO buyer;
	
	@Id
	@Column(name = "id")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sales_master_seqs_gen")
	@SequenceGenerator(name = "sales_master_seqs_gen", sequenceName = "sales_master_seqs", allocationSize = 1)
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	@OneToMany(fetch = FetchType.EAGER,mappedBy="saleMasterId")
	@Cascade({CascadeType.SAVE_UPDATE})
	public Set<SaleItemDTO> getItems() {
		return items;
	}
	public void setItems(Set<SaleItemDTO> items) {
		this.items = items;
	}
	@Column(name="total_vat_amount")
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
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "user_id", nullable = false)
	public UserDTO getSaleBy() {
		return saleBy;
	}
	public void setSaleBy(UserDTO saleBy) {
		this.saleBy = saleBy;
	}
	@Column(name="discount_amount")
	public double getDiscount() {
		return discount;
	}
	public void setDiscount(double discount) {
		this.discount = discount;
	}
	@Column(name="bill_date")
	public Date getBillDate() {
		return billDate;
	}
	public void setBillDate(Date billDate) {
		this.billDate = billDate;
	}
	@Column(name="customer_vat_no")
	public String getCustomerVatNo() {
		return customerVatNo;
	}
	public void setCustomerVatNo(String customerVatNo) {
		this.customerVatNo = customerVatNo;
	}
	@Column(name="bill_no")
	public String getBillNo() {
		return billNo;
	}
	public void setBillNo(String billNo) {
		this.billNo = billNo;
	}
	
	@OneToOne(fetch= FetchType.EAGER)
    @JoinColumn(name="customer_id")
	public BuyerDTO getBuyer() {
		return buyer;
	}
	public void setBuyer(BuyerDTO buyer) {
		this.buyer = buyer;
	}
	@Override
	public String toString() {
		return "SaleMasterDTO [id=" + id + ", items=" + items + ", vatAmount=" + vatAmount + ", totalWithVat="
				+ totalWithVat + ", totalWithoutVat=" + totalWithoutVat + ", branchId=" + branchId + ", saleBy="
				+ saleBy + ", discount=" + discount + ", billDate=" + billDate + ", customerVatNo=" + customerVatNo
				+ "]";
	}
	
	

}
