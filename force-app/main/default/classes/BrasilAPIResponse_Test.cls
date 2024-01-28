@IsTest
public class BrasilAPIResponse_Test {
	
	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{\"uf\":\"SP\",\"cep\":\"01311902\",\"qsa\":[{\"pais\":null,\"nome_socio\":\"FERNANDA CAMPAGNUCCI PEREIRA\",\"codigo_pais\":null,\"faixa_etaria\":\"Entre 31 a 40 anos\",\"cnpj_cpf_do_socio\":\"***690948**\",\"qualificacao_socio\":\"Presidente\",\"codigo_faixa_etaria\":4,\"data_entrada_sociedade\":\"2019-10-25\",\"identificador_de_socio\":2,\"cpf_representante_legal\":\"***000000**\",\"nome_representante_legal\":\"\",\"codigo_qualificacao_socio\":16,\"qualificacao_representante_legal\":\"Não informada\",\"codigo_qualificacao_representante_legal\":0}],\"cnpj\":\"19131243000197\",\"pais\":null,\"email\":null,\"porte\":\"DEMAIS\",\"bairro\":\"BELA VISTA\",\"numero\":\"37\",\"ddd_fax\":\"\",\"municipio\":\"SAO PAULO\",\"logradouro\":\"PAULISTA 37\",\"cnae_fiscal\":9430800,\"codigo_pais\":null,\"complemento\":\"ANDAR 4\",\"codigo_porte\":5,\"razao_social\":\"OPEN KNOWLEDGE BRASIL\",\"nome_fantasia\":\"REDE PELO CONHECIMENTO LIVRE\",\"capital_social\":0,\"ddd_telefone_1\":\"1123851939\",\"ddd_telefone_2\":\"\",\"opcao_pelo_mei\":null,\"descricao_porte\":\"\",\"codigo_municipio\":7107,\"cnaes_secundarios\":[{\"codigo\":9493600,\"descricao\":\"Atividades de organizações associativas ligadas à cultura e à arte\"},{\"codigo\":9499500,\"descricao\":\"Atividades associativas não especificadas anteriormente\"},{\"codigo\":8599699,\"descricao\":\"Outras atividades de ensino não especificadas anteriormente\"},{\"codigo\":8230001,\"descricao\":\"Serviços de organização de feiras, congressos, exposições e festas\"},{\"codigo\":6204000,\"descricao\":\"Consultoria em tecnologia da informação\"}],\"natureza_juridica\":\"Associação Privada\",\"situacao_especial\":\"\",\"opcao_pelo_simples\":null,\"situacao_cadastral\":2,\"data_opcao_pelo_mei\":null,\"data_exclusao_do_mei\":null,\"cnae_fiscal_descricao\":\"Atividades de associações de defesa de direitos sociais\",\"codigo_municipio_ibge\":3550308,\"data_inicio_atividade\":\"2013-10-03\",\"data_situacao_especial\":null,\"data_opcao_pelo_simples\":null,\"data_situacao_cadastral\":\"2013-10-03\",\"nome_cidade_no_exterior\":\"\",\"codigo_natureza_juridica\":3999,\"data_exclusao_do_simples\":null,\"motivo_situacao_cadastral\":0,\"ente_federativo_responsavel\":\"\",\"identificador_matriz_filial\":1,\"qualificacao_do_responsavel\":16,\"descricao_situacao_cadastral\":\"ATIVA\",\"descricao_tipo_de_logradouro\":\"AVENIDA\",\"descricao_motivo_situacao_cadastral\":\"SEM MOTIVO\",\"descricao_identificador_matriz_filial\":\"MATRIZ\"}';
		BrasilAPIResponse r = BrasilAPIResponse.parse(json);
		System.assert(r != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		BrasilAPIResponse.Cnaes_secundarios objCnaes_secundarios = new BrasilAPIResponse.Cnaes_secundarios(System.JSON.createParser(json));
		System.assert(objCnaes_secundarios != null);
		System.assert(objCnaes_secundarios.codigo == null);
		System.assert(objCnaes_secundarios.descricao == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		BrasilAPIResponse objBrasilAPIResponse = new BrasilAPIResponse(System.JSON.createParser(json));
		System.assert(objBrasilAPIResponse != null);
		System.assert(objBrasilAPIResponse.uf == null);
		System.assert(objBrasilAPIResponse.cep == null);
		System.assert(objBrasilAPIResponse.qsa == null);
		System.assert(objBrasilAPIResponse.cnpj == null);
		System.assert(objBrasilAPIResponse.pais == null);
		System.assert(objBrasilAPIResponse.email == null);
		System.assert(objBrasilAPIResponse.porte == null);
		System.assert(objBrasilAPIResponse.bairro == null);
		System.assert(objBrasilAPIResponse.numero == null);
		System.assert(objBrasilAPIResponse.ddd_fax == null);
		System.assert(objBrasilAPIResponse.municipio == null);
		System.assert(objBrasilAPIResponse.logradouro == null);
		System.assert(objBrasilAPIResponse.cnae_fiscal == null);
		System.assert(objBrasilAPIResponse.codigo_pais == null);
		System.assert(objBrasilAPIResponse.complemento == null);
		System.assert(objBrasilAPIResponse.codigo_porte == null);
		System.assert(objBrasilAPIResponse.razao_social == null);
		System.assert(objBrasilAPIResponse.nome_fantasia == null);
		System.assert(objBrasilAPIResponse.capital_social == null);
		System.assert(objBrasilAPIResponse.ddd_telefone_1 == null);
		System.assert(objBrasilAPIResponse.ddd_telefone_2 == null);
		System.assert(objBrasilAPIResponse.opcao_pelo_mei == null);
		System.assert(objBrasilAPIResponse.descricao_porte == null);
		System.assert(objBrasilAPIResponse.codigo_municipio == null);
		System.assert(objBrasilAPIResponse.cnaes_secundarios == null);
		System.assert(objBrasilAPIResponse.natureza_juridica == null);
		System.assert(objBrasilAPIResponse.situacao_especial == null);
		System.assert(objBrasilAPIResponse.opcao_pelo_simples == null);
		System.assert(objBrasilAPIResponse.situacao_cadastral == null);
		System.assert(objBrasilAPIResponse.data_opcao_pelo_mei == null);
		System.assert(objBrasilAPIResponse.data_exclusao_do_mei == null);
		System.assert(objBrasilAPIResponse.cnae_fiscal_descricao == null);
		System.assert(objBrasilAPIResponse.codigo_municipio_ibge == null);
		System.assert(objBrasilAPIResponse.data_inicio_atividade == null);
		System.assert(objBrasilAPIResponse.data_situacao_especial == null);
		System.assert(objBrasilAPIResponse.data_opcao_pelo_simples == null);
		System.assert(objBrasilAPIResponse.data_situacao_cadastral == null);
		System.assert(objBrasilAPIResponse.nome_cidade_no_exterior == null);
		System.assert(objBrasilAPIResponse.codigo_natureza_juridica == null);
		System.assert(objBrasilAPIResponse.data_exclusao_do_simples == null);
		System.assert(objBrasilAPIResponse.motivo_situacao_cadastral == null);
		System.assert(objBrasilAPIResponse.ente_federativo_responsavel == null);
		System.assert(objBrasilAPIResponse.identificador_matriz_filial == null);
		System.assert(objBrasilAPIResponse.qualificacao_do_responsavel == null);
		System.assert(objBrasilAPIResponse.descricao_situacao_cadastral == null);
		System.assert(objBrasilAPIResponse.descricao_tipo_de_logradouro == null);
		System.assert(objBrasilAPIResponse.descricao_motivo_situacao_cadastral == null);
		System.assert(objBrasilAPIResponse.descricao_identificador_matriz_filial == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		BrasilAPIResponse.Qsa objQsa = new BrasilAPIResponse.Qsa(System.JSON.createParser(json));
		System.assert(objQsa != null);
		System.assert(objQsa.pais == null);
		System.assert(objQsa.nome_socio == null);
		System.assert(objQsa.codigo_pais == null);
		System.assert(objQsa.faixa_etaria == null);
		System.assert(objQsa.cnpj_cpf_do_socio == null);
		System.assert(objQsa.qualificacao_socio == null);
		System.assert(objQsa.codigo_faixa_etaria == null);
		System.assert(objQsa.data_entrada_sociedade == null);
		System.assert(objQsa.identificador_de_socio == null);
		System.assert(objQsa.cpf_representante_legal == null);
		System.assert(objQsa.nome_representante_legal == null);
		System.assert(objQsa.codigo_qualificacao_socio == null);
		System.assert(objQsa.qualificacao_representante_legal == null);
		System.assert(objQsa.codigo_qualificacao_representante_legal == null);
	}
}