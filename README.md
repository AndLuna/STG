Arquitetura do Sistema
Leads:

A solução é composta por várias classes no Salesforce que trabalham em conjunto para integrar informações da Receita Federal aos registros de Leads. Aqui está uma descrição detalhada de cada componente:

CNPJ_Lead:
Objetivo: Responsável por fazer a integração com a API da Receita Federal para obter informações detalhadas sobre um CNPJ e atualizar os registros de Lead correspondentes.
Funcionalidades:
get(String CNPJ, ID leadId): Realiza uma chamada à API da Receita Federal para obter informações detalhadas e atualiza o Lead correspondente.

ProcessLeads:
Objetivo: Evita erros de callout nas triggers, onde chamadas a serviços externos (como APIs) não são permitidas.
Funcionalidades:
execute(QueueableContext context): Processa Leads por meio de chamadas ao método get da classe CNPJ_Lead após a inserção.

Lead_createTask:
Objetivo: Cria tarefas para Leads recém-criados para garantir um acompanhamento adequado.
Funcionalidades:
createTask(List<Lead> newLeads): Cria uma tarefa para cada Lead recém-criado.

MockHttpResponseGenerator:
Objetivo: Evita chamadas reais à API da Receita Federal durante testes, fornecendo respostas simuladas.
Funcionalidades:
respond(HTTPRequest req): Gera respostas simuladas com base no código de status fornecido.

BrasilAPIResponse:
Objetivo: Mapeia a resposta JSON da API da Receita Federal para uma estrutura Apex utilizável.
Funcionalidades:
Classe interna Cnaes_secundarios: Mapeia informações sobre CNAEs secundários.
Classe interna Qsa: Mapeia informações sobre Quadro Societário.
parse(String json): Converte o JSON da API em uma instância utilizável.

LeadHandler (Trigget e Handler):
Objetivo: Trata eventos relacionados a Leads e aciona as lógicas correspondentes.
Funcionalidades:
handleLeadChanges(List<Lead> newLeads, Map<Id, Lead> oldLeadMap): Gerencia as mudanças nos Leads e aciona as lógicas apropriadas.
Relacionamentos:

CNPJ_Lead se comunica com ProcessLeads para evitar chamadas diretas a serviços externos em triggers.
CNPJ_Lead e ProcessLeads são acionados por eventos relacionados a Leads.
Lead_createTask é independente, mas pode ser chamado após a criação de Leads para criar tarefas de acompanhamento.
MockHttpResponseGenerator é usado durante os testes para simular respostas da API da Receita Federal.
BrasilAPIResponse é uma classe de utilidade usada por CNPJ_Lead para mapear respostas JSON da API.
Fluxo Típico de Execução:

Trigger LeadTrigger: Aciona LeadHandler para processar mudanças nos Leads.
LeadHandler:
Aciona ProcessLeads para processar Leads recém-inseridos.
Aciona CNPJ_Lead para obter informações da Receita Federal e atualizar os Leads.
ProcessLeads: Enfileira trabalhos para processamento em segundo plano para evitar erros de callout.
CNPJ_Lead:
Integra-se com a API da Receita Federal.
Atualiza os Leads com informações obtidas.
Lead_createTask: Opcionalmente, cria tarefas para os Leads.
Essa arquitetura modular torna o sistema mais flexível, permitindo futuras expansões ou alterações sem a necessidade de modificar extensivamente o código existente. Além disso, facilita a manutenção e os testes.