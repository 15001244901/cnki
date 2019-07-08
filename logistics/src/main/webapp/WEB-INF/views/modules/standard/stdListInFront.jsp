<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" href="${ctxStatic}/bootstrap/2.3.1/css_default/bootstrap.min.css" />
	<link rel="stylesheet" href="${ctxStatic}/hsun/images/index.css" />
	<link href="${ctxStatic}/hsun/images/css.css" rel="stylesheet" />
	<link href="${ctxStatic}/hsun/images/sjx.css" rel="stylesheet" />
	<title>悦工作平台-标准列表</title>
	<script src="${ctxStatic}/materialize/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript">
		//兼容基于jQuery1.9以下版本的jQuery插件能正常使用
		jQuery.browser={};(function(){jQuery.browser.msie=false; jQuery.browser.version=0;if(navigator.userAgent.match(/MSIE ([0-9]+)./)){ jQuery.browser.msie=true;jQuery.browser.version=RegExp.$1;}})();

		$(function(){
			switchKM(${param.category});
			/*
            $('#status_sel').find('a').removeClass('curr');
            $('#status_sel').find('a[data-value="'+$('#status').val()+'"]').addClass('curr');
            $('#status_sel').find('a').on('click',function(e){
                $('#status_sel').find('a').removeClass('curr');
                $(this).addClass('curr');
                page(1,${page.pageSize});
            });
            */
		});

		function init(){

		}

		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$('#typesys').val($('#typesys_sel').find('.curr').data('value'));
            $('#status').val($('#status_sel').find('.curr').data('value'));
			$("#searchForm").submit();
			return false;
		}

		function switchKM(type,reload){
			$('#typesys_sel').find('a').remove();
			var html1 = '<a data-value="" href="javascript:;" class="curr">不限</a>' +
					'<a data-value="一、术语及分类" href="javascript:;">术语及分类</a>' +
					'<a data-value="二、煤质评价与管理" href="javascript:;">煤质评价与管理</a>' +
					'<a data-value="三、各种工业用煤技术条件" href="javascript:;">各种工业用煤技术条件</a>' +
					'<a data-value="四、煤炭洗选" href="javascript:;">煤炭洗选</a>' +
					'<a data-value="五、节能环保与循环经济" href="javascript:;">节能环保与循环经济</a>' +
					'<a data-value="六、综合利用" href="javascript:;">综合利用</a>' +
					'<a data-value="七、煤炭采制样及分析方法" href="javascript:;" style="margin-left:58px;">煤炭采制样及分析方法</a>' +
					'<a data-value="八、其他" href="javascript:;">其他</a>';
			var html2 = '<a data-value="" href="javascript:;" class="curr">不限</a>' +
					'<a data-value="实验室资质认定" href="javascript:;">实验室资质认定</a>' +
					'<a data-value="实验室认可" href="javascript:;">实验室认可</a>';
			if(type == 2){
				$('#typesys_sel').append(html2);
			} else {
				$('#typesys_sel').append(html1);
			}

			$('#category').val(type||1);

			$('#typesys_sel').find('a').removeClass('curr');
			$('#typesys_sel').find('a[data-value="'+$('#typesys').val()+'"]').addClass('curr');
			$('#typesys_sel').find('a').on('click',function(e){
				$('#typesys_sel').find('a').removeClass('curr');
				$(this).addClass('curr');
				page(1,${page.pageSize});
			});

            if(reload)
                page(1,${page.pageSize});
		}
	</script>
</head>

<body>
<div class="navmain">
	<ul class="mainbox">
		<div class="userlogin">
                <span id="PopLoginTips">
                    <div class="username" style="margin-left:0px"><a href="#" target="_blank" class="loginbtn">登录</a></div>
                    <div class="username"><a target="_blank" href="#">注册</a></div>
				</span>
		</div>
		<li class="logo">
			<a href="#"><img src="${ctxStatic}/hsun/images/logo.png" /></a>
		</li>
		<li class="class"><a href="#">首页</a></li>
		<li class="class"><a href="${ctx}/doc/docInfo/listf">文库</a></li>
		<li class="class active"><a href="${ctx}/standard/yWStandard/listf">标准</a></li>
		<li class="class"><a href="#">题库</a></li>
		<li class="class"><a href="#">课程</a></li>
		<li class="class"><a href="#">设备</a></li>
		<li class="class"><a href="#">客服</a></li>
	</ul>
