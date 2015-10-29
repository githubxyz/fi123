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
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="product_group_map_seqs_gen")
	@SequenceGenerator(
		name="product_group_map_seqs_gen",
		sequenceName="product_group_map_seqs",
		allocationSize=1
	)
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	@Column(name="code")
	public String getCode() {
		if(code!=null)
			code=code.toUpperCase().trim();
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
