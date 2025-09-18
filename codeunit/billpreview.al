codeunit 50344 "Bill Preview Helper"
{
    procedure PreviewBill(var Rec: Record expenseClaim)
    var
       TempBlob: Codeunit "Temp Blob";
    InStr: InStream;
    OutStr: OutStream;
    FileName: Text;
    FileMgt: Codeunit "File Management";
    ClientFileName: Text;
    begin
        if Rec."Bill".HasValue then begin
            Rec.CalcFields("Bill");
            Rec."Bill".CreateInStream(InStr);
            TempBlob.CreateOutStream(OutStr);
            CopyStream(OutStr, InStr);
            FileName := 'BillPreview.pdf';
            
           
            // If PDF → open PDF viewer
             // Export to client temp folder
    
  
    // Open in browser / default PDF viewer
    Hyperlink(ClientFileName);
        end else
            Error('No bill attachment available for preview.');
    end;
}
