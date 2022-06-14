package vo;

import java.sql.Date;

public class Address {

	private int addressNo;
	private String addressName;
	private int postalCode;
	private String address1;
	private String address2;
	private String tel;
	private Date addressCreatedDate;
	
	public Address() {
		super();
	}
	public Address(int addressNo, String addressName, int postalCode, String address, String address2, String tel,
			Date addressCreatedDate) {
		super();
		this.addressNo = addressNo;
		this.addressName = addressName;
		this.postalCode = postalCode;
		this.address1 = address;
		this.address2 = address2;
		this.tel = tel;
		this.addressCreatedDate = addressCreatedDate;
	}
	
	public int getAddressNo() {
		return addressNo;
	}
	public void setAddressNo(int addressNo) {
		this.addressNo = addressNo;
	}
	public String getAddressName() {
		return addressName;
	}
	public void setAddressName(String addressName) {
		this.addressName = addressName;
	}
	public int getPostalCode() {
		return postalCode;
	}
	public void setPostalCode(int postalCode) {
		this.postalCode = postalCode;
	}
	public String getAddress() {
		return address1;
	}
	public void setAddress(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public Date getAddressCreatedDate() {
		return addressCreatedDate;
	}
	public void setAddressCreatedDate(Date addressCreatedDate) {
		this.addressCreatedDate = addressCreatedDate;
	}

	
	
}
