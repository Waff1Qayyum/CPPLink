package com.Model;

import java.io.Serializable;

public class Electric implements Serializable{
	private String username, month, proof, category;
	private double carbon_footprint, comsumption_data;
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getProof() {
		return proof;
	}
	public void setProof(String proof) {
		this.proof = proof;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public double getCarbon_footprint() {
		return carbon_footprint;
	}
	public void setCarbon_footprint(double carbon_footprint) {
		this.carbon_footprint = carbon_footprint;
	}
	public double getComsumption_data() {
		return comsumption_data;
	}
	public void setComsumption_data(double comsumption_data) {
		this.comsumption_data = comsumption_data;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	private int id, status;
}
