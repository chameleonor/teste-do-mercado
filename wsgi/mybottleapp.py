# -*- coding: utf-8 -*-

from bottle import route, default_app, TEMPLATE_PATH, template, debug, request, redirect
from bson import Binary, Code
from bson.json_util import dumps
from bson.objectid import ObjectId

import os
import pymongo

debug(True)

mongo_con = pymongo.Connection(os.environ['OPENSHIFT_MONGODB_DB_HOST'], int(os.environ['OPENSHIFT_MONGODB_DB_PORT']))
mongo_db = mongo_con[os.environ['OPENSHIFT_APP_NAME']]
mongo_db.authenticate(os.environ['OPENSHIFT_MONGODB_DB_USERNAME'],os.environ['OPENSHIFT_MONGODB_DB_PASSWORD'])

# Para direcionar para o diretório correto em views
TEMPLATE_PATH.append(os.path.join(os.environ['OPENSHIFT_REPO_DIR'], 'wsgi/views/')) 

@route('/')
def index():
	return template('index')

# método ler operações
@route('/operacoes')
def operacoes():

	# seleciona coleção
	data = mongo_db.operacoes.find()

	return dumps(data)

@route('/novaOperacao', method='POST')
def novaOperacao():

	if (request.json != None or request.json != ''):
		operacao = request.json
		mongo_db.operacoes.insert(operacao)
		msg = "Operação adicionada com sucesso!"
		return msg
	else:
		msg = "Não foi possível inserir a operação!"
		return msg

@route('/removerOperacao', method='POST')
def novaOperacao():

	operacoes = request.json
	
	for i in operacoes:
	 	rid = i['_id']['$oid']
	 	if(mongo_db.operacoes.find( { '_id' : ObjectId(rid) } ).count() > 0):
			mongo_db.operacoes.remove({ '_id' : ObjectId(rid) })

	msg = "Registros removidos com sucesso!"
	return msg


application=default_app()
