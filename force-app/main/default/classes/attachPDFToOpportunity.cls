public class attachPDFToOpportunity {
    private final Opp_OrderController oppController;

    public attachPDFToOpportunity(Opp_OrderController oppController) {
        this.oppController = oppController;
    }

    public PageReference attachPDF() {
        PageReference pdfPage = Page.PDFPedido;
        Blob pdfBlob;

        if (!Test.isRunningTest()) {
            pdfBlob = pdfPage.getContent();
        } else {
            pdfBlob = Blob.valueOf('Some Text for a boring PDF file...');
        }

        Attachment attach = new Attachment(
            parentId = oppController.opportunity.Id,
            Name = 'pdfAttachmentDemo.pdf',
            body = pdfBlob
        );

        insert attach;

        PageReference redirectPage = new ApexPages.StandardController(oppController.opportunity).view();
        redirectPage.setRedirect(true);

        return redirectPage;
    }
}