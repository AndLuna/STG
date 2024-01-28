public class Opp_OrderController {
    public final Opportunity opportunity {get;set;}
    public final List<OpportunityLineItem> produtosDaOpp {get;set;}
    public Opp_OrderController(){
        String OpportunityId = getIdNaURL();
        opportunity = getOpp(OpportunityId);
        produtosDaOpp = getProdutosDaOpp(OpportunityId);
    }
    
    public String getIdNaURL(){
        return ApexPages.currentPage().getParameters().get('id');
    }
    
    public Opportunity getOpp(String OpportunityId){
        List<Opportunity> opportunities = [SELECT name, DAT_Data_Inicio__c, Amount, DAT_Data_Fim__c, TXTL_Detalhamento_do_projeto__c, PKL_novoCliente__c, FRM_Logotipo__c, CreatedDate

                               FROM Opportunity WHERE Id = :OpportunityId]; 
        return opportunities.get(0);
    }
    
    public List<OpportunityLineItem> getProdutosDaOpp(String OpportunityId){
        List<OpportunityLineItem> items = [SELECT Product2.Name, Quantity,
                                 Product2.ProductCode, UnitPrice, FRM_Custo_total__c,
                                 FRM_Receita_Total__c, Product_img__c
                                 FROM OpportunityLineItem WHERE OpportunityId = :OpportunityId
                                ];
      
        return items;
    }
}