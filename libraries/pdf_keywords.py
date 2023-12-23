import pdfquery
from robot.api.deco import keyword

@keyword("Convert PDF To XML Format")
def log_pdf_in_xml_format(pdf_path, xml_path):
    pdf = pdfquery.PDFQuery(pdf_path)
    pdf.load()
    pdf.tree.write(xml_path, pretty_print=True, encoding="utf-8")
    pdf.file.close()
    del pdf
    return True