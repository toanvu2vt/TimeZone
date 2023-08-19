package com.poly.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Min;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Getter;
import lombok.Setter;

@SuppressWarnings("serial")
@Getter
@Setter
@Entity
@Table(name = "Products")
public class Product implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	Integer id;
	// @NotBlank(message = "Không thể để trống tên sản phẩm!")
	@Column(name = "Name")
	String name;
	// @NotEmpty(message = "Không thể để trống Ảnh sản phẩm!")
	@Column(name = "Image")
	String image;
	// @NotNull(message = "Không thể để trống giá!")
	@Min(0)
	@Column(name = "Price")
	Double price;
	@Temporal(TemporalType.DATE)
	@Column(name = "Createdate")
	Date createDate = new Date();
	// @NotNull(message = "Không thể để trống Trạng thái!")
	@Column(name = "Available")
	Boolean available;
	@ManyToOne
	@JoinColumn(name = "category_id")
	// @NotNull(message = "Không thể để trống Loại sản phẩm!")
	Category category;
	@JsonIgnore
	@OneToMany(mappedBy = "product")
	List<OrderDetail> orderDetails;
}
