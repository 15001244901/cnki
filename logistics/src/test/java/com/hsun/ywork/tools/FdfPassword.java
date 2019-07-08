package com.hsun.ywork.tools;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Element;
import com.itextpdf.text.pdf.*;
import org.junit.Test;

import java.io.File;
import java.io.FileOutputStream;

/**
 * Created by Administrator on 2017-03-24 .
 */
public class FdfPassword {
    @Test
    public void addWaterMark() throws Exception{
        String srcFile="D:\\update\\test.pdf";//要添加水印的文件
        String text="系统集成公司";//要添加水印的内容
        int textWidth=200;
        int textHeight=440;
        PdfReader reader = new PdfReader(srcFile);// 待加水印的文件
        PdfStamper stamper = new PdfStamper(reader, new FileOutputStream(new File("D:\\update\\testpass.pdf")));// 加完水印的文件
//          byte[] userPassword = "123".getBytes();
        byte[] ownerPassword = "12345".getBytes();
//          int permissions = PdfWriter.ALLOW_COPY|PdfWriter.ALLOW_MODIFY_CONTENTS|PdfWriter.ALLOW_PRINTING;
//          stamper.setEncryption(null, ownerPassword, permissions,false);
        stamper.setEncryption(null, ownerPassword, PdfWriter.ALLOW_ASSEMBLY, false);
        stamper.setEncryption(null, ownerPassword, PdfWriter.ALLOW_COPY, false);
        stamper.setEncryption(null, ownerPassword, PdfWriter.ALLOW_DEGRADED_PRINTING, false);
        stamper.setEncryption(null, ownerPassword, PdfWriter.ALLOW_FILL_IN, false);
        stamper.setEncryption(null, ownerPassword, PdfWriter.ALLOW_MODIFY_ANNOTATIONS, false);
        stamper.setEncryption(null, ownerPassword, PdfWriter.ALLOW_MODIFY_CONTENTS, false);
        stamper.setEncryption(null, ownerPassword, PdfWriter.ALLOW_PRINTING, false);
        stamper.setEncryption(null, ownerPassword, PdfWriter.ALLOW_SCREENREADERS, false);
        stamper.setEncryption(null, ownerPassword, PdfWriter.DO_NOT_ENCRYPT_METADATA, false);
        stamper.  setViewerPreferences(PdfWriter.HideToolbar|PdfWriter.HideMenubar);
//          stamper.setViewerPreferences(PdfWriter.HideWindowUI);
        int total = reader.getNumberOfPages() + 1;
        PdfContentByte content;
        BaseFont font = BaseFont.createFont("C:\\WINDOWS\\Fonts\\simkai.ttf", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
        for (int i = 1; i < total; i++)// 循环对每页插入水印
        {
            content = stamper.getUnderContent(i);// 水印的起始
            content.beginText();// 开始
            content.setColorFill(BaseColor.GREEN);// 设置颜色 默认为蓝色
            content.setFontAndSize(font, 38);// 设置字体及字号
            content.setTextMatrix(textWidth, textHeight);// 设置起始位置
            content.showTextAligned(Element.ALIGN_LEFT, text, textWidth, textHeight, 45);// 开始写入水印
            content.endText();
        }
        stamper.close();
    }
}
