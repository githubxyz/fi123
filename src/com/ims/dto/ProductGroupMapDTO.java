package com.ims.dto;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
@Entity
@Table(name = "product_group_map")
public class ProductGroupMapDTO implements Serializable {
	int id;
	String code;
	@Id
	@Column(name = "id")
	/*@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="product_master_seq_gen")
	@SequenceGenerator(
		name="product_master_seq_gen",
		sequenceName="product_master_seqs",
		allocationSize=1
	)*/
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	@Column(name="code")
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	@Override
	public String toString() {
		return "ProductGroupMapDTO [id=" + id + ", code=" + code + "]";
	}
	

}
