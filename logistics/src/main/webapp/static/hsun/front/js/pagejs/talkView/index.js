var Index = function () {

    return {
        initChat: function () {

            var cont = $('#chats');
            var conts = $('.chats');
            var list = $('.chats', cont);
            var form = $('.chat-form', cont);
            var input = $('input', form);
            var btn = $('.btn', form);
            var people_list = $('#people_list div');
            Index.loadShowOnline(); //加载聊天列表

            // 及时通讯服务 ===============================================================================================
            // ws.onopen = function (evt) {
            //     layer.msg("已经建立连接", { offset: 0});
            // };
            // ws.onmessage = function (evt) {
            //     message = JSON.parse(evt.data);
            //     // Index.analysisMessage(evt.data);  //解析后台传回的消息,并予以展示
            // };
            // ws.onerror = function (evt) {
            //     layer.msg("产生异常", { offset: 0});
            // };
            // ws.onclose = function (evt) {
            //     layer.msg("已经关闭连接", { offset: 0});
            //     ws = new WebSocket(wsServer); //创建WebSocket对象
            // };
            // 及时通讯服务结束

            /**
             * 连接
             */

            $('#getConnection').click(function(){
                top.getConnection()
            });
            /**
             * 关闭连接
             */

            $('#closeConnection').click(function(){
                top.closeConnection()
            });
            /**
             * 检查连接
             */

            $('#checkConnection').click(function(){
                top.checkConnection()
            });
            /**
             * 发送信息给后台
             */
            function sendMessage(inp){

                // if(top.ws == null){
                //     layer.msg("连接未开启!", { offset: 0, shift: 6 });
                //     return;
                // }
                var message = inp;
                var toUsername = $(".people_list li .active span").html() == "全体成员"? "": $(".people_list li .active span").html();
                // var toUsername = $(".people_list li .active span").html();
                var toUserid = $(".people_list li .active").data('id');
                if(message == null || message == ""){
                    layer.msg("请不要惜字如金!", { offset: 0, shift: 6 });
                    return;
                }
                // ws.send(JSON.stringify({
                //     data : {
                //         content : message,
                //         from : userid,
                //         to : toUserid,      //接收人,如果没有则置空,如果有多个接收人则用,分隔
                //         toUsername:toUsername
                //     }
                // }));
                top.sendData(message,userid,toUserid,toUsername);
                // ws.send(message);
            }

            /**
             * 解析后台传来的消息
             * "massage" : {
             *              "from" : "xxx",
             *              "to" : "xxx",
             *              "content" : "xxx",
             *              "time" : "xxxx.xx.xx"
             *          },
             * "type" : {notice|message},
             * "list" : {[xx],[xx],[xx]}
             */

            /**
             * 添加接收人
             */
            // function addC(user,is){
            //     Index.aitePeople(is);
            //     var sendto = $("#sendto");
            //     var receive = sendto.text() == "全体成员" ? "" : sendto.text() + ",";
            //     if(receive.indexOf(user) == -1){    //排除重复
            //         sendto.text(receive + user);
            //     }
            //
            // }

            // 回话控制窗口回到最底部
            function scrollBottom(){
                cont.find('.scroller').slimScroll({
                    scrollTo: $('.chats').height()
                });
            }

            /**
             * 清空聊天区
             */
            function clearConsole(){
                $(".chats").html("");
            }
            $('#clearConsole').click(function(){
                clearConsole()
            });


            var handleClick = function (e) {
                e.preventDefault();
                //信息类型（收到的消息、发送的消息、系统推送、查看更多=====0,1,2,3）
                var new_type = 2;
                // var text = input.val();
                var text = getContent();

                var now_talk_id = $('#now_talk_people').val();

                if(now_talk_id == 'total' || $('#news-'+now_talk_id).find('.fa').css('display') !== 'none'){
                    sendMessage(text); //向后台发信息
                }else{
                    // var noline_id = $('#now_talk_people').val();

                    // 获取当前时间
                    function GetDateStr(AddDayCount) {
                        var dd = new Date();
                        dd.setDate(dd.getDate()+AddDayCount);//获取AddDayCount天后的日期
                        var y = dd.getFullYear();
                        var m = dd.getMonth()+1;//获取当前月份的日期
                        var d = dd.getDate();
                        var t = dd.getHours();
                        var f = dd.getMinutes();
                        var s = dd.getSeconds();
                        m = double(m);
                        d = double(d);
                        t = double(t);
                        f = double(f);
                        s = double(s);
                        return y+"-"+m+"-"+d +" "+ t +':'+ f +':'+s;
                    }
                    // 单数转化为双数
                    function double(num){
                        if(num-10 < 0){
                            num = '0'+num;
                        }
                        return num;
                    }
                    var time = GetDateStr(0);

                    var noline_message = [];
                    noline_message.sendername = uName;
                    noline_message.id = userid;
                    noline_message.recievername = $('#news-'+now_talk_id).find('.to_user_name').html();
                    noline_message.senddate = time;
                    noline_message.content = text;
                    console.log(noline_message);
                    $.ajax({
                        url: urlpath + '/user/message/send.jhtml',
                        type: "post",
                        data:{
                            'content' : text,
                            'senderid' : userid,
                            'sendername' : uName,
                            'msgtype':'3',
                            'senddate':time,
                            'recieverid' : now_talk_id,      //接收人,如果没有则置空,如果有多个接收人则用,分隔
                            'recievername':$('#news-'+now_talk_id).find('.to_user_name').html()
                        },
                        success: function (t) {
                            console.log(t);
                            if(t.success){
                                Index.showChat(noline_message);
                            }else{
                                Index.showChat(noline_message,'0');
                                Index.repeatShowChat(text,time,now_talk_id);
                            }
                        }
                    });
                }

                input.val("");
                $('.edui-body-container').html(' ');
            };

            // $('body').on('click', '.message .name', function (e) {
            //     e.preventDefault(); // prevent click event
            //
            //     var name = $(this).text(); // get clicked user's full name
            //     input.val('@' + delHtmlTag(name) + ':'); // set it into the input field
            //     Metronic.scrollTo(input); // scroll to input if needed
            // });

            $('#send_to').click(handleClick);

            input.keypress(function (e) {
                if (e.which == 13) {
                    handleClick(e);
                    return false; //<---- Add this line
                }
            });
            function delHtmlTag(str) {
                var result=str.replace(/(^\s+)|(\s+$)/g,"");//去掉前后空格
                return  result.replace(/\s/g,"");//去除文章中间空格
            }

        },
        //解析数据类型
        analysisMessage:function (message){
            message = JSON.parse(message);
            if(message.msgtype == 1){      //会话消息
                Index.showNotice(message);
            } else{
                var now_talking = $('#now_talk_people').val();
                if(message.msgtype == 3){  //私聊消息
                    if(message.senderid == now_talking || message.recieverid == now_talking){
                        Index.showChat(message);
                    }else{
                        var news_num =  Number( $('#news-'+message.senderid).find('.news_nums').html());
                        if(news_num < 99){
                            news_num = news_num +1;
                        }else{
                            news_num = '99+'
                        }

                        $('#news-'+message.senderid).find('.news_nums').html(news_num);
                        $('#news-'+message.senderid).find('.news_nums').show();
                    }

                }else if(message.msgtype == 2){ //全体消息
                    // console.log(now_talking);
                    if(now_talking == 'total'){
                        Index.showChat(message);
                    }else{
                        var news_num =  Number( $('#news-total').find('.news_nums').html());
                        if(news_num < 99){
                            news_num = news_num +1;
                        }else{
                            news_num = '99+'
                        }
                        $('#news-total').find('.news_nums').html(news_num);
                        $('#news-total').find('.news_nums').show();
                    }

                }
            }
            if(message.list != null && message.list != undefined){      //在线列表
                Index.showOnline(message.list);
            }
        },
        // 展示回话信息
        showChat:function (message,bjs){
            // console.log(message);
            var to = message.recievername == null || message.recievername == ""? "全体成员" : message.recievername;   //获取接收人
            var isSef = uName == message.sendername ? "out" : "in";   //如果是自己则显示在右边,他人信息显示在左边
            //如果发送人是自己，则显示为我
            if(message.sendername == uName)
                message.sendername = '我';
            var tpls = [];
            tpls.push('<li class="'+isSef+'">');

            // 'out'是发出，‘in’是收入
            if(isSef == 'out'){
                tpls.push('<img class="avatar" alt="" src="'+ uphoto +'"/>');
            }else{
                var ophoto = $('#i-'+message.id).prop('src');
                tpls.push('<img id="v-'+message.id+'" class="avatar" alt="" src="'+ (ophoto||uemptyPhoto) +'"/>');
            }

            tpls.push('<div class="message">');
            tpls.push('<span class="arrow"></span>');

            // bjs存在且为0；发送失败
            if(bjs && bjs == '0'){
                tpls.push('<a class="isfail" href="javascript:void(0);"><span class=" fa fa-exclamation-circle"></span>重新发送</a>');
            }

            tpls.push('<a href="#" class="name">'+ message.sendername + '</a>&nbsp;');
            tpls.push('<span class="datetime">发表于 ' + message.senddate + '</span>');
            tpls.push('<span class="datetime">&nbsp;@' + to + '</span>');
            tpls.push('<br/>');
            tpls.push('<span class="body">');
            tpls.push(message.content);
            tpls.push('</span>');
            tpls.push('</div>');
            tpls.push('</li>');
            $('.chats').append(tpls.join(""));

            Index.scrollBottom();
        },
        //离线发送失败从新发送
        repeatShowChat:function(text,time,toid){
            $('.chats').off('click').on('click','.isfail',function(){
                var that = $(this);
                $.ajax({
                    url: urlpath + '/user/message/send.jhtml',
                    type: "post",
                    data:{
                        'content' : text,
                        'senderid' : userid,
                        'sendername' : uName,
                        'msgtype':'3',
                        'senddate':time,
                        'recieverid' : toid,      //接收人,如果没有则置空,如果有多个接收人则用,分隔
                        'recievername':$('#news-'+toid).find('.to_user_name').html()
                    },
                    success: function (t) {
                        // console.log(t);
                        if(t.success){
                            that.remove();
                        }
                    }
                });
            });

        },
        // 展示在线列表
        showOnline:function (list){
            $('.fa-commenting').hide();
            $('.ones_list li').removeClass('opd5');
            for(var i = 0;i<list.length;i++){
                $('#news-'+list[i].id).find('.fa').show();
                $('#news-'+list[i].id).addClass('opd5');
            };

            showOnlineList = top.showOnlineList;
            // console.log(showOnlineList);
            $(".numpeople").text(list.length + '人在线');     //获取在线人数

        },
        // 初始化展现在线列表
        loadShowOnline:function(){
            $.ajax({
                url: urlpath_a + '/sys/user/listCompanyUsers.jhtml',
                type: "GET",
                async: false,
                success: function (t) {
                    //console.log(t);
                    //console.log(companyid);
                    var t = t.data;

                    for(var i=0;i<t.length;i++){
                        if(t[i].parentId == companyid){
                            var  plist = [];
                            plist.push('<div class="part_name child-line" data-id="'+t[i].id+'"><a href="javascript:void(0)" title="'+t[i].name+'"> ');
                            plist.push('<i class="fa fa-caret-down" aria-hidden="true"></i>'+t[i].name);
                            plist.push('</a></div>');
                            // plist.push('<i class="fr" data-id="'+t[i].id+'" title="展开/折叠下级部门"><span class="toggleFun"></span></i></div>');

                            if(t[i].users){
                                plist.push('<ul class="part_list">');
                                var tlist = t[i].users;
                                if(tlist){
                                    for(var j=0;j<tlist.length;j++){
                                        if(!tlist[j].photo){
                                            tlist[j].photo = uemptyPhoto;
                                        }
                                        if(uName != tlist[j].name){
                                            plist.push('<li id="news-'+tlist[j].id+'">');
                                            plist.push(' <a href="javascript:void(0);" data-id="'+tlist[j].id+'">');
                                            plist.push('  <img id="i-'+tlist[j].id+'" src="'+tlist[j].photo+'"><span class="to_user_name">'+tlist[j].name+'</span><span class="fa fa-commenting" title="在线"></span>');
                                            plist.push('  <span class="news_nums">0</span>');
                                            plist.push(' </a>');
                                            plist.push('</li>');
                                        }
                                    }
                                }
                                plist.push('</ul>');
                            }
                            plist.push('<div class="child_'+t[i].id+' class2"></div>');
                            $("#people_list>div").append(plist.join(""));
                            Index.hasChildPart(t,t[i].id);
                            // var ischild = Index.hasChildPart(t,t[i].id);
                            // if(ischild.length>0){
                            //     $('.child_'+t[i].id).html(ischild.join(""));
                            // }
                        }
                    }




                    $(".numpeople").text(showOnlineList.length + '人在线');     //获取在线人数

                    for(var h = 0; h<showOnlineList.length;h++){
                        $('#news-'+showOnlineList[h].id).find('.fa').show();
                        $('#news-'+showOnlineList[h].id).addClass('opd5');
                    };
                    // console.log(showOnlineList);
                    Index.sessionStorageLoad(t);
                    var is_news_nums = $('#news-total').find('.news_nums').html();
                    if(is_news_nums != '0'){
                        Index.loadData('','','2',is_news_nums);
                        $('.news-total').find('.news_nums').hide().html('0');
                    }
                    Index.aitePeople();
                    Index.slidParentList();
                }
            });
        },
        hasChildPart:function(json,id){
            var t = json;
            for(var i=0; i<t.length; i++){
                if(t[i].parentId == id){
                    var plist = [];
                    plist.push('<div class="part_name child-line1"><a class="" href="javascript:void(0)"> ');
                    plist.push('<i class="fa fa-caret-down" aria-hidden="true"></i>'+t[i].name);
                    plist.push('</a></div>');
                    if(t[i].users){
                        plist.push('<ul class="part_list">');
                        var tlist = t[i].users;
                        if(tlist){
                            for(var j=0;j<tlist.length;j++){
                                $("#news-"+tlist[j].id).remove();
                                if(!tlist[j].photo){
                                    tlist[j].photo = uemptyPhoto;
                                }
                                if(uName != tlist[j].name){
                                    plist.push('<li id="news-'+tlist[j].id+'">');
                                    plist.push(' <a href="javascript:void(0);" data-id="'+tlist[j].id+'" class="talk-user">');
                                    plist.push('  <img id="i-'+tlist[j].id+'" src="'+tlist[j].photo+'"><span class="to_user_name">'+tlist[j].name+'</span><span class="fa fa-commenting" title="在线"></span>');
                                    plist.push('  <span class="news_nums">0</span>');
                                    plist.push(' </a>');
                                    plist.push('</li>');
                                }
                            }
                        }
                        plist.push('</ul>');
                    }
                    // plist.push('<div class="child_'+t[i].id+' has-line"></div>');
                    $(".child_"+t[i].parentId).append(plist.join(""));
                    // Index.hasChildPart(t,t[i].id);
                }

            }
        },
        //折叠部门人员列表
        slidParentList:function(){
            $('.part_name').off('click').on('click',function(){
                var istb = $(this).find('i');
                if(istb.hasClass('scal90')){
                    istb.removeClass('scal90')
                }else{
                    istb.addClass('scal90')
                }


                var isid = $(this).data('id');
                var isobj = $('.child_'+isid);
                if(isobj.css('display') == 'none'){
                    isobj.slideDown();
                }else{
                    isobj.slideUp();
                }

                if($(this).next('ul').children('li').length<1){
                    return;
                }
                if($(this).next('.part_list').css('display') == 'none'){
                    $(this).next('.part_list').stop().slideDown();
                }else{
                    $(this).next('.part_list').stop().slideUp();
                }

            });
        },
        // 展示系统提示
        showNotice:function (notice){
            var tpls = [];
            tpls.push('<li class="news">');
            tpls.push('<div><i class="fa fa-bell-o"></i>'+notice.content+'</div>');
            tpls.push('</li>');
            $('.chats').append(tpls.join(""));
            Index.scrollBottom();
        },
        // 回话控制窗口回到最底部
        scrollBottom:function (){
            $('#chats').find('.scroller').slimScroll({
                scrollTo: $('.chats').height()
            });
        },
        aitePeople:function(){
            $('#people_list').on('click','li',function(){
                // 切换人员时改变其样式
                $('#people_list li a').removeClass('active');
                $(this).find('a').addClass('active');

                // 查看未读消息
                var no_read_news = $(this).find('.news_nums').html();
                no_read_news == '0' ? no_read_news = '3': no_read_news;

                // 隐藏消息提醒，并清空消息记录
                $(this).find('.news_nums').hide().html('0');

                // 多人组群聊
                // var usser_name =  $(this).find('span').html();
                // // $('#sender').val(usser_name);
                // var receive = usser_name == "全体成员" ? "" : usser_name + ",";
                // if(receive.indexOf(usser_name) == -1){    //排除重复
                //     $(this).find('span').text(receive + user);
                // }

                // console.log($('#now_talk_people').val());
                // 获取接收人当前id
                var now_talk_id  = $(this).find('a').data('id');
                // 把当前id放入隐藏域
                if(!now_talk_id){
                    now_talk_id = 'total'
                }
                $('.is_aite_name').html($(this).find('.to_user_name').html());
                // 调取当前发送人发过来的信息
                if($('#now_talk_people').val() == now_talk_id){
                    return;
                }

                if(now_talk_id == "total"){
                    Index.loadData('','','2',no_read_news);
                }else{
                    Index.loadData(now_talk_id,userid,'3',no_read_news);

                }

                $('#now_talk_people').val(now_talk_id);

            });
            // 问答页跳转到聊天窗口
            Index.parentClick();
        },
        // 切换聊天对象时申请加载数据
        loadData:function(sid,uid,type,page,cont){
            $.ajax({
                url:urlpath + '/user/message/list.jhtml',
                type:'POST',
                data:{
                    'page.pageSize':page,
                    'senderid'     :sid,
                    'recieverid'  :uid,
                    'msgtype':type,
                    'content':(cont || '')
                },
                success:function(ret){
                    // console.log(ret);
                    if(ret.data.length != 0){
                        if(page - ret.data.length >= 10){
                            $('.chats .more_news').html('没有了');
                            return;
                        }
                        Index.tableChat(ret.data);
                    }else{
                        Index.tableChat('');
                    }
                }
            })
        },

        // 切换聊天对象时加载数据模板
        tableChat:function t(olds){
            // console.log(message);
            var tpls = [];
            if(olds){
                tpls.push('<li class="load_more">');
                tpls.push('<a class="more_news" href="javascript:void(0);">查看更多消息</a>');
                tpls.push('</li>');
                for(var n=olds.length-1;n>=0;n--){
                    var message = olds[n];
                    var to = message.recievername == null || message.recievername == ""? "全体成员" : message.recievername;   //获取接收人
                    var isSef = uName == message.sendername ? "out" : "in";   //如果是自己则显示在右边,他人信息显示在左边
                    //如果发送人是自己，则显示为我
                    if(message.sendername == uName)
                        message.sendername = '我';

                    tpls.push('<li class="'+isSef+'">');
                    if(isSef == 'out'){
                        tpls.push('<img class="avatar" alt="" src="'+ uphoto +'"/>');
                    }else{
                        var ophoto = $('#i-'+message.id).prop('src');
                        tpls.push('<img id="v-'+message.id+'" class="avatar" alt="" src="'+ (ophoto||uemptyPhoto) +'"/>');
                    }
                    tpls.push('<div class="message">');
                    tpls.push('<span class="arrow"></span>');
                    tpls.push('<a href="#" class="name">'+ message.sendername + '</a>&nbsp;');
                    tpls.push('<span class="datetime">发表于 ' + message.senddate + '</span>');
                    tpls.push('<span class="datetime">&nbsp;@' + to + '</span>');
                    tpls.push('<br/>');
                    tpls.push('<span class="body">');
                    tpls.push(message.content);
                    tpls.push('</span>');
                    tpls.push('</div>');
                    tpls.push('</li>');
                }
            }else{
                tpls.push('<li class="load_more">');
                tpls.push('<a class="" href="javascript:void(0);"><span class="fa fa-frown-o"></span>你们之间还没有进行过交流！</a>');
                tpls.push('</li>');
            }

            $('.chats').html(tpls.join(""));

            Index.moreNews();

        },
        // 加载更多消息
        moreNews:function(){
            $('.more_news').click(function(){
                var now_talk_id = $('#now_talk_people').val();
                // 查询条数
                var old_read_news = $('.chats .in').length + $('.chats .out').length + 10;

                if(now_talk_id == 'total'){
                    Index.loadData('','','2',old_read_news);
                }else{
                    // 参数：正在聊天的人的id，自己的id，消息类型，读取消息条数
                    Index.loadData(now_talk_id,userid,'3',old_read_news);
                }

            });
        },
        // 搜索内容
        searchData:function(){
            var conts = $('#keywords').val();
            var now_talk_id  = $('#now_talk_people').val();
            console.log(now_talk_id);
            if(now_talk_id == "total"){
                Index.loadData('','','2','10',conts);
            }else{
                Index.loadData(now_talk_id,userid,'3','10',conts);
            }
        },
        // 获取浏览器缓存
        sessionStorageLoad:function(list){
            // var isChatsData = fetch('ChatNum1');
            var isChatsData = top.onlineChatData;
            if(!isChatsData){
                return;
            }
            for(var j=0;j<isChatsData.length;j++){
                var htmlNum = Number($('#news-'+isChatsData[j].senderid).find('.news_nums').html()) + 1;
                $('#news-'+isChatsData[j].senderid).find('.news_nums').html(htmlNum).show();

            }
            top.$('#ischats').html('0').hide();
            top.onlineChatData = [];
        },
        // 问答窗口点击事件
        parentClick:function(){
            if(top.answer_chat_id){
                if( $('#news-'+top.answer_chat_id).length>0){
                    $('#news-'+top.answer_chat_id).trigger('click');
                }else{
                    layer.msg("该用户没在线", { offset: '50%'});
                }
            }
        },
        // 生成临时会话
        creatSessionTalk:function(){

        }
    };

}();
// 获取存储
function fetch(id){
    return JSON.parse(window.localStorage.getItem('keyName'+id));
}
//存储到本地
function save(str,id){
    var keyName = 'keyName'+id;
    window.localStorage.setItem(keyName,JSON.stringify(str));
}
function clear(id){
    var keyName = 'keyName'+id;
    window.localStorage.removeItem(keyName);
}
// session存储
function saveSisson(str,id){
    var keyName = 'keyName'+id;
    window.sessionStorage.setItem(keyName,JSON.stringify(str));
}