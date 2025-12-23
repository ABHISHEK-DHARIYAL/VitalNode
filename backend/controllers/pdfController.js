const PDFDocument = require("pdfkit");
const db = require("../db/db");

exports.generateInvoice = async (req, res) => {
  const { id } = req.params;
  try {
    const [bill] = await db.query(
      `SELECT b.*, p.first_name, p.last_name 
       FROM billing b 
       JOIN patients p ON b.patient_id = p.patient_id 
       WHERE b.bill_id = ?`,
      [id]
    );

    if (!bill.length) return res.status(404).send("Invoice not found");

    const doc = new PDFDocument();
    res.setHeader("Content-Type", "application/pdf");
    res.setHeader(
      "Content-Disposition",
      `attachment; filename=Invoice_${id}.pdf`
    );

    doc.pipe(res);
    doc.fontSize(20).text("CITY HOSPITAL - INVOICE", { align: "center" });
    doc.moveDown();
    doc
      .fontSize(12)
      .text(`Patient: ${bill[0].first_name} ${bill[0].last_name}`);
    doc.text(`Bill ID: ${bill[0].bill_id}`);
    doc.text(`Date: ${new Date(bill[0].date_issued).toLocaleDateString()}`);
    doc.moveDown();
    doc.text("------------------------------------------");
    doc
      .fontSize(16)
      .text(`TOTAL AMOUNT: $${bill[0].amount}`, { align: "right" });
    doc.text(`STATUS: ${bill[0].status}`, { align: "right" });
    doc.end();
  } catch (err) {
    res.status(500).send("Error generating PDF");
  }
};
