const app = angular.module("authority-app", []);
app.controller("authority-ctrl", function ($scope, $http, $location) {
  $scope.roles = [];
  $scope.admins = [];
  $scope.authories = [];

  $scope.intialize = function () {
    $http.get(`/rest/roles`).then((resp) => {
      $scope.roles = resp.data;
    });

    $http.get(`/rest/account/admin/?admin=true`).then((resp) => {
      $scope.admins = resp.data;
    });

    $http
      .get(`/rest/authorities?admin=true`)
      .then((resp) => {
        $scope.authories = resp.data;
      })
      .catch((error) => {
        $location.path(`/security/login/unauthoried`);
      });
  };
  $scope.intialize();

  $scope.authority_of = function (acc, role) {
    if ($scope.authories) {
      return $scope.authories.find(
        (ur) => ur.account.username == acc.username && ur.role.id == role.id
      );
    }
  };

  $scope.authority_changed = function (acc, role) {
    let authority = $scope.authority_of(acc, role);
    if (authority) {
      $scope.revoke_authority(authority);
    } else {
      authority = { account: acc, role: role };
      $scope.grant_authority(authority);
    }
  };

  $scope.grant_authority = function (authority) {
    $http
      .post(`/rest/authorities`, authority)
      .then((resp) => {
        $scope.authories.push(resp.data);
        alert("Cap quyen thanh cong");
      })
      .catch((error) => {
      });
  };

  $scope.revoke_authority = function (authority) {
    $http
      .delete(`/rest/authorities/${authority.id}`, authority)
      .then((resp) => {
        let index = $scope.authories.findIndex((a) => a.id == authority.id);
        $scope.authories.splice(index, 1);
        alert("Thu hoi quyen thanh cong");
      })
      .catch((error) => {
      });
  };

  $scope.saveAccount = function () {
    let account = {
      username: $scope.username,
      fullname: $scope.firstname + ' ' +$scope.lastname,
      password: $scope.password,
      email: $scope.email,
      phone: $scope.phone,
      firstname: $scope.firstname,
      lastname: $scope.lastname
    };
    let existUsername = $scope.admins.find(function (admin) {
      return admin.username === account.username;
    });

    if (existUsername) {
      alert("Username is exist");
    } else {
      $http
        .post(`/rest/account/add`, account)
        .then(function (response) {
          $scope.clearForm();
          alert("Create Successful");
        })
        .catch(function (error) {});
    }
  };

  $scope.updateFullname = function() {
    $scope.fullname = $scope.firstname + ' ' + $scope.lastname;
  };

  $scope.edit = function (acc) {
    $scope.username = acc.username;
    $scope.fullname = acc.fullname;
    $scope.password = acc.password;
    $scope.email = acc.email;
    $scope.phone = acc.phone;
    $scope.firstname = acc.firstname;
    $scope.lastname = acc.lastname;
   	$(".nav-pills a:eq(1)").tab('show');
  };

  $scope.update = function () {
    let account = {
      username: $scope.username,
      fullname: $scope.firstname + ' ' + $scope.lastname,
      password: $scope.password,
      email: $scope.email,
      phone: $scope.phone,
      firstname: $scope.firstname,
      lastname: $scope.lastname
    };
    $http
      .put(`/rest/account/update/${account.username}`, account)
      .then((resp) => {
        let index = $scope.admins.findIndex(
          (a) => a.username === account.username
        );
        $scope.admins[index] = account;
        alert("update success");
        $scope.clearForm();
      })
      .catch((err) => {
        console.log(err);
      });
  };

 

  $scope.clearForm = function () {
    $scope.username = "";
    $scope.fullname = "";
    $scope.password = "";
    $scope.email = "";
    $scope.phone = "";
    $scope.firstname = "";
    $scope.lastname = "";
  };
  
  $scope.pager = {
		page: 0,
		size: 3,
		get admins() {
			var start = this.page * this.size;
			return $scope.admins.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.admins.length / this.size);
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
