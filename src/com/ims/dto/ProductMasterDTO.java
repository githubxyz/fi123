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
import javax.persistence.Transient;

import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.CascadeType;
import org.hibernate.type.TrueFalseType;

@Entity
@Table(name = "product_master")
public class ProductMasterDTO implements Serializable {
	int id;
	String productCode;
	String productName;
	String weight_unit;
	ProductGroupMapDTO prGroupMapDTO;
	String qty_unit;
	boolean sub_item_type_req;
	private String gown;
	
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
	
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "group_id")
	@Cascade({CascadeType.SAVE_UPDATE}) 
	public ProductGroupMapDTO getPrGroupMapDTO() {
		return prGroupMapDTO;
	}
	public void setPrGroupMapDTO(ProductGroupMapDTO prGroupMapDTO) {
		this.prGroupMapDTO = prGroupMapDTO;
	}
	@Column(name = "weight_unit")
	public String getWeight_unit() {
		return weight_unit;
	}
	public void setWeight_unit(String weight_unit) {
		this.weight_unit = weight_unit;
	}
	@Column(name = "qty_unit")
	public String getQty_unit() {
		return qty_unit;
	}
	public void setQty_unit(String qty_unit) {
		this.qty_unit = qty_unit;
	}
	@Column(name = "is_sub_item_type_req")
	public boolean isSub_item_type_req() {
		return sub_item_type_req;
	}
	public void setSub_item_type_req(boolean sub_item_type_req) {
		this.sub_item_type_req = sub_item_type_req;
	}
	@Column(name="gown")
	public String getGown() {
		return gown;
	}

	public void setGown(String gown) {
		this.gown = gown;
	}
	
	/*public boolean getSub_item_type_req() {
		return sub_item_type_req;
	}
	public void setSub_item_type_req(boolean sub_item_type_req) {
		this.sub_item_type_req = sub_item_type_req;
	}*/
		
}
