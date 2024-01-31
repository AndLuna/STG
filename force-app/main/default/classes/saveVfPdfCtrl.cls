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

    public PageReference Cancel() {
        PageReference Pdf = new PageReference('/'+MstrID);
        Pdf.setRedirect(true);
        return Pdf;
    }
    
    public saveVfPdfCtrl(ApexPages.StandardController Controller) {
        baseURL = Url.getOrgDomainURL().toExternalForm();
        MstrId = ApexPages.currentPage().getParameters().get('id');
        oppObj = [SELECT Id, Name, Email__c FROM Opportunity WHERE Id = :MstrId];
        String OpportunityId = getIdNaURL();
        produtosDaOpp = getProdutosDaOpp(OpportunityId);
        opportunity = getOpp(OpportunityId);
    }

    public String getIdNaURL() {
        return ApexPages.currentPage().getParameters().get('id');
    }
    
    public Opportunity getOpp(String OpportunityId) {
        List<Opportunity> opportunities = [SELECT name, DAT_Data_Inicio__c, Amount, DAT_Data_Fim__c, 
                                           TXTL_Detalhamento_do_projeto__c, PKL_novoCliente__c, Email__c,
                                           FRM_Logotipo__c, CreatedDate
                               FROM Opportunity WHERE Id = :OpportunityId]; 
        return opportunities.get(0);
    }
    
    public List<OpportunityLineItem> getProdutosDaOpp(String OpportunityId) {
        List<OpportunityLineItem> items = [SELECT Product2.Name, Quantity,
                                 Product2.ProductCode, UnitPrice, FRM_Custo_total__c,
                                 FRM_Receita_Total__c, Product_img__c
                                 FROM OpportunityLineItem WHERE OpportunityId = :OpportunityId];
      
        return items;
    }

    public PageReference saveAction() {
        PageReference savepage = Page.savePdfVp;
        savepage.getParameters().put('id', MstrId);
        Blob pdfBlob;

        if (!Test.isRunningTest()) {
            pdfBlob = savepage.getContent(); // Gera o PDF BLOB
        } else { 
            pdfBlob = Blob.valueOf('Test');
        }

        List<ContentDocumentLink> notesattch = [SELECT Id, ContentDocument.Title, LinkedEntityId 
                                               FROM ContentDocumentLink 
                                               WHERE LinkedEntityId = :MstrId 
                                               ORDER BY ContentDocument.Title ASC];

        if (notesattch.size() > 0) {
            String title = notesattch[0].ContentDocument.Title;
            List<String> titleSplit = title.split('R');
           // String FinalTitle = 'PO' + notesattch.size();
           String FinalTitle = 'Cotação';

            PDFNo = FinalTitle;

            ContentVersion conVer = new ContentVersion();
            conVer.ContentLocation = 'S'; 
            conVer.PathOnClient = FinalTitle + '.pdf'; 
            conVer.Title = FinalTitle; 
            conVer.VersionData = pdfBlob;
            INSERT conVer;  
    
            Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :conVer.Id].ContentDocumentId;
    
            ContentDocumentLink conDocLink = new ContentDocumentLink();
            conDocLink.LinkedEntityId = MstrId;
            conDocLink.ContentDocumentId = conDoc; 
            conDocLink.shareType = 'V';
            INSERT conDocLink;
            UPDATE oppObj;
    
            PageReference pageRef = new PageReference(baseURL + '/lightning/r/Opportunity/' + 
                                                      System.currentPageReference().getParameters().get('id') + '/view');
            pageRef.setRedirect(true);

            return pageRef;
        } else {
            return null;
        }
    }

    public PageReference saveAndEmailAction() {
        PageReference savepage = Page.savePdfVp;
        savepage.getParameters().put('id', MstrId);
        Blob pdfBlob;

        if (!Test.isRunningTest()) {
            pdfBlob = savepage.getContent(); 
        } else { 
            pdfBlob = Blob.valueOf('Test');
        }

        List<ContentDocumentLink> notesattch = [SELECT Id, ContentDocument.Title, LinkedEntityId 
                                               FROM ContentDocumentLink 
                                               WHERE LinkedEntityId = :MstrId 
                                               ORDER BY ContentDocument.Title ASC];

        if (notesattch.size() > 0) {
            String title = notesattch[0].ContentDocument.Title;
            List<String> titleSplit = title.split('R');
            String FinalTitle = 'PO' + notesattch.size();

            PDFNo = FinalTitle;

            ContentVersion conVer = new ContentVersion();
            conVer.ContentLocation = 'S'; 
            conVer.PathOnClient = FinalTitle + '.pdf'; 
            conVer.Title = FinalTitle; 
            conVer.VersionData = pdfBlob;
            INSERT conVer;  
    
            Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :conVer.Id].ContentDocumentId;
    
            ContentDocumentLink conDocLink = new ContentDocumentLink();
            conDocLink.LinkedEntityId = MstrId;
            conDocLink.ContentDocumentId = conDoc; 
            conDocLink.shareType = 'V';
            INSERT conDocLink;
            UPDATE oppObj;
    
            PageReference pageRef = new PageReference(baseURL + '/lightning/r/Opportunity/' + 
                                                      System.currentPageReference().getParameters().get('id') + '/view');
            pageRef.setRedirect(true);

            
            Messaging.SingleEmailMessage emailToSend = sendEmail();
            Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{emailToSend});

            return pageRef;
        } else {
            return null;
        }
    }

    public Messaging.SingleEmailMessage sendEmail() {
        PageReference pdfPage = Page.savePdfVp;
        pdfPage.getParameters().put('id', MstrId);
        Blob pdfBlob;

        if (!Test.isRunningTest()) {
            pdfBlob = pdfPage.getContent(); 
        } else {
            pdfBlob = Blob.valueOf('Test');
        }

        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 
        email.setSubject('Stage - Oportunidade Documento');  
        email.setToAddresses(new List<String>{opportunity.Email__c});  
        email.setPlainTextBody('Parabens, nossa transação está chegando para o caminho final, este é o documento resultante das negociações.');  // Substitua pelo corpo do e-mail desejado

        Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
        attachment.setFileName('CotaçãoDeOportunidade.pdf');
        attachment.setBody(pdfBlob);
        email.setFileAttachments(new List<Messaging.EmailFileAttachment>{attachment});

        return email;
    }
}