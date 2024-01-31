public class CNPJValidator {

    @InvocableMethod(Label='Validação CNPJ' description='Realiza integração com BrasilAPI para validar CNPJ e retornar informações detalhadas')
    public static List<CNPJInfo> validateCNPJ(List<String> cnpjs) { 
        List<CNPJInfo> returnValue = new List<CNPJInfo>();
        for (String cnpj : cnpjs) {
            returnValue.add(sendRequest(cnpj));
        }
        return returnValue;
    }

    public static CNPJInfo sendRequest(String cnpj) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://brasilapi.com.br/api/cnpj/' + cnpj);
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/json');
        req.setTimeout(120000);

        try {
            Http h = new Http();
            HttpResponse res = h.send(req);            
            if (res.getStatusCode() == 200) {
                return (CNPJInfo) JSON.deserialize(res.getBody(), CNPJInfo.class);
            }
        } catch (Exception e) {
            return null;
        }

        return null;
    }

    public class CNPJInfo {
        @InvocableVariable
        public String cnpj;
        @InvocableVariable
        public String razao_social;
        @InvocableVariable
        public String nome_comercial;
    }
}