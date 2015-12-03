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
@Table(name = "branch")
public class BranchDTO implements Serializable {
	int id;
	String branchName;
	private String branchCode;
	private String vatNo;
	private String city;
	@Id
	@Column(name = "id")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "branch_seq_gen")
	@SequenceGenerator(name = "branch_seq_gen", sequenceName = "branch_seqs", allocationSize = 1)
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	@Column(name="branch_name")
	public String getBranchName() {
		return branchName;
	}
	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}
	@Column(name="branch_code")
	public String getBranchCode() {
		return branchCode;
	}
	public void setBranchCode(String branchCode) {
		this.branchCode = branchCode;
	}
	@Column(name="vat_no")
	public String getVatNo() {
		return vatNo;
	}
	public void setVatNo(String vatNo) {
		this.vatNo = vatNo;
	}
	@Column(name="branch_city")
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	@Override
	public String toString() {
		return "BranchDTO [id=" + id + ", branchName=" + branchName + ", branchCode=" + branchCode + ", vatNo=" + vatNo
				+ ", city=" + city + "]";
	}
	

}
