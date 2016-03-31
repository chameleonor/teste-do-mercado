var customInterpolationApp = angular.module("testeDeMercado", []);

customInterpolationApp.config(function($interpolateProvider) {
	$interpolateProvider.startSymbol('//');
	$interpolateProvider.endSymbol('//');
});

var url = 'http://mercado-guilhermeor.rhcloud.com/';

customInterpolationApp.controller("testeDeMercadoCtrl", function($scope, $http){

	$scope.app = "Negociação de Mercadoria";

	$scope.mercadorias = [];

	// função ajax para retornar a lista de operações do banco MongoDB
	var carregarOperacoes = function() {

		$http.get(url+"operacoes").success(function (data) {
			if (data == '') {
				$("table.table tbody tr.table-warning").removeClass('invisible collapse');
				$scope.mercadorias = data;
			} else {
				$("table.table tbody tr.table-warning").addClass('invisible collapse');
				$scope.mercadorias = data;
			}
		}).error(function (data, status) {
			$scope.message = "Aconteceu um problema: " + data;
		});
	};

	$scope.tiposMercadoria = [
	{ 'nome' : 'Celular' },
	{ 'nome' : 'Tablet' },
	{ 'nome' : 'TV' }
	];

	$scope.tiposNegocio = [{ 'nome' : 'Compra' },{ 'nome' : 'Venda' }];

	$scope.adicionarMercadoria = function(mercadoria) {

		$http({
			url: url+"novaOperacao",
			method: "POST",
			data: mercadoria,
			headers: { 'Content-Type': 'application/json' }
		}).success(function(data) {

			$('#cadOperModal').modal('toggle');
			$(".alert.alert-success span.text").text(data);
			$(".alert.alert-success").removeClass('invisible collapse').fadeIn('slow').fadeOut(3500);
			carregarOperacoes();

		}).error(function(data){
			
			$('#cadOperModal').modal('toggle');
			$(".alert.alert-alert span.text").text(data);
			$(".alert.alert-alert").removeClass('invisible collapse').fadeIn('slow').fadeOut(3500);
			carregarOperacoes();

		});

		delete $scope.mercadoria;
		$scope.operacaoForm.$setPristine();
	};

	$scope.apagarMercadoria = function(mercadorias) {

		mercadorias.filter(function(){
			remover = mercadorias.filter(function(mercadoria){
				if(mercadoria.selecionado) return mercadoria;
			});
		});

		$http({
			url: url+"removerOperacao",
			method: "POST",
			data: remover,
			headers: { 'Content-Type': 'application/json' }
		}).success(function(data) {

			$(".alert.alert-warning span.text").text(data);
			$(".alert.alert-warning").removeClass('invisible collapse').fadeIn('slow').fadeOut(3500);
			carregarOperacoes();

		}).error(function(data){
			
			$(".alert.alert-alert span.text").text(data);
			$(".alert.alert-alert").removeClass('invisible collapse').fadeIn('slow').fadeOut(3500);
			carregarOperacoes();

		});
	};

	$scope.isMercadoriaSelecionado = function(mercadorias) {
		return mercadorias.some(function (mercadoria) {
			return mercadoria.selecionado;
		});
	};

	// chamada da função
	carregarOperacoes();

});