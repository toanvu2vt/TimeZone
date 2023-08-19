const app = angular.module('app', []);

app.controller('ctrl', function($scope, $http) {
	function getCart(username) {
		const cartKey = `cart_${username}`
		const json = localStorage.getItem(cartKey);
		return json ? JSON.parse(json) : {
			username: username,
			items: []
		};
	}

	function saveCart(username, cart) {
		let cartKey = `cart_${username}`
		let json = JSON.stringify(cart);
		localStorage.setItem(cartKey, json);
	}

    function totalPrice(){
        let totalPrice = 0;
        angular.forEach($scope.cart.items, function(item) {
            totalPrice += item.price * item.qty;
        });
        return totalPrice;
    }
    
    	

	$scope.cart = {

		username: "",

		items: [],

		add(id) {

			if (!this.items) {
				this.items = [];
			}


			let item = this.items.find(item => item.id == id);

			if (item) {
				item.qty++;
				saveCart(this.username, this)
			} else {
				$http.get(`/rest/products/${id}`).then(resp => {
					let newItem = resp.data;
					newItem.qty = 1;
					this.items.push(newItem);
					saveCart(this.username, this);
				})
			}
		},
		remove(id) {
			let index = this.items.findIndex(item => item.id === id);
			this.items.splice(index, 1);
			saveCart(this.username, this);
		},
		clear() {
			this.items = [];
			saveCart(this.username, this);
		},
		get count() {
			return this.items.map(item => item.qty).reduce((total, qty) => total += qty, 0);
		},
		get amount() {
			return totalPrice();
		},
		saveToLocalStorage() {
			let itemsToSave = this.items.map(item => {
				const { $$hashKey, ...cleanItem } = item;
				return cleanItem;
			});
			saveCart(this.username, itemsToSave);
		},
		loadFromLocalStorage() {
			let cart = getCart(this.username);
			this.items = cart.items
		},

		totalPrice: totalPrice
	};

	let username = $("#username").text().trim();
	$scope.cart.username = username;
	$scope.cart.loadFromLocalStorage();



	
	$scope.order = {
		createDate: new Date(),
		address: $scope.house + ' ' + $scope.district + ' ' + $scope.city,
		account: { username: $("#username").text() },
		orderStatus: {id:1},
		get orderDetails() {
			return $scope.cart.items.map(item => {
				return {
					product: { id: item.id },
					price: item.price,
					quantity: item.qty
				}
			});
		},

		purchase() {
			let order = angular.copy(this);
			$http.post(`/rest/orders`, order).then(resp => {
				alert(`Thank you for your purchasing ${$scope.cart.count} items!`);
				$scope.cart.clear();
				location.href = "/order/detail/" + resp.data.id;
			}).catch(error => {
			})
		}
	}

	$scope.updateAddress = function() {
		$scope.order.address = $scope.house + ' ' + $scope.district + ' ' + $scope.city;
	};
	
	$scope.goToPay = function() {
		if (!$scope.formCheckOut.$invalid && !$scope.isDisabled) {
			window.location.href = "/pay";
		}
	};
	
	// account ctrl
	$scope.account = {};


	$scope.initialize = function() {
		$http.get(`/rest/account`).then(resp => {
			$scope.account = resp.data;
		});
	}

	$scope.initialize();

  $scope.updateAccount= function(){
      let account = angular.copy($scope.account);
      $http.put(`/rest/account/${account.username}`, account).then(resp=>{
          $scope.account = angular.copy(account);
          alert("Update success");
      }).catch(err=>{
      })
  }


	$scope.delete = function(accountD) {
		if (confirm("Are you sure you want to delete this account?")) {
			$http.delete(`/rest/account/${accountD.username}`).then(resp => {
				alert("Delete Success");
				location.href = "/security/logoff";
			}).catch(err => {
			})
		}
	}

	$scope.authenticationPass = function() {
		let confirmPassword = document.getElementById("confirmPassword").value;
		$http.post(`/rest/account/${$scope.account.username}/authenticate`, { password: confirmPassword }).then(resp => {
			if (resp.data) {
				$('#exampleModalCenter').modal('hide');
				$('#newPasswordModal').modal('show');
			} else {
				alert("Wrong password ");
			}
		});
	}

	$scope.updatePassword = function() {
		console.log("updatePassword function called");
		let newPassword = document.getElementById("newPassword").value;
		let confirmPassword = document.getElementById("confirmNewPassword").value;
		if (newPassword === confirmPassword) {
			$http.put(`/rest/account/${$scope.account.username}/password`, { password: newPassword }).then(resp => {
				alert("Update password success");
				location.href = "/home/account";
			}).catch(err => {
				console.log(err);
			})
		} 
	}





});