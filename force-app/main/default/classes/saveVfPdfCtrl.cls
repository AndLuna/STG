public class saveVfPdfCtrl {
    public String MstrId{GET;SET;}
    public Opportunity oppObj{GET;SET;}
    
    public String PDFNo{GET;SET;}
    public String EFNo{GET;SET;}
    public BOOLEAN SHOW{GET;SET;}
    public BOOLEAN showpdf{GET;SET;}
    public ApexPages.PageReference page2{GET;SET;}
    public String baseURL{GET;SET;}
    public final Opportunity opportunity {get;set;}
    public final List<OpportunityLineItem> produtosDaOpp {get;set;}

    
    
    public PageReference Cancel()
    {
        PageReference Pdf = NEW PageReference('/'+MstrID);
        pdf.setredirect(TRUE);
        RETURN Pdf;
    }
    
    public saveVfPdfCtrl(ApexPages.StandardController Controller){
        baseURL = Url.getOrgDomainURL().toExternalForm();
        MstrId = ApexPages.currentPage().getParameters().get('id');
        oppObj = [SELECT Id, Name FROM Opportunity WHERE Id =: MstrId ];
        String OpportunityId = getIdNaURL();
        produtosDaOpp = getProdutosDaOpp(OpportunityId);
        opportunity = getOpp(OpportunityId);
    
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
    
    
    
    public PageReference pdfAction()
    {
        PageReference savepage ;
        savepage = Page.savePdfVp;
        savepage.getParameters().put('id',MstrID);
        system.debug('id:- '+MstrID);
        BLOB pdfBlob;
        IF (!Test.isRunningTest()) {
            pdfBlob = savepage.getContent(); //generate the pdf BLOB
        } else { 
            pdfBlob = BLOB.valueOf('Test');
        }
        List<ContentDocumentLink> notesattch = [SELECT id, ContentDocument.Title,LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId =: MstrID ORDER BY ContentDocument.Title ASC];    
        system.debug('notesattch## ' + notesattch);
        IF(notesattch.size() > 0)
        {
            string title =  notesattch[0].ContentDocument.Title;
            system.debug('title111 ' + title);
            List<String> titleSplit = title.split('R');
            //String FinalTitle = titleSplit[0]+'R0'+notesattch.size();
            String FinalTitle = 'PO'+notesattch.size();
            system.debug('FinalTitle22 ' + FinalTitle);
            PDFNo=FinalTitle;
    
            ContentVersion conVer = NEW ContentVersion();
            conVer.ContentLocation = 'S'; // TO USE S specify this document IS IN Salesforce, TO USE E FOR external files
            conVer.PathOnClient = FinalTitle+'.pdf'; 
            conVer.Title = FinalTitle; 
            conVer.VersionData = pdfBlob;
            system.debug('conVer@@ ' + conVer);
            INSERT conVer;  
    
            Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:conVer.Id].ContentDocumentId;
    
            ContentDocumentLink conDocLink = NEW ContentDocumentLink();
            conDocLink.LinkedEntityId = MstrID;
            conDocLink.ContentDocumentId = conDoc; 
            conDocLink.shareType = 'V';
            INSERT conDocLink;
            UPDATE oppObj;
    
             PageReference pageRef = NEW PageReference( baseURL+'/lightning/r/Opportunity/' + System.currentPageReference().getParameters().get('id')+'/view');
            pageRef.setRedirect(TRUE);
            //system.debug('pageRef@@@ ' + pageRef);
            RETURN pageRef;
    
        }
    
    
         else{RETURN NULL;}
    
    
    
    }
 
}