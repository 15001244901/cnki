$(function() {
	errorcorrection.init();
});
var errorcorrection = {
	//初始化
	init: function() {
		$("#divheader").load(projectname + "/page/include/headerquestion.html");
		var id = errorcorrection.getQueryString("id");
		$("#hidQid").val(id);
	},
	//提交错误
	saveError: function() {
		var index = parent.layer.getFrameIndex(window.name);

		var uid = useruid;
		var qid = $("#hidQid").val();
		var content = $("#txtContent").val();
		var inp_text = $("#inp_text").val();
		if(content == "") {
			alert("内容不能为空")
			return;
		}
		if(inp_text == "") {
			alert("验证码不能为空")
			return;
		}
		$.ajax({
			url: urlpath_a + '/exam/question/commentsave.jhtml',
			type: "GET",
			data: {
				//uid: uid,
				qid: qid,
				ctype: 3,
				content: content,
				validateCode: inp_text
			},
			success: function(t) {
				//alert(t)
				if(t.success) {
					alert(t.msg);
					parent.layer.close(index);
				} else {
					alert(t.msg)
				}
			}
		});
	},
	//关闭窗口
	closePage: function() {
		var index = parent.layer.getFrameIndex(window.name);
		parent.layer.close(index);
	},
	//获取url参数传值
	getQueryString: function(key) {
		var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
		var result = window.location.search.substr(1).match(reg);
		return result ? decodeURIComponent(result[2]) : null;
	}
}