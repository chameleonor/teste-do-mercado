<!DOCTYPE html>
<html ng-app="testeDeMercado">
<head>
	<meta charset="UTF-8">
	<title>Teste de Mercado</title>

	<link rel="stylesheet" type="text/css" href="../static/css/main.css">
	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0-alpha/css/bootstrap.min.css">

	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0-alpha/js/bootstrap.min.js"></script>
	<!-- <script type="text/javascript" src="../static/js/angular.min.js"></script> -->
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.3/angular.min.js"></script>

	<script type="text/javascript" src="../static/js/app.js"></script>
	<script type="text/javascript" src="../static/js/testeDeMercadoCtrl.js"></script>

</head>

<body ng-controller="testeDeMercadoCtrl">

	<div class="container">
		<div class="row">

			<!-- lista de operações -->

			<div class="lista center-block col-lg-12 col-md-12 col-sm-12 col-xs-12">
				
				<h3 class="text-center">//app//</h3>

				<div class="alert alert-success invisible collapse">
					<strong>Sucesso!</strong><span class="text pull-right"></span>
				</div>

				<div class="alert alert-alert invisible collapse">
					<strong>Erro!</strong><span class="text pull-right"></span>
				</div>

				<div class="alert alert-warning invisible collapse">
					<strong>Atenção!</strong><span class="text pull-right"></span>
				</div>

				<h3 class="titulo">Lista de Operações</h3>

				<table class="table table-hover table-bordered">

					<thead>
						<th></th>
						<th>Código da Mercadoria</th>	
						<th>Tipo da Mercadoria</th>
						<th>Nome da Mercadoria</th>
						<th>Quantidade</th>
						<th>Preço</th>
						<th>Tipo do Negócio</th>
					</thead>

					<tbody>
						<tr class="table-warning invisible collapse"><td colspan="7" class="text-center">Não existem registros!</td></tr>
						<tr ng-repeat="mercadoria in mercadorias" ng-class="{'table-warning' : mercadoria.selecionado}">
							<td><input type="checkbox" ng-model="mercadoria.selecionado"></input></td>
							<td>//mercadoria.codigo//</td>
							<td>//mercadoria.tipo.nome//</td>
							<td>//mercadoria.mercadoria//</td>
							<td>//mercadoria.quantidade//</td>
							<td>//mercadoria.preco//</td>
							<td>//mercadoria.negocio.nome//</td>
						</tr>
					</tbody>

				</table>
			</div>

			<div class="carOperDiv center-block col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<!-- Button modal -->
				<button type="button" class="btn btn-primary btn-md center-block" data-toggle="modal" data-target="#cadOperModal">Cadastrar Operação</button>

				<!-- Button remover operação -->
				<button id="remover" name="remover" class="btn btn-danger btn-md center-block" ng-click="apagarMercadoria(mercadorias)" ng-show="isMercadoriaSelecionado(mercadorias)">Apagar Operação</button>
			</div>


			<!-- Modal -->
			<div class="modal fade" id="cadOperModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							<h4 class="modal-title" id="myModalLabel">Cadastro de Operação</h4>
						</div>
						<div class="modal-body">

							<!-- form de cadastro de operação -->
							<form name="operacaoForm">
								<div class="form-group">
									<label for="codigo-mercadoria" class="control-label">Código da Mercadoria</label>
									<input id="codigo" name="codigo" type="text" class="form-control" placeholder="Digite o código da mercadoria" ng-model="mercadoria.codigo" ng-required="true"></input>
								</div>

								<div class="form-group">
									<label for="tipo-mercadoria" class="control-label">Tipo da Mercadoria</label>
									<select id="tipo" name="tipo" class="form-control" ng-model="mercadoria.tipo" ng-options="tipoMercadoria.nome for tipoMercadoria in tiposMercadoria" ng-required="true">
										<option value="">Selecione uma opção:</option>
									</select>
								</div>

								<div class="form-group">
									<label for="nome-mercadoria" class="control-label">Nome da Mercadoria</label>
									<input id="nome" name="nome" class="form-control" placeholder="Digite o nome da mercadoria" ng-required="true" ng-model="mercadoria.mercadoria"></input>
								</div>

								<div class="form-group">
									<label for="quantidade-mercadoria" class="control-label">Quantidade</label>
									<input id="quantidade" name="quantidade" placeholder="Digite a quantidade" class="form-control" placeholder="" ng-required="true" ng-model="mercadoria.quantidade"></input>
								</div>

								<div class="form-group">
									<label for="preco-mercadoria" class="control-label">Preço</label>
									<input class="form-control" placeholder="Preço total R$" ng-required="true" ng-model="mercadoria.preco"></input>
								</div>

								<div class="form-group">
									<label for="tipo-negocio" class="control-label">Tipo do Negócio</label>

									<select id="negocio" name="negocio" class="form-control" ng-model="mercadoria.negocio" ng-options="tipoNegocio.nome for tipoNegocio in tiposNegocio" ng-required="true">
										<option value="">Selecione uma opção:</option>
									</select>
								</div>
							</form>
						</div>
						<div class="modal-footer">

							<!-- Button cadastrar operação -->
							<div class="form-group">
								<button id="inserir" name="inserir" class="btn btn-primary btn-block" ng-click="adicionarMercadoria(mercadoria)" ng-disabled="operacaoForm.$invalid">Inserir</button>
							</div>

							<button type="button" class="btn btn-block btn-info" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div> <!-- end modal -->

			<div class="footer text-center center-block">
				<span>Desenvolvido por Guilherme Or - https://br.linkedin.com/in/guilhermeor - =)</span>
			</div>
		</div> <!-- end row -->
	</div> <!-- end container -->

</body>

</html>