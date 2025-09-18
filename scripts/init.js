function InitPDF() {
    // Get the ControlAddIn context
    var pdfBlob = Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("GetBlobBase64", [], true);

    if (pdfBlob) {
        var pdfData = 'data:application/pdf;base64,' + pdfBlob;
        var container = document.getElementById("pdfContainer");

        if (!container) {
            container = document.createElement('div');
            container.id = "pdfContainer";
            container.style.width = '100%';
            container.style.height = '600px'; // Adjust height as needed
            document.body.appendChild(container);
        }

        PDFObject.embed(pdfData, "#pdfContainer");
    }
}
