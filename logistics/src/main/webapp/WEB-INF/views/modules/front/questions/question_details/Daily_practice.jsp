<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>地理云课堂</title>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/nav.css${v}"/>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/index.css${v}"/>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/weidu/iconfont.css${v}"/>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/iconfont/jiantouxiangxia/iconfont.css${v}">
    <%--编辑器--%>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/ckeditor/css/question-answer.css${v}"/>

    <script src="${ctxStatic}/hsun/front/js/jquery/jquery.js${v}" type="text/javascript" charset="utf-8"></script>
    <script src="${ctxStatic}/hsun/front/js/xml2json/jquery.xml2json.js${v}" type="text/javascript"></script>

    <%@ include file="/WEB-INF/views/include/totalPath.jsp" %>

    <script type="text/javascript" src="${ctxStatic}/hsun/front/js/header.js${v}"></script>

    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/question_details/Daily_practice.css${v}"/>
    <link rel="stylesheet" type="text/css"
          href="${ctxStatic}/hsun/front/font-awesome-4.4.0/css/font-awesome.min.css${v}"/>

    <%--<script type="text/javascript" src="${ctxStatic}/hsun/front/js/userinfo.js${v}"></script>--%>
    <script type="text/javascript" src="${ctxStatic}/hsun/front/js/urlpath.js${v}"></script>
    <script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}"/>

    <style>

    </style>
</head>

