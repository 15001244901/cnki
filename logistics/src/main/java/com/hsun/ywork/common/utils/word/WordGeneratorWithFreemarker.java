package com.hsun.ywork.common.utils.word;

import freemarker.core.ParseException;
import freemarker.template.Configuration;
import freemarker.template.MalformedTemplateNameException;
import freemarker.template.Template;

import java.io.*;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.Map;

/**
 * @Description:word导出帮助类 通过freemarker模板引擎来实现
 * @author:LiaoFei
 * @date :2016-3-24 下午3:49:25
 * @version V1.0
 * 
 */
public class WordGeneratorWithFreemarker {
	private static Configuration configuration = null;

	static {
		configuration = new Configuration(Configuration.VERSION_2_3_23);
		configuration.setDefaultEncoding("utf-8");
		configuration.setClassicCompatible(true);
		configuration.setClassForTemplateLoading(
				WordGeneratorWithFreemarker.class,
				"/templates/");

	}

	private WordGeneratorWithFreemarker() {

	}

	public static void createDoc(Map<String, Object> dataMap,String templateName, OutputStream out)throws Exception {
		Template t = configuration.getTemplate(templateName);
		t.setEncoding("utf-8");
		WordHtmlGeneratorHelper.handleAllObject(dataMap);

		try {
			Writer w = new OutputStreamWriter(out,Charset.forName("utf-8"));
			t.process(dataMap, w);
			w.close();
		} catch (Exception ex) {
			ex.printStackTrace();
			throw new RuntimeException(ex);
		}
	}

	public static Map<String,Object> createTemplateData(String html , String paperSize) throws Exception {
		HashMap<String, Object> data = new HashMap<String, Object>();

		html = html.replaceAll("width: ","width:").replaceAll("height: ","height:");
		RichHtmlHandler handler = new RichHtmlHandler(html);

		handler.setDocSrcLocationPrex("file:///C:/268BA210");
		handler.setDocSrcParent("temp.files");
		handler.setNextPartId("01D2FE8A.CA3F6560");
		handler.setShapeidPrex("_x56fe__x7247__x0020");
		handler.setSpidPrex("_x0000_i");
		handler.setTypeid("#_x0000_t75");

		if("a3".equals(paperSize)) {
			handler.setDocSrcLocationPrex("file:///C:/8589A053");
			handler.setDocSrcParent("a3.files");
			handler.setNextPartId("01D357C7.295FF7E0");
		}

		if("b4".equals(paperSize)) {
			handler.setDocSrcLocationPrex("file:///C:/8589A074");
			handler.setDocSrcParent("b4.files");
			handler.setNextPartId("01D357C7.7FDE2650");
		}

		handler.handledHtml(false);

		String bodyBlock = handler.getHandledDocBodyBlock();
//		System.out.println("bodyBlock:\n"+bodyBlock);

		String handledBase64Block = "";
		if (handler.getDocBase64BlockResults() != null
				&& handler.getDocBase64BlockResults().size() > 0) {
			for (String item : handler.getDocBase64BlockResults()) {
				handledBase64Block += item + "\n";
			}
		}
		data.put("imagesBase64String", handledBase64Block);

		String xmlimaHref = "";
		if (handler.getXmlImgRefs() != null
				&& handler.getXmlImgRefs().size() > 0) {
			for (String item : handler.getXmlImgRefs()) {
				xmlimaHref += item + "\n";
			}
		}
		data.put("imagesXmlHrefString", xmlimaHref);
		data.put("name", "地理云课堂");
		data.put("content", bodyBlock);
		return data;
	}

