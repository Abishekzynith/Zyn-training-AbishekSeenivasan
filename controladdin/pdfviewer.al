controladdin "PDFViewer"
{
    Scripts = 'scripts/init.js';
    StartupScript = 'scripts/init.js'; // Your own JS file in the project
    RequestedHeight = 600;
    RequestedWidth = 800;

    // Define interface for AL to JS communication
    procedure Load(Base64Pdf: Text);
}