<body>
<!--头部部分-->
<div id="divheader"></div>
<!--内容部分-->
<div id="divbody">
    <div style="height:40px;"></div>
    <form>
        <input type="hidden" id="hidTimecost" name="t_timecost" value="0"/>
        <input type="hidden" id="hidDuration" name="t_duration"/>
        <div class="right" id="divContent">
            <div class="pos_name">
                <i></i><span></span>
            </div>
            <div class="one1">
                <div class="progress_bar">
                    <p style="width: 0%;"></p>
                </div>
                <div class="progress_num">
                    <em>已完成0%</em>
                </div>
            </div>
            <div id="model_exam">

            </div>
            <div class="paper_key">
                <div class="paper_key_title">
                    <%--<span class="paper_key_confirm" onclick="dailyPractice.seeAnswer()"><i></i>查看答案</span>--%>
                    <span class="paper_key_down" onclick="dailyPractice.seeAnswer()">
								<i></i><span>查看答案</span>
							</span>
                </div>
                <div class="paper_key_cont">
                    <ul>
                        <li class="key_cont_key">
                            <span><i></i>参考答案 :</span>
                            <p>该教师没有树立正确的教师观，需要我们引以为戒。</p>
                        </li>
                        <li class="key_cont_lever">
                            <span><i></i>试题难度 :</span>
                            <p>初级</p>
                        </li>
                        <li class="key_cont_analysis">
                            <span><i></i>参考解析 :</span>
                            <p>暂无</p>
                        </li>
                        <li class="set_notes">
                            <span><i></i>练习笔记 :</span>
                            <p><a href="javascript:void(0);" onclick="dailyPractice.nodesClick()">做笔记</a></p>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="left">
            <div class="paper_set">
                <ul>
                    <li class="set_back">
                        <a href="${ctxRoot}/page/questions/question_bank.html">
                            <em class="fa fa-mail-reply (alias)"></em><br>
                            返回
                        </a>
                    </li>
                    <%--<li class="set_set">--%>
                    <%--<a href="javascript:void(0);">--%>
                    <%--<em class="fa fa-cog"></em><br>--%>
                    <%--设置--%>
                    <%--</a>--%>
                    <%--<div class="down_menu">--%>
                    <%--<div>--%>
                    <%--<input type="radio" data-id="1" name="set_paper">自动显示答案--%>
                    <%--</div>--%>
                    <%--<div>--%>
                    <%--<input type="radio" data-id="2" name="set_paper">自动下一题--%>
                    <%--</div>--%>
                    <%--<div>--%>
                    <%--<input type="radio" data-id="3" name="set_paper" checked>答对自动下一题(客观题有效)--%>
                    <%--</div>--%>
                    <%--<div>--%>
                    <%--<input type="radio" data-id="4" name="set_paper">手动操作--%>
                    <%--</div>--%>
                    <%--</div>--%>
                    <%--</li>--%>
                    <%--<li class="set_calculator">--%>
                    <%--<a href="javascript:void(0);">--%>
                    <%--<em class="fa fa-calculator"></em><br>--%>
                    <%--计算器--%>
                    <%--</a>--%>
                    <%--</li>--%>
                </ul>
            </div>

            <div id="set_table">
                <div class="set_time">
                    <em class=""></em><span style="padding-right:5px;">用时</span><span id="spanHour"
                                                                                      class="color_red">00</span><span>:</span><span
                        id="spanMinute" class="color_red">00</span><span>:</span><span id="spanSecond"
                                                                                       class="color_red">00</span><span
                        id="fause"><a href="javascript:void(0);"
                                      onclick="dailyPractice.spanPause()"><i></i>暂停</a></span>
                </div>
                <div class="set_car_title">
                    <%--答题卡--%>
                </div>
                <%--<div class="one4">--%>
                <%--<div class="two2" id="questionCard">--%>
                <%--<span class="yesAnswer" onclick="anchorPosition(1)">01</span>--%>
                <%--<span class="notAnswer" onclick="anchorPosition(2)">02</span>--%>
                <%--<span class="notAnswer" onclick="anchorPosition(3)">03</span>--%>
                <%--<span class="notAnswer" onclick="anchorPosition(4)">04</span>--%>
                <%--<span class="notAnswer" onclick="anchorPosition(5)">05</span>--%>
                <%--</div>--%>
                <%--<div class="two5">--%>
                <%--<span>正确 </span><i class="fa fa-stop" style="color: #62c68b ;"></i>--%>
                <%--<span>错误 </span><i class="fa fa-stop" style="color: #db856d;"></i>--%>
                <%--<span>已答主观题 </span><i class="fa fa-stop" style="color: #B4B4B4;"></i>--%>
                <%--</div>--%>
                <%--</div>--%>
                <a id="over_paper" href="javascript:void(0)" onclick="dailyPractice.savaQuestions()">提交练习</a>
            </div>
        </div>
    </form>
    <div class="divcenter" style="display: none;" id="answerDiv">
        <div class="divnodes">
            <span class="one4">我的笔记</span>
            <span class="one5">共有 <span id="spannodes" style="margin-right: 0px;">0</span>条公开笔记</span>
        </div>
        <div style="width: 100%" ; id="nodesDiv">
            <div>
                <div style="margin: 10px 50px;">
                    <textarea id="nodesContent"
                              style="width: 100%; height: 120px;border: 1px solid #e0e3e9;"></textarea>
                </div>
                <div style="padding: 0 50px;height: 36px;">
                    <div style="float: left;width: 500px;">
                        <input style="height: 26px;vertical-align: top;padding:10px;;border: 1px solid #e0e3e9;"
                               type="text" name="text" maxlength="5" placeholder="验证码" id="inp_text">
                        <span id="fault" class="color4 fz12 fault"></span>
                        <img style="clear: both;" src="${ctxRoot}/servlet/validateCodeServlet"
                             onclick="$('.validateCodeRefresh').click();" alt="" id="inp_img" class="mid validateCode"
                             height="26">

                        <a style="margin-left: 10px;position: absolute;margin-top: 6px;text-decoration: none;color: #db856d;font-size: 12px;"
                           href="javascript:"
                           onclick="$('.validateCode').attr('src','${ctxRoot}/servlet/validateCodeServlet?'+new Date().getTime());"
                           class="mid validateCodeRefresh">看不清</a>

                        <span style="margin-top: 3px;position: absolute;margin-left: 100px;font-size: 12px;">公开<input
                                style="position: relative;top:2px;" type="checkbox" id="chkpublic"/></span>
                    </div>
                    <div style="float: right;">
                        <input type="button"
                               style="padding: 6px 16px;background:#30bf89;border: 0px;color: white;border-radius: 4px;"
                               onclick="dailyPractice.submitNodes()" value="提交"/>
                    </div>
                </div>
            </div>
            <div class="nodes">
                <div style="margin-left: 50px;margin-top: 20px;">试题笔记</div>
                <div style="margin: 10px 50px;">
                    <table cellpadding="0" cellspacing="0" id="nodesTable">

                    </table>
                </div>
                <div class="divPage" id="pagehtml">
                    <a class="next" href="javascript:" onclick="page();">加载更多</a>
                </div>
                <div class="divPage" id="pagehtml_all" style="display: none;">
                    <a class="next" href="javascript:">已加载全部</a>
                </div>
            </div>
            <!--试题ID-->
            <input type="hidden" id="hidQid"/>
            <!--当前页-->
            <input type="hidden" id="pageNo" value="1"/>
            <!-- 总页数-->
            <input type="hidden" id="totalPageCount" value="1"/>
        </div>
    </div>
</div>
<%--公式编辑器--%>
<div id="formula-wrap" style="width: 560px; height: 420px;">
    <div class="formula-tit">地理云课堂 - 公式编辑器</div>
    <div class="formula-iframe">
        <iframe frameborder="0" width="100%" height="320"></iframe>
    </div>
    <button type="button" class="close" id="J_FormulaClose">关 闭</button>
    <button type="button" class="submit" id="J_FormulaOk">确 定</button>
</div>
<script type="text/javascript"
        src="${ctxStatic}/hsun/front/js/pagejs/questions/question_details/Daily_practice.js${v}"></script>
<script src="${ctxStatic}/hsun/front/ckeditor/ckeditor/ckeditor.js${v}"></script>
<script src="${ctxStatic}/hsun/front/ckeditor/js/jquery-ui-1.9.2.custom.min.js${v}"></script>
<script src="${ctxStatic}/hsun/front/ckeditor/js/texzilla.js${v}"></script>
</body>

</html>
