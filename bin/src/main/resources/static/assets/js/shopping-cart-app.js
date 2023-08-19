var app = angular.module('shopping-cart-app',[]);

app.controller('shopping-cart-ctrl',function($scope,$http){
    $scope.cart= {
        items:[],
        
        add(id){
            var item = this.items.find(item => item.id == id);
            if(item){
                item.qty++;
            } else {
                $http.get(`/rest/products/${id}`).then(resp =>{
                    resp.data.qty = 1;
                    this.items.push(resp.data);
                    this.saveToLocalStorage();
                })
            }
        },
        remove(id){
            var index = this.items.findIndex( item => item.id === id );
            this.items.splice( index, 1 );
            this.saveToLocalStorage();
        },
        clear(){
            this.items = [];
            this.saveToLocalStorage();
        },
        amt_of(item){},
        get count(){
            return this.items.map(item => item.qty).reduce((total,qty) => total += qty, 0);
        },
        get amount(){
            return this.items.map(item => item.qty * item.price).reduce((total,qty) => total += qty, 0);
        },
        saveToLocalStorage(){
            var json = JSON.stringify(angular.copy(this.items));
            localStorage.setItem("cart",json);
        },
        loadFromLocalStorage(){
            var json = localStorage.getItem("cart");
            this.items = json ? JSON.parse(json) : [];
        },
    }

    $scope.cart.loadFromLocalStorage();

    $scope.order = {
        createDate: new Date(),
        address: "",
        account:{username:$("#username").text()},
        getOrderDetails(){
            return $scope.cart.items.map(item=>{
                return {
                    product:{id:item.id},
                    price:item.price,
                    quantity:item.qty
                }
            });
        },

        purchase(){
            var order = angular.copy(this);
            $http.post(`/rest/orders`,order).then(resp=>{
                alert(`Thank you for your purchasing ${$scope.cart.count} items!`);
                $scope.cart.clear();
                location.href = "/order/detail" + resp.get.data.id;
            }).catch(error=>{
                alert("Error")
                console.log(error);
            })
        }
    }
    // account ctrl
    $scope.account = {};

    $scope.initialize = function() {
        $http.get(`/rest/account`).then(resp=>{
             $scope.account = resp.data;
       });
    }
    
    $scope.initialize();

    $scope.updateAccount= function(){
        var newAccount = angular.copy($scope.account);
        $http.put(`/rest/account/${newAccount.username}`,newAccount).then(resp=>{
            $scope.account = angular.copy(newAccount);
            alert("Update thanh cong");
        }).catch(err=>{
            alert("Update that bai");
            console.log(err);
        })
    }

    $scope.delete = function(accountD){
        $http.delete(`/rest/account/${accountD.username}`).then(resp=>{
            alert("Delete access");
            location.href = "/security/logoff";
        }).catch(err => {
            alert('Delete error');
            console.log(err);
        })
    }
});