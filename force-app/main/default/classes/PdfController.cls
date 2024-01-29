public class PdfController {
    @AuraEnabled
    public static void generateAndSavePdf(String opportunityId) {
        saveVfPdfCtrl controller = new saveVfPdfCtrl(new ApexPages.StandardController(new Opportunity(Id = opportunityId)));
        controller.pdfAction();
    }
}
