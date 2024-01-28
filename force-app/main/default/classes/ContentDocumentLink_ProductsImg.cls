/* 
Objetivo: Fixar imagem do produto pela anexação de arquivos, simplificando o processo.
Descrição: A classe gerencia os vínculos de documentos no Salesforce, atualizando dinamicamente
o campo Product_Image_ID__c no objeto Product2 com o ID do documento mais recente, enquanto considera 
apenas arquivos JPG ou PNG. 
*/
public class ContentDocumentLink_ProductsImg {
    public static void updateProductImageId(List<ContentDocumentLink> newContentDocumentLinks) {
        List<Product2> productsToUpdate = new List<Product2>();

        for (ContentDocumentLink cdl : newContentDocumentLinks) {
            if (cdl.LinkedEntityId != null && String.valueOf(cdl.LinkedEntityId).startsWith('01t')) {

                String productId = String.valueOf(cdl.LinkedEntityId).substring(0, 15);
                String contentDocumentId = cdl.ContentDocumentId;

     
                List<ContentVersion> contentVersions = [SELECT Id, FileExtension FROM ContentVersion WHERE ContentDocumentId = :contentDocumentId LIMIT 1];

                if (!contentVersions.isEmpty() && (contentVersions[0].FileExtension.equalsIgnoreCase('jpg') || contentVersions[0].FileExtension.equalsIgnoreCase('png'))) {
                    String contentVersionId = contentVersions[0].Id;

                    Product2 product = [SELECT Id, Product_Image_ID__c FROM Product2 WHERE Id = :productId LIMIT 1];
                    product.Product_Image_ID__c = contentVersionId;

                    productsToUpdate.add(product);
                }
            }
        }

        if (!productsToUpdate.isEmpty()) {
            update productsToUpdate;
        }
    }
}