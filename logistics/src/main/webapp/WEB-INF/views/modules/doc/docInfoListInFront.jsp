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
	<title>地理云课堂</title>
	<script src="${ctxStatic}/materialize/js/jquery-1.11.2.min.js"></script>
	<script type="text/javascript">
		//兼容基于jQuery1.9以下版本的jQuery插件能正常使用
		jQuery.browser={};(function(){jQuery.browser.msie=false; jQuery.browser.version=0;if(navigator.userAgent.match(/MSIE ([0-9]+)./)){ jQuery.browser.msie=true;jQuery.browser.version=RegExp.$1;}})();

		$(function(){
			$('#domain_sel').find('a').removeClass('curr');
			$('#domain_sel').find('a[data-value="'+$('#domain').val()+'"]').addClass('curr');
			$('#domain_sel').find('a').on('click',function(e){
				$('#domain_sel').find('a').removeClass('curr');
				$(this).addClass('curr');
				page(1,${page.pageSize});
			});

			$('.icon-usercollect').each(function(index,item){
				$(item).off('click').on('click',function(e){
					$.ajax({
						url:'${ctx}/doc/docInfo/collect',
						data:{uid:$(this).data('uid'),did:$(this).data('did')},
						dataType:'json',
						type:'GET',
						success:function(ret){
							alert(ret.msg);
							if(ret.success){
								$(item).remove();
							}
						}
					});
				});
			});
		});

        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
			$('#domain').val($('#domain_sel').find('.curr').data('value'));
            $("#searchForm").submit();
            return false;
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
		<li class="class active"><a href="${ctx}/doc/docInfo/listf">文库</a></li>
		<li class="class"><a href="${ctx}/standard/yWStandard/listf">标准</a></li>
		<li class="class"><a href="#">题库</a></li>
		<li class="class"><a href="#">课程</a></li>
		<li class="class"><a href="#">设备</a></li>
		<li class="class"><a href="#">客服</a></li>
	</ul>
</div>
<div class="clear"></div>
<div class="navheight"></div>
<div class="clear blank20"></div>
<div class="daohang mainbox">当前位置：<a href="#">悦工作平台</a> - <a href="#">文库</a> - <a href="#">文档列表</a></div>
<div class="clear"></div>
<div class="downmain01">
	<div class="downmain01 no-margintop">
		<div class="left">
			<ul>
				<li class="li1">
					<div class="classtit"><a href="#"><b>知识文库</b></a></div>
				</li>
				<li>
					<div class="classtit"><span class="spanicon1"></span><a href="#">全部文库</a></div>
					<div class="classinfo">
						<div class="infotit">全部文库</div>
						<!--
						<a href="#">技术指南</a>
						<a href="#">煤岩学</a>
						-->
						对不起，本栏目下没有任何信息！
					</div>
				</li>
				<li>
					<div class="classtit"><span class="spanicon2"></span><a href="#">内部文库</a></div>
					<div class="classinfo">
						<div class="infotit">内部文库</div>
						对不起，本栏目下没有任何信息！
					</div>
				</li>
				<li>
					<div class="classtit"><span class="spanicon3"></span>
						<a href="#">我的收藏</a></div>
					<div class="classinfo">
						<div class="infotit">我的收藏</div>
						对不起，本栏目下没有任何信息！
					</div>
				</li>
			</ul>
		</div>
		<div class="leftlist">
            <div class="sjmain_con">
                <div class="exam_list">
                    <div class="exam_list_right">
                        <div class="top">
                            <form:form id="searchForm" modelAttribute="docInfo" action="${ctx}/doc/docInfo/listf" method="post">
                                <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                                <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                                <form:hidden id="domain"  path="domain"/>
                                <div class="box01">
                                    <ul>
                                        <li>
                                            <div class="libox" id="domain_sel">
                                                <span>科目：</span>
                                                <a data-value="" href="javascript:;">不限</a>
                                                <a data-value="1" href="javascript:;">技术指南</a>
                                                <a data-value="2" href="javascript:;">煤化学</a>
                                                <a data-value="3" href="javascript:;">煤岩学</a>
                                                <a data-value="4" href="javascript:;">煤质分析</a>
                                                <a data-value="5" href="javascript:;">其他</a>
                                                <div class="pull-right" style="margin:5px 5px;">
                                                    <input id="title" name="title" type="text" class="form-control" style="margin:0px;" value="${param.title}" placeholder="按文档标题查询"/><button type="submit" class="btn btn-default">搜索</button>
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
						<a href="${ctx}/doc/docInfo/pdf/preview?id=${d.id}" title="${d.title}"><img src="${ctxStatic}/hsun/images/pdf.gif">${d.title}</a>
					</div>
					<div class="intro">${d.summary}</div>
					<div class="liother">
						<img src="${ctxStatic}/hsun/images/bg38.png" align="texttop" style="margin-left:0px;">1 <img src="${ctxStatic}/hsun/images/bg37.png" align="texttop" class="icon-usercollect" data-did="${d.id}" data-uid="${fns:getUser().id}">
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