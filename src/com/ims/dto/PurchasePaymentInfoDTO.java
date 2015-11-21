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
@Table(name = "purchase_payment_info")
public class PurchasePaymentInfoDTO implements Serializable {
	private int id;
	private String company_name;
	private Double payment=0.0;
	private Double balance=0.0;
	private Double advance=0.0;
	private String billNo;
	

	@Id
	@Column(name = "id")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator=" purchase_payment_info_seqs_gen")
	@SequenceGenerator(
		name=" purchase_payment_info_seqs_gen",
		sequenceName=" purchase_payment_info_seqs",
		allocationSize=1
	)
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	@Column(name="company_name")
	public String getCompany_name() {
		return company_name;
	}
	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}
	public Double getPayment() {
		return payment;
	}
	public void setPayment(Double payment) {
		this.payment = payment;
	}
	public Double getBalance() {
		return balance;
	}
	public void setBalance(Double balance) {
		this.balance = balance;
	}
	public Double getAdvance() {
		return advance;
	}
	public void setAdvance(Double advance) {
		this.advance = advance;
	}
	@Column(name="bill_no")
	public String getBillNo() {
		return billNo;
	}
	public void setBillNo(String billNo) {
		this.billNo = billNo;
	}
	@Override
	public String toString() {
		return "PurchasePaymentInfoDTO [id=" + id + ", company_name=" + company_name + ", payment=" + payment
				+ ", balance=" + balance + ", advance=" + advance + ", billNo=" + billNo + "]";
	}
	
	
	
	

}
