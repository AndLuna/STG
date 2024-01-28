/* 
Objetivo: Gerar respostas fictícias para simular chamadas de API em testes.
Descrição: Esta classe implementa a interface HttpCalloutMock e é utilizada para criar respostas simuladas com base no código de status fornecido.
A principal funcionalidade é evitar a chamada dos servidores da API diretamente na classe de teste
Criado por: contato.andreluna@gmail.om
*/
@isTest
public class MockHttpResponseGenerator implements HttpCalloutMock {
    private Integer statusCode;

    // Construtor para definir o código de status
    public MockHttpResponseGenerator(Integer statusCode) {
        this.statusCode = statusCode;
    }

    public HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');

        if (this.statusCode == 200) {
            res.setBody('{"cnpj":"19131243000197","nome_fantasia":"Nome Fantasia","razao_social":"Razao Social"}');
        } else if (this.statusCode == 400) {
            res.setBody('{"error": "Invalid CNPJ"}');
        }

        res.setStatusCode(this.statusCode);
        return res;
    }
}
