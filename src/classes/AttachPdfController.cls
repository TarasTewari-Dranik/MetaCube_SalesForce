public class AttachPdfController {
	
    private Student__c st;
    public AttachPdfController(ApexPages.StandardController controller){
        st = (Student__c)controller.getRecord();
    }
  
  	public PageReference savePdf() {
    	PageReference pdf = new PageReference('/apex/StudentDetailPdf?id='+st.Id);

    	Attachment attach = new Attachment();
    
   		 // the contents of the attachment from the pdf
    	Blob body;
    	body = pdf.getContent();

    
    	attach.Body = body;
    	attach.Name = 'StudentInformation.pdf';
    	attach.IsPrivate = false;
   		// attach the pdf to the account
    	attach.ParentId = st.Id;
        List<Attachment> existingAttachment = [SELECT Id FROM Attachment WHERE ParentId =:st.Id AND Name LIKE 'StudentInformation%'];
        if (existingAttachment.size()>0){
            delete existingAttachment;
        }
    	insert attach;
    
    	// send the user to the account to view results
    	
    	PageReference pageWhereWeWantToGo = new ApexPages.StandardController(st).view();
        pageWhereWeWantToGo.setRedirect(true);
        return pageWhereWeWantToGo;

  	}
}