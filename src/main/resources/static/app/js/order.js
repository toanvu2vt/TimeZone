const app = angular.module('order_app', []);
app.controller('order_ctrl', function($scope, $http) {
    $scope.listOrders = [];
    $scope.listOrdersConfirmed = [];
    $scope.listOrdersCancelled = [];
    $scope.listOrdersSuccessful = [];
	
	$scope.initialize = function() {
		$http.get(`/rest/order`).then(resp => {
			$scope.listOrders = resp.data;
		});

        $http.get(`/rest/order/confirm`).then(resp => {
			$scope.listOrdersConfirmed = resp.data;
		});

        $http.get(`/rest/order/cancelled`).then(resp => {
			$scope.listOrdersCancelled = resp.data;
		});

        $http.get(`/rest/order/successful`).then(resp => {
			$scope.listOrdersSuccessful = resp.data;
		});
	}

    $scope.initialize();


	$scope.updateOrder = function(orderID) {
		let orderToUpdate = $scope.listOrders.find(function(order){
			return order.id === orderID;
		})
		if (orderToUpdate){
			let updateOrder = angular.copy(orderToUpdate);
			updateOrder.orderStatus.id = 2;
			$http.put(`/rest/order/${orderToUpdate.id}`, updateOrder).then(resp => {
				$scope.initialize();
			}).catch(err => {
			})
		}
	}

	$scope.updateOrder = {

		confirmOrder(orderID){
			let orderToUpdate = $scope.listOrders.find(function(order){
				return order.id === orderID;
			})
			if (orderToUpdate){
				let updateOrder = angular.copy(orderToUpdate);
				updateOrder.orderStatus.id = 2;
				$http.put(`/rest/order/${orderToUpdate.id}`, updateOrder).then(resp => {
					$scope.initialize();
					$(".nav-pills a:eq(1)").tab('show');
				}).catch(err => {
				})
			}
		},
		cancelOrder(orderID){
			let orderToUpdateWhenOrder = $scope.listOrdersConfirmed.find(function(order){
				return order.id === orderID;			
			})

			let orderUpdateWhenCofirm = $scope.listOrders.find(function(order){
				return order.id === orderID;			
			})

			if(orderToUpdateWhenOrder){
				let orderCancel =  angular.copy(orderToUpdateWhenOrder)
				orderCancel.orderStatus.id = 3;
				$http.put(`/rest/order/cancel/${orderCancel.id}`,orderCancel).then(resp=>{
					$scope.initialize();
					$(".nav-pills a:eq(2)").tab('show');
				}).catch(err => {
				})
				
			} else if(orderUpdateWhenCofirm){
				let orderCancel =  angular.copy(orderUpdateWhenCofirm)
				orderCancel.orderStatus.id = 3;
				$http.put(`/rest/order/cancel/${orderCancel.id}`,orderCancel).then(resp=>{
					$scope.initialize();
					$(".nav-pills a:eq(2)").tab('show');
				}).catch(err => {
				})
			}
		},
		resetOrder(orderID){
			let orderToUpdate = $scope.listOrdersCancelled.find(function(order){
				return order.id === orderID;			
			})
			if(orderToUpdate){
				let orderReset =  angular.copy(orderToUpdate)
				orderReset.orderStatus.id = 2;
				$http.put(`/rest/order/reset/${orderReset.id}`,orderReset).then(resp=>{
					$scope.initialize();
					$(".nav-pills a:eq(1)").tab('show');
				}).catch(err => {
				})
			}
		},
		successOrder(orderID){
			let orderToUpdate = $scope.listOrdersConfirmed.find(function(order){
				return order.id === orderID;			
			})
			if(orderToUpdate){
				let orderSuccess =  angular.copy(orderToUpdate)
				orderSuccess.orderStatus.id = 4;
				$http.put(`/rest/order/success/${orderSuccess.id}`,orderSuccess).then(resp=>{
					$scope.initialize();
					$(".nav-pills a:eq(3)").tab('show');
				}).catch(err => {
				})
			}
		}
	};
	
	//phân trang listOrders
	$scope.pager1 = {
		page: 0,
		size: 8,
		get listOrders() {
			var start = this.page * this.size;
			return $scope.listOrders.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.listOrders.length / this.size);
		},
		first() {
			this.page = 0;
		},
		prev() {
			this.page--;
			if (this.page < 0) {
				this.last();
			}
		},
		next() {
			this.page++;
			if (this.page >= this.count) {
				this.first();
			}
		},
		last() {
			this.page = this.count - 1;
		}
	};
	//phân trang listOrdersConfirmed
	$scope.pager2 = {
		page: 0,
		size: 8,
		get listOrdersConfirmed() {
			var start = this.page * this.size;
			return $scope.listOrdersConfirmed.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.listOrdersConfirmed.length / this.size);
		},
		first() {
			this.page = 0;
		},
		prev() {
			this.page--;
			if (this.page < 0) {
				this.last();
			}
		},
		next() {
			this.page++;
			if (this.page >= this.count) {
				this.first();
			}
		},
		last() {
			this.page = this.count - 1;
		},
	};
	//phân trang listOrdersCancelled
	$scope.pager3 = {
		page: 0,
		size: 8,
		get listOrdersCancelled() {
			var start = this.page * this.size;
			return $scope.listOrdersCancelled.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.listOrdersCancelled.length / this.size);
		},
		first() {
			this.page = 0;
		},
		prev() {
			this.page--;
			if (this.page < 0) {
				this.last();
			}
		},
		next() {
			this.page++;
			if (this.page >= this.count) {
				this.first();
			}
		},
		last() {
			this.page = this.count - 1;
		},
};
	//phân trang listOrdersSuccessful
	$scope.pager4 = {
		page: 0,
		size: 5,
		get listOrdersSuccessful() {
			var start = this.page * this.size;
			return $scope.listOrdersSuccessful.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.listOrdersSuccessful.length / this.size);
		},
		first() {
			this.page = 0;
		},
		prev() {
			this.page--;
			if (this.page < 0) {
				this.last();
			}
		},
		next() {
			this.page++;
			if (this.page >= this.count) {
				this.first();
			}
		},
		last() {
			this.page = this.count - 1;
		}
	}	
});