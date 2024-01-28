/* 
Objetivo: Representar a resposta da API de consulta de CNPJ em formato JSON.
Descrição: Esta classe é gerada automaticamente e utilizada para parsear a resposta da API em objetos do Salesforce.
Criado por: JSON2Apex http://json2apex.herokuapp.com/
*/
public class BrasilAPIResponse {

	public class Cnaes_secundarios {
		public Integer codigo {get;set;} 
		public String descricao {get;set;} 

		public Cnaes_secundarios(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'codigo') {
							codigo = parser.getIntegerValue();
						} else if (text == 'descricao') {
							descricao = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Cnaes_secundarios consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public String uf {get;set;} 
	public String cep {get;set;} 
	public List<Qsa> qsa {get;set;} 
	public String cnpj {get;set;} 
	public Object pais {get;set;} 
	public Object email {get;set;} 
	public String porte {get;set;} 
	public String bairro {get;set;} 
	public String numero {get;set;} 
	public String ddd_fax {get;set;} 
	public String municipio {get;set;} 
	public String logradouro {get;set;} 
	public Integer cnae_fiscal {get;set;} 
	public Object codigo_pais {get;set;} 
	public String complemento {get;set;} 
	public Integer codigo_porte {get;set;} 
	public String razao_social {get;set;} 
	public String nome_fantasia {get;set;} 
	public Integer capital_social {get;set;} 
	public String ddd_telefone_1 {get;set;} 
	public String ddd_telefone_2 {get;set;} 
	public Object opcao_pelo_mei {get;set;} 
	public String descricao_porte {get;set;} 
	public Integer codigo_municipio {get;set;} 
	public List<Cnaes_secundarios> cnaes_secundarios {get;set;} 
	public String natureza_juridica {get;set;} 
	public String situacao_especial {get;set;} 
	public Object opcao_pelo_simples {get;set;} 
	public Integer situacao_cadastral {get;set;} 
	public Object data_opcao_pelo_mei {get;set;} 
	public Object data_exclusao_do_mei {get;set;} 
	public String cnae_fiscal_descricao {get;set;} 
	public Integer codigo_municipio_ibge {get;set;} 
	public String data_inicio_atividade {get;set;} 
	public Object data_situacao_especial {get;set;} 
	public Object data_opcao_pelo_simples {get;set;} 
	public String data_situacao_cadastral {get;set;} 
	public String nome_cidade_no_exterior {get;set;} 
	public Integer codigo_natureza_juridica {get;set;} 
	public Object data_exclusao_do_simples {get;set;} 
	public Integer motivo_situacao_cadastral {get;set;} 
	public String ente_federativo_responsavel {get;set;} 
	public Integer identificador_matriz_filial {get;set;} 
	public Integer qualificacao_do_responsavel {get;set;} 
	public String descricao_situacao_cadastral {get;set;} 
	public String descricao_tipo_de_logradouro {get;set;} 
	public String descricao_motivo_situacao_cadastral {get;set;} 
	public String descricao_identificador_matriz_filial {get;set;} 

	public BrasilAPIResponse(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'uf') {
						uf = parser.getText();
					} else if (text == 'cep') {
						cep = parser.getText();
					} else if (text == 'qsa') {
						qsa = arrayOfQsa(parser);
					} else if (text == 'cnpj') {
						cnpj = parser.getText();
					} else if (text == 'pais') {
						pais = parser.readValueAs(Object.class);
					} else if (text == 'email') {
						email = parser.readValueAs(Object.class);
					} else if (text == 'porte') {
						porte = parser.getText();
					} else if (text == 'bairro') {
						bairro = parser.getText();
					} else if (text == 'numero') {
						numero = parser.getText();
					} else if (text == 'ddd_fax') {
						ddd_fax = parser.getText();
					} else if (text == 'municipio') {
						municipio = parser.getText();
					} else if (text == 'logradouro') {
						logradouro = parser.getText();
					} else if (text == 'cnae_fiscal') {
						cnae_fiscal = parser.getIntegerValue();
					} else if (text == 'codigo_pais') {
						codigo_pais = parser.readValueAs(Object.class);
					} else if (text == 'complemento') {
						complemento = parser.getText();
					} else if (text == 'codigo_porte') {
						codigo_porte = parser.getIntegerValue();
					} else if (text == 'razao_social') {
						razao_social = parser.getText();
					} else if (text == 'nome_fantasia') {
						nome_fantasia = parser.getText();
					} else if (text == 'capital_social') {
						capital_social = parser.getIntegerValue();
					} else if (text == 'ddd_telefone_1') {
						ddd_telefone_1 = parser.getText();
					} else if (text == 'ddd_telefone_2') {
						ddd_telefone_2 = parser.getText();
					} else if (text == 'opcao_pelo_mei') {
						opcao_pelo_mei = parser.readValueAs(Object.class);
					} else if (text == 'descricao_porte') {
						descricao_porte = parser.getText();
					} else if (text == 'codigo_municipio') {
						codigo_municipio = parser.getIntegerValue();
					} else if (text == 'cnaes_secundarios') {
						cnaes_secundarios = arrayOfCnaes_secundarios(parser);
					} else if (text == 'natureza_juridica') {
						natureza_juridica = parser.getText();
					} else if (text == 'situacao_especial') {
						situacao_especial = parser.getText();
					} else if (text == 'opcao_pelo_simples') {
						opcao_pelo_simples = parser.readValueAs(Object.class);
					} else if (text == 'situacao_cadastral') {
						situacao_cadastral = parser.getIntegerValue();
					} else if (text == 'data_opcao_pelo_mei') {
						data_opcao_pelo_mei = parser.readValueAs(Object.class);
					} else if (text == 'data_exclusao_do_mei') {
						data_exclusao_do_mei = parser.readValueAs(Object.class);
					} else if (text == 'cnae_fiscal_descricao') {
						cnae_fiscal_descricao = parser.getText();
					} else if (text == 'codigo_municipio_ibge') {
						codigo_municipio_ibge = parser.getIntegerValue();
					} else if (text == 'data_inicio_atividade') {
						data_inicio_atividade = parser.getText();
					} else if (text == 'data_situacao_especial') {
						data_situacao_especial = parser.readValueAs(Object.class);
					} else if (text == 'data_opcao_pelo_simples') {
						data_opcao_pelo_simples = parser.readValueAs(Object.class);
					} else if (text == 'data_situacao_cadastral') {
						data_situacao_cadastral = parser.getText();
					} else if (text == 'nome_cidade_no_exterior') {
						nome_cidade_no_exterior = parser.getText();
					} else if (text == 'codigo_natureza_juridica') {
						codigo_natureza_juridica = parser.getIntegerValue();
					} else if (text == 'data_exclusao_do_simples') {
						data_exclusao_do_simples = parser.readValueAs(Object.class);
					} else if (text == 'motivo_situacao_cadastral') {
						motivo_situacao_cadastral = parser.getIntegerValue();
					} else if (text == 'ente_federativo_responsavel') {
						ente_federativo_responsavel = parser.getText();
					} else if (text == 'identificador_matriz_filial') {
						identificador_matriz_filial = parser.getIntegerValue();
					} else if (text == 'qualificacao_do_responsavel') {
						qualificacao_do_responsavel = parser.getIntegerValue();
					} else if (text == 'descricao_situacao_cadastral') {
						descricao_situacao_cadastral = parser.getText();
					} else if (text == 'descricao_tipo_de_logradouro') {
						descricao_tipo_de_logradouro = parser.getText();
					} else if (text == 'descricao_motivo_situacao_cadastral') {
						descricao_motivo_situacao_cadastral = parser.getText();
					} else if (text == 'descricao_identificador_matriz_filial') {
						descricao_identificador_matriz_filial = parser.getText();
					} else {
						System.debug(LoggingLevel.WARN, 'BrasilAPIResponse consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class Qsa {
		public Object pais {get;set;} 
		public String nome_socio {get;set;} 
		public Object codigo_pais {get;set;} 
		public String faixa_etaria {get;set;} 
		public String cnpj_cpf_do_socio {get;set;} 
		public String qualificacao_socio {get;set;} 
		public Integer codigo_faixa_etaria {get;set;} 
		public String data_entrada_sociedade {get;set;} 
		public Integer identificador_de_socio {get;set;} 
		public String cpf_representante_legal {get;set;} 
		public String nome_representante_legal {get;set;} 
		public Integer codigo_qualificacao_socio {get;set;} 
		public String qualificacao_representante_legal {get;set;} 
		public Integer codigo_qualificacao_representante_legal {get;set;} 

		public Qsa(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'pais') {
							pais = parser.readValueAs(Object.class);
						} else if (text == 'nome_socio') {
							nome_socio = parser.getText();
						} else if (text == 'codigo_pais') {
							codigo_pais = parser.readValueAs(Object.class);
						} else if (text == 'faixa_etaria') {
							faixa_etaria = parser.getText();
						} else if (text == 'cnpj_cpf_do_socio') {
							cnpj_cpf_do_socio = parser.getText();
						} else if (text == 'qualificacao_socio') {
							qualificacao_socio = parser.getText();
						} else if (text == 'codigo_faixa_etaria') {
							codigo_faixa_etaria = parser.getIntegerValue();
						} else if (text == 'data_entrada_sociedade') {
							data_entrada_sociedade = parser.getText();
						} else if (text == 'identificador_de_socio') {
							identificador_de_socio = parser.getIntegerValue();
						} else if (text == 'cpf_representante_legal') {
							cpf_representante_legal = parser.getText();
						} else if (text == 'nome_representante_legal') {
							nome_representante_legal = parser.getText();
						} else if (text == 'codigo_qualificacao_socio') {
							codigo_qualificacao_socio = parser.getIntegerValue();
						} else if (text == 'qualificacao_representante_legal') {
							qualificacao_representante_legal = parser.getText();
						} else if (text == 'codigo_qualificacao_representante_legal') {
							codigo_qualificacao_representante_legal = parser.getIntegerValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Qsa consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	
	public static BrasilAPIResponse parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new BrasilAPIResponse(parser);
	}
	
	public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;
		do {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}
	

    private static List<Cnaes_secundarios> arrayOfCnaes_secundarios(System.JSONParser p) {
        List<Cnaes_secundarios> res = new List<Cnaes_secundarios>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Cnaes_secundarios(p));
        }
        return res;
    }







    private static List<Qsa> arrayOfQsa(System.JSONParser p) {
        List<Qsa> res = new List<Qsa>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Qsa(p));
        }
        return res;
    }


}