page 50300 "Bill Preview Factbox"
{
    PageType = CardPart;
    SourceTable = expenseClaim;

    layout
    {
        area(content)
        {
           
            usercontrol(PDF; "PDFViewer")
            {
                ApplicationArea = All;

                
            }
             field("Bill Preview"; rec.Bill)
            {
                ApplicationArea = All;
                ShowCaption = false;
                ToolTip = 'Preview of the bill attachment.';

                // Important for image/PDF
               
            }
        }
        
    }


    trigger OnAfterGetRecord()
    var
        InS: InStream;
        PdfBase64: Text;
        PDFHelper: Codeunit "PDF Helper";
        fileurl:TextConst;
    
    begin
        if Rec.Bill.HasValue then begin
            Rec.Bill.CreateInStream(InS);
            PdfBase64 := PDFHelper.BlobToBase64(InS);
            CurrPage.PDF.Load(PdfBase64);
        end;
    end;
         trigger OnOpenPage();
    begin
        if Rec."Bill".HasValue then begin
         
            PDFViewerPart.Load(Rec."Emp ID" + '_' + Format(Rec."Bill") + '.' + Rec."File Ext");
           
        end;
    end;
      var
        PDFViewerPart: ControlAddIn "PDFViewer";

}