	public static void main(String[] args) throws Exception {
		HashMap<String, Object> data = new HashMap<String, Object>();

		StringBuilder sb = new StringBuilder();
		sb.append("<div>");
		sb.append("<p style=\"vertical-align:middle;\">" +
				"已知M<sub>t</sub>为8.6%，A<sub>ar</sub>为27.13%，<img alt=\"\" src=\"F:\\sanbo\\work\\1products\\hxfy\\ywork-web\\src\\main\\webapp\\userfiles\\1\\images\\exam\\question\\2017\\06\\image004(47).gif\"  style=\"height:21px; width:120px;\"/>为60.41%，问O<sub>ar&nbsp;</sub>为多少？O<sub>d</sub>又为多少？<br />" +
				"&nbsp;</p>");
		sb.append("<p>" +
				"写出由Q<sub>gr,ad</sub>计算Q<sub>net,ar</sub>的公式，并说明公式中各符号的含义。</p>" +
				"<p>" +
				"<img alt=\"\" src=\"F:\\sanbo\\work\\1products\\hxfy\\ywork-web\\src\\main\\webapp\\userfiles\\1\\images\\exam\\question\\2017\\05\\image001.gif\" style=\"width: 272px; height: 42px;\" /><br />" +
				"式中</p>" +
				"<p>" +
				"H<sub>ad</sub> &mdash;&mdash;煤中空气干燥基氢含量，%；&nbsp; M<sub>t</sub> &mdash;&mdash; 煤中全水分含量，%；<br />" +
				"M<sub>ad</sub> &mdash;&mdash; 煤中空气干燥基水分含量，%； Q<sub>net,ar</sub>；Q<sub>gr,ad</sub> &mdash;&mdash;均用J/g表示。</p>");
		sb.append("</div>");

		sb.setLength(0);
		sb.append("<div class=\"right\" id=\"divContent\">\n" +
				"    <div class=\"div2\">\n" +
				"        <div class=\"one1\" style=\"font-weight: bold;\">一、单选&nbsp;&nbsp;&nbsp;每题2分</div>\n" +
				"        <div id=\"QC-b8ea60cffae84b1a88f6199d02589851\">\n" +
				"            <div class=\"two1\"> <span class=\"que_num\">1、</span> 烟煤编码的个位数（），它们的黏结性（）。\n" +
				"            </div>\n" +
				"            <div class=\"three1\">\n" +
				"                <div>\n" +
				"                    A、越大，越小\n" +
				"                </div>\n" +
				"                <div>\n" +
				"                    B、越小，不变\n" +
				"                </div>\n" +
				"                <div>\n" +
				"                    C、不变，越小\n" +
				"                </div>\n" +
				"                <div>\n" +
				"                    D、越大，越大\n" +
				"                </div>\n" +
				"            </div>\n" +
				"        </div>\n" +
				"    </div>\n" +
				"    <p>&nbsp;</p>\n" +
				"    <div class=\"div2\">\n" +
				"        <div class=\"one1\" style=\"font-weight: bold;\">二、多选&nbsp;&nbsp;&nbsp;每题2分</div>\n" +
				"        <div id=\"QC-d2842337f12d4aef854a75b4e97898b6\">\n" +
				"            <div class=\"two1\"><span class=\"que_num\">2、</span> 下列四组数字计算中，正确的有 （）。\n" +
				"            </div>\n" +
				"            <div class=\"three1\">\n" +
				"                    <div>\n" +
				"                        A、0.0456×12.34÷l.06489 = 0.0456×12.3÷l.06=0.529</div>\n" +
				"                    <div>\n" +
				"                        B、0.0456×12.34÷l.06489=0.52842&nbsp;</div>\n" +
				"                    <div>\n" +
				"                        C、0.0456×12.34÷l.06489=0.528&nbsp;</div>\n" +
				"                    <div>\n" +
				"                        D、0.0456×12.34÷1.06489=0.05×12.34÷1.06=0.58&nbsp;</div>\n" +
				"            </div>\n" +
				"        </div>\n" +
				"        <div id=\"QC-6e5dec619c5a4980b8ee509beadc33ed\">\n" +
				"            <div class=\"two1\"><span class=\"que_num\">3、</span> 下列四组数字修约（保留小数点后两位）中，正确的有（）。\n" +
				"            </div>\n" +
				"            <div class=\"three1\">\n" +
				"                    <div>\n" +
				"                        A、14.9950→15.00</div>\n" +
				"                    <div>\n" +
				"                        B、22.9451→22.94</div>\n" +
				"                    <div>\n" +
				"                        C、32.4950→32.49</div>\n" +
				"                    <div>\n" +
				"                        D、12.3450→12.34&nbsp;</div>\n" +
				"            </div>\n" +
				"        </div>\n" +
				"    </div>\n" +
				"    <p>&nbsp;</p>\n" +
				"    <div class=\"div2\">\n" +
				"        <div class=\"one1\" style=\"font-weight: bold;\">三、是非&nbsp;&nbsp;&nbsp;每题2分</div>\n" +
				"        <div id=\"QC-fd5f0ca978444a9086eeaf11fb86554a\">\n" +
				"            <div class=\"two1\"><span class=\"que_num\">4、</span> 煤的哈氏可磨性指数的单位是%。\n" +
				"            </div>\n" +
				"            <div class=\"three1\">\n" +
				"                    <div>\n" +
				"                        A、正确</div>\n" +
				"                    <div>\n" +
				"                        B、错误</div>\n" +
				"            </div>\n" +
				"        </div>\n" +
				"    </div>\n" +
				"    <p>&nbsp;</p>\n" +
				"    <div class=\"div2\">\n" +
				"        <div class=\"one1\" style=\"font-weight: bold;\">四、计算&nbsp;&nbsp;&nbsp;每题2分</div>\n" +
				"        <div id=\"QC-2467d6ec06bc4e46892fef378e6e41d3\">\n" +
				"            <div class=\"two1 width95\"><span class=\"que_num\">5、</span> 设煤灰中三氧化硫含量为1.5%，煤的灰分\n" +
				"                <em>A</em><sub>ad</sub> 为27.93%，煤中全硫<em>S</em><sub>t,ad</sub> 为2.33%，问煤中可燃硫<em>S</em><sub>c,ad</sub>及不可燃硫<em>S</em><sub>ic</sub> 各为多少？\n" +
				"            </div>\n" +
				"            <div class=\"four1\">\n" +
				"\t            <p>&nbsp;</p>\n" +
				"\t            <p>&nbsp;</p>\n" +
				"            </div>\n" +
				"        </div>\n" +
				"        <div id=\"QC-d202851252bd4b3f916c6ad43efdb7c3\">\n" +
				"            <div class=\"two1 width95\"><span class=\"que_num\">6、</span> 设煤灰中三氧化硫含量为1.5%，煤的灰分A\n" +
				"                <sub>ad</sub> 为27.93%，煤中全硫S<sub>t,ad</sub> 为2.33%，可燃硫 S<sub>c,ad</sub> 及不可燃硫 S<sub>ic,ad </sub>占全硫的百分率各为多少？\n" +
				"            </div>\n" +
				"            <div class=\"four1\">\n" +
				"\t            <p>&nbsp;</p>\n" +
				"\t            <p>&nbsp;</p>\n" +
				"            </div>\n" +
				"        </div>\n" +
				"    </div>\n" +
				"</div>");

		String paperSize = "A3";
		RichHtmlHandler handler = new RichHtmlHandler(sb.toString().replaceAll("width: ","").replaceAll("height: ",""));

		handler.setDocSrcLocationPrex("file:///C:/268BA210");
		handler.setDocSrcParent("temp.files");
		handler.setNextPartId("01D2FE8A.CA3F6560");
		handler.setShapeidPrex("_x56fe__x7247__x0020");
		handler.setSpidPrex("_x0000_i");
		handler.setTypeid("#_x0000_t75");

		if("A3".equals(paperSize)) {
			handler.setDocSrcLocationPrex("file:///C:/E55B8853");
			handler.setDocSrcParent("paperExport_a3.files");
			handler.setNextPartId("01D357B3.E420BE70");
			handler.setShapeidPrex("_x56fe__x7247__x0020");
			handler.setSpidPrex("_x0000_i");
			handler.setTypeid("#_x0000_t75");
		}

		handler.handledHtml(false);

		String bodyBlock = handler.getHandledDocBodyBlock();
		System.out.println("bodyBlock:\n"+bodyBlock);

		String handledBase64Block = "";
		if (handler.getDocBase64BlockResults() != null
				&& handler.getDocBase64BlockResults().size() > 0) {
			for (String item : handler.getDocBase64BlockResults()) {
				handledBase64Block += item + "\n";
			}
		}
		data.put("imagesBase64String", handledBase64Block);

		String xmlimaHref = "";
		if (handler.getXmlImgRefs() != null
				&& handler.getXmlImgRefs().size() > 0) {
			for (String item : handler.getXmlImgRefs()) {
				xmlimaHref += item + "\n";
			}
		}
		data.put("imagesXmlHrefString", xmlimaHref);
		data.put("name", "张三");
		data.put("content", bodyBlock);

		String docFilePath = "d:\\temp\\temp.doc";
		System.out.println(docFilePath);
		File f = new File(docFilePath);
		OutputStream out;
		try {
			out = new FileOutputStream(f);
			WordGeneratorWithFreemarker.createDoc(data, "modules/exam/paperExport_a3.ftl", out);

		} catch (FileNotFoundException e) {

		} catch (MalformedTemplateNameException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
}