</div>
<div class="clear"></div>
<div class="navheight"></div>
<div class="clear blank20"></div>
<div class="daohang mainbox">当前位置：<a href="#">悦工作平台</a> - <a href="#">标准</a> - <a href="#">标准列表</a></div>
<div class="clear"></div>
<div class="downmain01">
	<div class="downmain01 no-margintop">
		<div class="left">
			<ul>
				<li class="li1">
					<div class="classtit"><a href="#"><b>标准导航</b></a></div>
				</li>
				<li>
					<div class="classtit" onclick="switchKM(1,true)"><span class="spanicon1"></span><a href="#">国家标准</a></div>
					<!--
					<div class="classinfo">
						<div class="infotit">国家标准</div>
						对不起，本栏目下没有任何信息！
					</div>
					-->
				</li>
				<li>
					<div class="classtit" onclick="switchKM(2,true)"><span class="spanicon2"></span>
						<a href="#">质量体系</a></div>
				</li>
				<li>
					<div class="classtit"><span class="spanicon3"></span>
						<a href="#">我的收藏</a></div>
				</li>
			</ul>
		</div>
		<div class="leftlist">
            <div class="sjmain_con">
                <div class="exam_list">
                    <div class="exam_list_right">
                        <div class="top">
                            <form:form id="searchForm" modelAttribute="YWStandard" action="${ctx}/standard/yWStandard/listf" method="post">
                                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                                <form:hidden id="typesys"  path="typesys"/>
                                <form:hidden id="status"  path="status"/>
								<form:hidden id="category"  path="category"/>
                                <div class="box01">
                                    <ul>
                                        <li style="height:60px;">
                                            <div class="libox" id="typesys_sel">
                                                <span>科目：</span>
                                            </div>
                                        </li>
                                        <!--
                                        <li>
                                            <div class="libox" id="status_sel">
                                                <span>标准状态：</span>
                                                <a data-value="" href="javascript:;">不限</a>
                                                <a data-value="现行" href="javascript:;">现行</a>
                                                <a data-value="未实施" href="javascript:;">未实施</a>
                                                <a data-value="作废" href="javascript:;">作废</a>
                                                <a data-value="即将作废" href="javascript:;">即将作废</a>
                                            </div>
                                        </li>
                                        -->
                                        <li>
                                            <div class="libox">
                                                <span>过滤条件：</span>
                                                <div style="margin:5px 0px 5px 10px;">
                                                    <input id="sno" name="sno" type="text" value="${param.sno}" class="form-control" placeholder="按标准编号 / 标准名称" style="margin:0px 0px 0px 10px;"/>
                                                    <button type="submit" class="btn btn-default">搜索</button>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                    <div class="clear"></div>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
			<ul>
				<c:forEach items="${page.list}" var="d">
				<li>
					<div class="litit">
						<a href="${ctx}/standard/yWStandard/pdf/preview?id=${d.id}" title="${d.name}"><img src="${ctxStatic}/hsun/images/pdf.gif">${d.sno}</a>
					</div>
					<div class="intro">${d.name}<br/>${d.enname}</div>
					<div class="liother">
						<img src="${ctxStatic}/hsun/images/bg38.png" align="texttop" style="margin-left:0px;">1 <img src="${ctxStatic}/hsun/images/bg37.png" align="texttop">
					</div>
				</li>
				</c:forEach>
			</ul>
			<div align="center">
				<div class="fenye" id="fenye">
					<table border="0">
						<tbody>
						<tr>
							<td id="pagelist">
								${page}
							</td>
						</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="clear"></div>
<div class="footer">
	<a href="#" target="_blank">关于我们</a> | <a href="#" target="_blank">联系我们</a> | <a href="#" target="_blank">法律条款</a> | <a href="#" target="_blank">招募英才</a> | <a href="#" target="_blank">免责声明</a>
</div>
<div class="copyright">Powered By Y-work 正式版 www.ywork.com inc .
	<br />北京华迅科技有限公司版权所有 © 2010-2016
	<br /> 统一社会信用代码:XXXXXXXX 京ICP备XXXXXXXX号
	<br />统一客服热线：400-008-0263
	<div class="clear"></div></div>
</body>

</html>