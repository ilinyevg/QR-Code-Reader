<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication3._Default" %>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <section class="featured">
        <div class="content-wrapper">
          
        </div>
    </section>
</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <%--генерация штрих-кода --%>
    <asp:Label Text="Введите текст для кодировки:" runat="server" />
    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    <asp:Button ID="btnGenerate" runat="server" Text="Сгенерировать штрих-код" />
    <br />
    <%--чтение штрих-кода --%>
    <asp:Label ID="Label1" Text="Выберите изображение штрих-кода:" runat="server" />
    <asp:FileUpload ID="fileUpload" runat="server" />
    <asp:Button ID="btnRead" runat="server" Text="Прочитать штрих-код" /> 
    <br />
    <%--Захват изображения штрих-кода с web-камеры--%>
    <style type="text/css">
        .container {
            width: 320px;
            height: 240px;
            position: relative;
            border: 1px solid #d3d3d3;
            float: left;
        }
 
        .container video {
            width: 100%;
            height: 100%;
            position: absolute;
        }
 
        .container .photoArea {
            border: 2px dashed white;
            width: 140px;
            height: 140px;
            position: relative;
            margin: 0 auto;
            top: 40px;
        }
 
        canvas, img {
            float: left;
        }
 
        .controls {
            clear: both;
        }
    </style>
    <asp:Label ID="Label2" Text="Использование web-камеры для чтения штрих-кода" runat="server" />
    <br />
    <div class="container">
        <video autoplay></video>
        <div class="photoArea"></div>
    </div>
    <canvas width='140' height='190' style="border: 1px solid #d3d3d3;"></canvas>
    <img id="image1" runat="server" width="140" height="190" />
     
    <div class="controls">
        <input type="button" value="Включить web-камеру" onclick="startCapture()" /> 
        <input type="button" value="Выключить web-камеру" onclick="stopCapture()" />
        <input type="button" value="Сделать снимок" onclick="takePhoto()" />
        <asp:Button ID="btnReadFromWebcam" runat="server" Text="Прочитать штрих-код" OnClientClick="UploadData(); return true;" />
        <br />
        <asp:Label ID="Label3" Text="Результат чтения:" runat="server" />
        <asp:Label ID="lblResult" Text="" runat="server" />
        <asp:HiddenField Id="imageData" runat="server" ClientIDMode="Static"/> 
    </div>

     <script type="text/javascript">
         var localMediaStream = null;
         var video = document.querySelector('video');
         var canvas = document.querySelector('canvas');

         function OnSuccess(response) {
             alert(response);
         }
         function OnError(error) {
             alert(error);
         }

         function UploadData() {
             document.getElementById('imageData').value = document.querySelector('img').src;
         }

         function takePhoto() {
             if (localMediaStream) {
                 var ctx = canvas.getContext('2d');

                 // we double the source coordinates
                 ctx.drawImage(video, 180, 80, 280, 380, 0, 0, 140, 190);
                 document.querySelector('img').src = canvas.toDataURL('image/jpeg');
             }
         }

         navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia;
         window.URL = window.URL || window.webkitURL;

         function startCapture() {
             navigator.getUserMedia({ video: true }, function (stream) {
                 video.src = window.URL.createObjectURL(stream);
                 localMediaStream = stream;
             }, function (e) {
                 console.log(e);
             });
         }

         function stopCapture() {
             video.pause();
             localMediaStream.stop();
         }
     </script>
</asp:Content>
