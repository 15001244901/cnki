<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <%@ include file="/WEB-INF/views/include/totalPath.jsp"%>
    <script src="${ctxStatic}/jquery/jquery-1.9.1.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/bootstrap/3.3.7/css/bootstrap.css">
    <script type="text/javascript" src="${ctxStatic}/hsun/front/js/layer/layer.js${v}"></script>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/css/layer/skin/default/layer.css${v}"/>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/teacher/css/teacherList.css${v}"/>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/hsun/front/teacher/css/pager.css${v}"/>
</head>
<body>
<div id="teacher">
    <ul class="nav nav-tabs">
        <li class="active"><a href="${ctx}/teacher/toList.jhtml">教师列表</a></li>
        <li><a href="${ctx}/teacher/toAdd.jhtml">教师添加</a></li>
    </ul>
    <table cellpadding="0" cellspacing="0" id="container" class="table-hover">
        <thead>
        <tr>

            <th>姓名</th>
            <th class="wid8">头衔</th>
            <th class="wid12">资历</th>
            <th class="wid40">简介</th>
            <th>添加时间</th>
            <th>排序</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <%--<tr>--%>
            <%--<td>--%>
                <%--<div class="photo">--%>
                    <%--<img src="${ctxStatic}/hsun/front/img/feiyang.jpg" alt="">--%>
                    <%--<div class="name">张三</div>--%>
                <%--</div>--%>
            <%--</td>--%>
            <%--<td>高级讲师</td>--%>
            <%--<td>北京师范大学法学院副教授</td>--%>
            <%--<td class="infor">--%>
                <%--2012年12月，习近平担任总书记后首赴地方考察时就谆谆告诫：“我们在生态环境方面欠账太多了，如果不从现在起就把这项工作紧紧抓起来，将来会付出更大的代价。”5年来，对生态环境，--%>
            <%--</td>--%>
            <%--<td>2015/04/03 14:32</td>--%>
            <%--<td>20</td>--%>
            <%--<td class="course">--%>
                <%--<a class="btn-info" href="javascript:void(0);">修改</a>--%>
                <%--<a class="btn-warning" href="javascript:void(0);">删除</a>--%>
            <%--</td>--%>
        <%--</tr>--%>

        </tbody>
    </table>

    <div id="ispage" style="text-align: center">
        <div>
            <ul class="pagination" id="page2">
            </ul>
            <div class="pageJump">
                <span>跳转到</span>
                <input type="text"/>
                <span>页</span>
                <button type="button" class="button">确定</button>
            </div>
        </div>
    </div>
</div>

<script id="model" type="text/template">
    <tr>
        <td>
            <div class="photo">
                <img src="{{picPath}}" alt="">
                <div class="name">{{name}}</div>
            </div>
        </td>
        <td>{{isStar}}</td>
        <td>{{education}}</td>
        <td class="infor">
            {{career}}
        </td>
        <td>{{createTime}}</td>
        <td>{{sort}}</td>
        <td class="course">
            <a class="set btn-info" data-id={{id}} href="${ctx}/teacher/toUpdate.jhtml?id={{id}}">修改</a>
            <a class="del btn-warning" data-id={{id}} href="javascript:void(0);">删除</a>
        </td>
    </tr>
</script>
<script src="${ctxStatic}/hsun/front/teacher/js/pager.js${v}"></script>
<script>
    $(function(){
        var selTeacher = function(){
            var that = this;

            this.container = $('#container tbody');
            this.model = $('#model').html();

            //初始化加载数据
            this.loadData = function(num){
                 $.ajax({
                 	'url':'${ctx}/teacher/list.jhtml',
                 	'type':'post',
                 	'dataType': "json",
                     data:{
                 	    'page.currentPage':(num||'1')
                     },
                    success:function(ret){
                 	    console.log(ret);
                        var data = ret.teacherList;
                        var domString;
                        for(var i in data){
                            var dictionary = data[i];
                            if(!dictionary.picPath){
                                dictionary.picPath = '${ctxStatic}/hsun/front/img/feiyang.jpg';
                            }
                            if(dictionary.isStar == "1"){
                                dictionary.isStar = "高级讲师"
                            }else if(dictionary.isStar == "2"){
                                dictionary.isStar = "首席讲师"
                            }
                            domString += that.comPile(that.model,dictionary);
                        }

                        that.container.html(domString);

                        that.del = $('.del');  //删除记录
                        that.del.off('click').on('click',that.delTeacher);

                        that.set = $('.set');  //删除记录
                        that.set.off('click').on('click',that.setTeacher);

                        if(ret.page.totalResultSize - 10 <= 0){
                            $('#ispage').hide();
                        }else{
                            that.page(ret.page.totalPageSize,ret.page.currentPage);
                        }
                    }
                 });

            };

            //分页
            this.page = function(totanum,nownum){
                Page({
                    num:totanum,					//页码数
                    startnum:nownum,				//指定页码
                    elem:$('#page2'),		//指定的元素
                    callback:function(n){	//回调函数
                        that.loadData(n);
                    }
                });
            }

            //删除当前数据
            this.delTeacher = function(){
                var isid = $(this).data('id');
                var isthat = $(this);
                layer.msg('您确定要删除此条信息么？', {
                    time: 0, //不自动关闭
                    btn: ['必须啊', '取消吧'],
                    yes: function(index){
                        $.ajax({
                            'url':'${ctx}/teacher/'+isid+'/delete.jhtml',
                            'type':'post',
                            'dataType': "json",
                            success:function(ret){
//                                console.log(ret);
                                if(ret.success){
                                    isthat.closest('tr').remove();
                                    layer.msg(
                                            '删除成功',
                                            {
                                                anim:4,
                                                time:3000
                                            }
                                    );
                                }
                            }
                        });

                    }
                });

            }

            //数据正则匹配方法
            this.comPile = function(templateString , dictionary){
                return templateString.replace(/\{{([A-Za-z]+)\}}/g , function(match,$1,index,string){
                    return dictionary[$1];
                });
            }
            this.init = function(){
                this.loadData();
            }
        }

        var selteacher = new selTeacher;
        selteacher.init();
    })
</script>
</body>
</html>