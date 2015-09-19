package com.ims.dto;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name = "stock_alert")
public class StockAlertDTO implements Serializable {
	private int id;
	private Double minVal;
	private Double maxVal;
	private Integer type;
	private ProductMasterDTO productMaster;

	@Id
	@Column(name = "id")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "stock_alert_seqs_gen")
	@SequenceGenerator(name = "stock_alert_seqs_gen", sequenceName = "stock_alert_seqs", allocationSize = 1)
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	@Column(name = "min_val")
	public Double getMinVal() {
		return minVal;
	}

	public void setMinVal(Double minVal) {
		this.minVal = minVal;
	}

	@Column(name = "max_val")
	public Double getMaxVal() {
		return maxVal;
	}

	public void setMaxVal(Double maxVal) {
		this.maxVal = maxVal;
	}

	@Column(name = "type")
	public Integer getType() {
		if(type==null){
			type=1;
		}
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	@OneToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "product_master_id", nullable = true)
	public ProductMasterDTO getProductMaster() {
		return productMaster;
	}

	public void setProductMaster(ProductMasterDTO productMaster) {
		this.productMaster = productMaster;
	}

	@Override
	public String toString() {
		return "StockAlertDTO [id=" + id + ", minVal=" + minVal + ", maxVal=" + maxVal + ", type=" + type
				+ ", productMaster=" + productMaster + "]";
	}
	
	

}
