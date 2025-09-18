codeunit 50189 "PDF Helper"
{
    SingleInstance = true;

    procedure BlobToBase64(InS: InStream): Text
    var
        TempBlob: Codeunit "Temp Blob";  
        OutS: OutStream;
        NewInS: InStream;
        Base64Conv: Codeunit "Base64 Convert";
    begin
        // Copy the input stream into a temporary blob
        TempBlob.CreateOutStream(OutS);
        CopyStream(OutS, InS);

        // Get it back as an InStream
        TempBlob.CreateInStream(NewInS);

        // Convert to Base64
        exit(Base64Conv.ToBase64(NewInS));
    end;
}
