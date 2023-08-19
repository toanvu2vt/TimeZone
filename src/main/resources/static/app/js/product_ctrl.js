const app = angular.module('product-app', []);
app.controller('product_ctrl', function($scope, $http) {
	$scope.items = [];
	$scope.cates = [];
	$scope.form = {
		createDate: new Date(),
		image: 'icloud-upload.png',
		available: true,
	};
	$scope.form.createDate=new Date();


	$scope.initialize = function() {
		$http.get(`/rest/products`).then(resp => {
			$scope.items = resp.data;
			$scope.items.forEach(item => {
				item.createDate = new Date(item.createDate)
			})
		});
		$http.get(`/rest/categories`).then(resp => {
			$scope.cates = resp.data;
		});
	}

	$scope.initialize();

	$scope.reset = function() {
		$scope.form = {
			createDate: new Date(),
			image: 'icloud-upload.png',
			available: true,
		}
	}

	$scope.edit = function(item) {
		$scope.form = angular.copy(item)
		$(".nav-pills a:eq(1)").tab('show');


	}
	$scope.create = function() {
		let item = angular.copy($scope.form);
		$http.post(`/rest/products`, item).then(resp => {
			resp.data.createDate = new Date(resp.data.createDate);
			$scope.items.push(resp.data);
			$scope.reset();
			alert("Create Success");
		}).catch(err => {

		})
	}

	$scope.update = function() {
		let item = angular.copy($scope.form);
		$http.put(`/rest/products/${item.id}`, item).then(resp => {
			let index = $scope.items.findIndex(p => p.id == item.id);
			$scope.items[index] = item;
			$scope.reset();
			alert("Update Success");
		}).catch(err => {
		})
	}

	$scope.delete = function(item) {
		$http.delete(`/rest/products/${item.id}`).then(resp => {
			let index = $scope.items.findIndex(p => p.id == item.id);
			$scope.items.splice(index, 1);
			$scope.reset();
			alert("Delete Success")
		}).catch(err => {
		})
	}

	$scope.imageChanged = function(files) {
		let data = new FormData();
		data.append('file', files[0]);
		$http.post(`/rest/upload/img/gallery`, data, {
			transformRequest: angular.identity,
			headers: { 'Content-Type': undefined }
		}).then(resp => {
			$scope.form.image = resp.data.name;
		}).catch(err => {
		})
	}
	$scope.pager = {
		page: 0,
		size: 10,
		get items() {
			let start = this.page * this.size;
			return $scope.items.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.items.length / this.size);
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

})