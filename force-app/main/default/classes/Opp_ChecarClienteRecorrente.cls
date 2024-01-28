public with sharing class Opp_ChecarClienteRecorrente {
    public static void run(List<Opportunity> oportunidades) {
        Set<Id> idsContas = new Set<Id>();

        for (Opportunity opp : oportunidades) {
            if (opp.AccountId != null) {
                idsContas.add(opp.AccountId);
            }
        }

        Map<Id, Integer> contagemOportunidadesPorConta = new Map<Id, Integer>();

        for (AggregateResult result : [
            SELECT AccountId, COUNT(Id) numOportunidades
            FROM Opportunity
            WHERE AccountId IN :idsContas
            GROUP BY AccountId
        ]) {
            contagemOportunidadesPorConta.put((Id)result.get('AccountId'), (Integer)result.get('numOportunidades'));
        }

        for (Opportunity opp : oportunidades) {
            if (opp.AccountId != null) {
                Integer numOportunidades = contagemOportunidadesPorConta.get(opp.AccountId);

                if (numOportunidades == null || numOportunidades == 0) {
                    opp.PKL_novoCliente__c = 'Sim';
                } else {
                    opp.PKL_novoCliente__c = 'Não';
                }
            }else{
                opp.PKL_novoCliente__c = 'Sim';
            }
        }
    }
}