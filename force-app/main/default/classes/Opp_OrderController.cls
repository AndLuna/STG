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
    public PageReference pdfAction() {
        PageReference savepage;
        savepage = Page.PDFPedido;
        savepage.getParameters().put('id',MstrID);
        system.debug('id:- '+MstrID);
        BLOB pdfBlob;
        IF (!Test.isRunningTest()) {
            pdfBlob = savepage.getContent(); //generate the pdf BLOB
        } ELSE { 
            pdfBlob = BLOB.valueOf('Test');
        }
    
        // Create a new ContentVersion record
        ContentVersion conVer = new ContentVersion();
        conVer.ContentLocation = 'S'; // TO USE S specify this document IS IN Salesforce, TO USE E FOR external files
        conVer.PathOnClient = 'myFile.pdf'; 
        conVer.Title = 'My File'; 
        conVer.VersionData = pdfBlob;
        system.debug('conVer@@ ' + conVer);
        insert conVer;  
    
        // Create a new ContentDocumentLink record
        Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:conVer.Id].ContentDocumentId;
        ContentDocumentLink conDocLink = new ContentDocumentLink();
        conDocLink.LinkedEntityId = MstrID;
        conDocLink.ContentDocumentId = conDoc; 
        conDocLink.shareType = 'V';
        insert conDocLink;
    
        return savepage;
    }
}