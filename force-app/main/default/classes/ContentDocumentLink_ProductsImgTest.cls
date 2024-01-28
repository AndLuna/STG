@isTest
public class ContentDocumentLink_ProductsImgTest {
    @isTest
    public static void testProductImageUpdate() {
        Product2 testProduct = new Product2(
            Name = 'Test Product',
            Product_Image_ID__c = null,
            IsActive = true,
            ProductCode = 'z7115'
        );
        insert testProduct;

        ContentVersion testContentVersion = new ContentVersion(
            Title = 'Test File',
            PathOnClient = 'Test_File.jpg',
            VersionData = Blob.valueOf('Test file content'),
            IsMajorVersion = true
        );
        insert testContentVersion;

        ContentDocumentLink testContentDocumentLink = new ContentDocumentLink(
            ContentDocumentId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :testContentVersion.Id LIMIT 1].ContentDocumentId,
            LinkedEntityId = testProduct.Id,
            ShareType = 'I'
        );
        insert testContentDocumentLink;

        Product2 updatedProduct = [SELECT Product_Image_ID__c FROM Product2 WHERE Id = :testProduct.Id LIMIT 1];
        System.assertNotEquals(null, updatedProduct.Product_Image_ID__c, 'O campo Product_Image_ID__c ainda está nulo após a execução da lógica.');
    }
}