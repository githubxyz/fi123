package com.ims.dto;

import java.io.Serializable;
import java.util.Date;

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
@Table(name = "product_details")
public class ProductDetailDTO implements Serializable {
	private int id;
	private Double quantity;
	private Double weight;
	private Date purchaseDate;
	private double amount;
	private Double vat;
	private Integer type;
	private ProductMasterDTO productMaster;
	private int branch;
	private UserDTO user;
	private double saleQuantity;
	private boolean available;
	private boolean deleted;
	private String kAndP;

	@Id
	@Column(name = "id")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "product_details_seq_gen")
	@SequenceGenerator(name = "product_details_seq_gen", sequenceName = "product_details_seqs", allocationSize = 1)
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	@Column(name = "quantity")
	public Double getQuantity() {
		return quantity;
	}

	public void setQuantity(Double quantity) {
		this.quantity = quantity;
	}

	@Column(name = "weight")
	public Double getWeight() {
		return weight;
	}

	public void setWeight(Double weight) {
		this.weight = weight;
	}

	@Column(name = "purchase_date")
	public Date getPurchaseDate() {
		return purchaseDate;
	}

	public void setPurchaseDate(Date purchaseDate) {
		this.purchaseDate = purchaseDate;
	}

	@Column(name = "amount")
	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	@Column(name = "vat")
	public Double getVat() {
		return vat;
	}

	public void setVat(Double vat) {
		this.vat = vat;
	}

	@Column(name = "type")
	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "product_master_id", nullable = false)
	public ProductMasterDTO getProductMaster() {
		return productMaster;
	}

	public void setProductMaster(ProductMasterDTO productMaster) {
		this.productMaster = productMaster;
	}

	@Column(name = "branch_id")
	public int getBranch() {
		return branch;
	}

	public void setBranch(int branch) {
		this.branch = branch;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_master_id", nullable = false)
	public UserDTO getUser() {
		return user;
	}

	public void setUser(UserDTO user) {
		this.user = user;
	}
	
	
	@Column(name="sale_quantity")
	public double getSaleQuantity() {
		return saleQuantity;
	}

	public void setSaleQuantity(double saleQuantity) {
		this.saleQuantity = saleQuantity;
	}
	@Column(name="is_available")
	public boolean isAvailable() {
		return available;
	}

	public void setAvailable(boolean available) {
		this.available = available;
	}
	@Column(name="deleted")
	public boolean isDeleted() {
		return deleted;
	}

	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}
	
	
	@Column(name="k_and_p")
	public String getkAndP() {
		return kAndP;
	}

	public void setkAndP(String kAndP) {
		this.kAndP = kAndP;
	}

	@Override
	public String toString() {
		return "ProductDetailDTO [id=" + id + ", quantity=" + quantity + ", weight=" + weight + ", purchaseDate="
				+ purchaseDate + ", amount=" + amount + ", vat=" + vat + ", type=" + type + ", productMaster="
				+ productMaster + ", branch=" + branch +", user="+user+"]";
	}

}
