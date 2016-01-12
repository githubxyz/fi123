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
	private String pin;
	private String phone;
	private String email;
	private String addressLine1;
	private String addressLine2;
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
	@Column(name="branch_pin")
	public String getPin() {
		return pin;
	}
	public void setPin(String pin) {
		this.pin = pin;
	}
	@Column(name="branch_phone")
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	@Column(name="branch_email")
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	@Column(name="address_line1")
	public String getAddressLine1() {
		return addressLine1;
	}
	public void setAddressLine1(String addressLine1) {
		this.addressLine1 = addressLine1;
	}
	@Column(name="address_line2")
	public String getAddressLine2() {
		return addressLine2;
	}
	public void setAddressLine2(String addressLine2) {
		this.addressLine2 = addressLine2;
	}
	@Override
	public String toString() {
		return "BranchDTO [id=" + id + ", branchName=" + branchName + ", branchCode=" + branchCode + ", vatNo=" + vatNo
				+ ", city=" + city +  ", pin=" + pin +  ", phone=" + phone + ", email=" + email + ", addressLine1=" + addressLine1 + ", addressLine2=" + addressLine2 + " ]";
	}
	

}
