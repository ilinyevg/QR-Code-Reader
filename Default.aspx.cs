using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZXing;
using ZXing.Common;
using ZXing.QrCode;

namespace WebApplication3
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {  
            btnGenerate.Click += Generate_Click;
            btnRead.Click += Read_Click;
            btnReadFromWebcam.Click += ReadFromWebcam_Click;
        }

        void ReadFromWebcam_Click(object sender, EventArgs e)
        {
            var reader = new BarcodeReader();
            var parts = imageData.Value.Split(new char[] { ',' }, 2);
            var bytes = Convert.FromBase64String(parts[1]);
            Stream stream = new MemoryStream(bytes);
            System.Drawing.Image returnImage = System.Drawing.Image.FromStream(stream);
            var result = reader.Decode(new Bitmap(returnImage));
            if (result != null)
            {
                lblResult.Text = result.ToString(); 
            }
            else
            {
                lblResult.Text = "Попробуйте еще раз";
            }
            
        }

        //Чтение штрих-кода
        void Read_Click(object sender, EventArgs e)
        {
            var reader = new BarcodeReader(); 
            System.Drawing.Image returnImage = System.Drawing.Image.FromStream(fileUpload.FileContent);
            var result = reader.Decode(new Bitmap(returnImage));
            Response.Write(result.Text);
        }

        //Генерация штрих-кода
        void Generate_Click(object sender, EventArgs e)
        {
            var writer = new BarcodeWriter();
            //Формат штрих-кода = QR
            writer.Format = BarcodeFormat.QR_CODE;

            //Кодировка и размер штрих-кода
            EncodingOptions options = new QrCodeEncodingOptions
            {
                DisableECI = true,
                CharacterSet = "UTF-8",
                Width = 150,
                Height = 150
            };
                
            writer.Options = options;
            var result = writer.Write(TextBox1.Text);
            var barcodeBitmap = new Bitmap(result);
            barcodeBitmap.Save(Response.OutputStream, ImageFormat.Jpeg);
            Response.ContentType = "image/jpeg";
            Response.End();
           
        }

    }
}