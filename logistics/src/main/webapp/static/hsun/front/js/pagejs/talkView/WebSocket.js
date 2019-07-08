var showOnlineList = [];
var onlineChatData = [];
function noLine(){
    $.ajax({
        url: urlpath + '/user/message/listUnRead.jhtml',
        type: "get",
        sync: false,
        success: function (t) {
            // console.log(t);
            var noline_data = t.data;
            // 计算消息数据
            for(var i=0;i<noline_data.length;i++){
                onlineChatData.push(
                    {'msgtype':noline_data[i].msgtype,'senddate':noline_data[i].senddate,'senderid':noline_data[i].senderid,'content':noline_data[i].content}
                );
            }
            // 计算消息条数
            $('#ischats').html(onlineChatData.length);
            if($('#ischats').html() - 1 >= 0){
                $('#ischats').css({'display':'block'});
            }else{
                $('#ischats').css({'display':'none'});
            }
        }
    });
}
noLine();
// 及时通讯服务 ===============================================================================================
var lhost = projectname;
var wsServer = "ws://" + location.host+lhost + "/webSocketServer.do";
var socketjsWsServer = "http://" + location.host+ lhost + "/sockjs/webSocketServer.do";
var ws = null;
if ('WebSocket' in window) {
    ws = new WebSocket(wsServer);
} else if ('MozWebSocket' in window) {
    ws = new MozWebSocket(wsServer);
} else {
    ws = new SockJS(socketjsWsServer);
}
// 建立连接
function getConnection(){
    if(ws == null){
        ws = new WebSocket(wsServer); //创建WebSocket对象
        ws.onopen = function (evt) {
            layer.msg("成功建立连接!", { offset: 0});
        };
        ws.onmessage = function (evt) {
            //Index.analysisMessage(evt.data);  //解析后台传回的消息,并予以展示
        };
        ws.onerror = function (evt) {
            layer.msg("产生异常", { offset: 0});
        };
        ws.onclose = function (evt) {
            layer.msg("已经关闭连接", { offset: 0});
        };
    }else{
        layer.msg("连接已存在!", { offset: 0, shift: 6 });
    }
}
// 关闭连接
function closeConnection(){
    if(ws != null){
        ws.close();
        ws = null;
        //$("#people_list>div").html("");    //清空在线列表
        layer.msg("已经关闭连接", { offset: 0});
    }else{
        layer.msg("未开启连接", { offset: 0, shift: 6 });
    }
}
// 检查连接
function checkConnection(){
    if(ws != null){
        layer.msg(ws.readyState == 0? "连接异常":"连接正常", { offset: 0});
    }else{
        layer.msg("连接未开启!", { offset: 0, shift: 6 });
    }
}
ws.onmessage = function (evt) {

    analysisMessage(evt.data);  //解析后台传回的消息,并予以展示
    // try{
    //     if(typeof(eval(Message))=="function"){
    //         Message(evt.data);
    //     }else{
    //     }
    // }catch(e){
    // }

    if($(".layui-layer-iframe").length>0){
        if($("iframe")[0].contentWindow.Index){
            $("iframe")[0].contentWindow.Index.analysisMessage(evt.data);
        }else{
            $("iframe")[1].contentWindow.Index.analysisMessage(evt.data);
        }
        $('#ischats').html('0').css({'display':'none'});
        onlineChatData = [];
    }
};
function sendData(m,uid,toid,toname){
    ws.send(JSON.stringify({
        data : {
            content : m,
            from : uid,
            to : toid,      //接收人,如果没有则置空,如果有多个接收人则用,分隔
            toUsername:toname
        }
    }))
}

// ws.onerror = function (evt) {
// 	layer.msg("产生异常", { offset: 0});
// };

// 及时通讯服务结束


function analysisMessage(message){
    message = JSON.parse(message);
    // console.log(message);
    if(message.msgtype == '1'){
        showOnlineList = message.list;
    }
    // console.log(showOnlineList);
    if($(".layui-layer-iframe").length<1){

        if(message.msgtype == "3" && message.recieverid == $('#getUserId').val()){
            onlineChatData.push(
                {'msgtype':message.msgtype,'senddate':message.senddate,'senderid':message.senderid,'content':message.content}
            );
        }else if(message.msgtype == "2" && message.senderid !== $('#getUserId').val()){
            onlineChatData.push(
                {'msgtype':message.msgtype,'senddate':message.senddate,'senderid':'total','content':message.content,'issenderid':message.senderid}
            );
        }


    }
    $('#ischats').html(onlineChatData.length);

    if($('#ischats').html() - 1 >= 0){
        $('#ischats').css({'display':'block'});
    }else{
        $('#ischats').css({'display':'none'});
    }
    // console.log(onlineChatData.length);
}
// 获取存储
// function fetch(id){
//     return JSON.parse(window.localStorage.getItem('keyName'+id));
// }
// //存储到本地
// function save(str,id){
//     var keyName = 'keyName'+id;
//     window.localStorage.setItem(keyName,JSON.stringify(str));
// }
// function clear(id){
//     var keyName = 'keyName'+id;
//     window.localStorage.removeItem(keyName);
// }
// // 获取session存储
// function sessionFetch(id){
//     return JSON.parse(window.sessionStorage.getItem('keyName'+id));
// }

