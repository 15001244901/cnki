$(function() {
	magorpageIntelligence.init();
	magorpageIntelligence.range();
});
var magorpageIntelligence = {
	//初始化
	init: function() {
		$("#divheader").load(projectname + "/page/include/headerquestion.html"+timestamps);
		$.ajax({
			url: urlpath + '/user/practice/practice.jhtml',
			type: "GET",
			data: {
				ptype: 2
			},
			success: function(t) {
				var success = t.success;

				if(success) {
					//题库字典
					//var qdbs = t.data.qdbs;

					//组卷内容
					var contents = t.data.contents;
					var paperhtml = [];
					if(typeof(contents) != "undefined") {
						paperhtml.push('<span><a name="papertype" class="active" onclick="magorpageIntelligence.choosePaperType(this,\'\')">不限</a></span>');
						for(i = 0; i < contents.length; i++) {
							paperhtml.push('<span><a name="papertype" onclick="magorpageIntelligence.choosePaperType(this,\'' + contents[i].value + '\')">' + contents[i].label + '</a></span>');
						}
						$("#paperTD").html(paperhtml.join(""));
					}
					//科目
					var subjects = t.data.subjects;
					var subjecthtml = [];
					if(typeof(subjects) != "undefined") {
						subjecthtml.push('<span><a name="subjecttype" class="active" onclick="magorpageIntelligence.chooseSubjectType(this,\'\')">不限</a></span>');
						for(i = 0; i < subjects.length; i++) {
							subjecthtml.push('<span><a name="subjecttype" onclick="magorpageIntelligence.chooseSubjectType(this,\'' + subjects[i].value + '\')">' + subjects[i].label + '</a></span>');
						}
						$("#subjectTD").html(subjecthtml.join(""));
					}

					//知识点
					var topics = t.data.topics;
					var topichtml = [];
					if(typeof(topics) != "undefined") {
						topichtml.push('<span><a name="topictype" class="active" onclick="magorpageIntelligence.chooseTopicType(this,\'\')">不限</a></span>');
						for(i = 0; i < topics.length; i++) {
							topichtml.push('<span><a name="topictype" onclick="magorpageIntelligence.chooseTopicType(this,\'' + topics[i].value + '\')">' + topics[i].label + '</a></span>');
						}
						$("#topicTD").html(topichtml.join(""));
					}

					//题型
					var types = t.data.types;
					var typeshtml = [];
					if(typeof(typeshtml) != "undefined") {
						typeshtml.push('<span><a name="typestype" class="active" onclick="magorpageIntelligence.chooseTypes(this,\'\')">不限</a></span>');
						for(i = 0; i < types.length; i++) {
							typeshtml.push('<span><a name="typestype" onclick="magorpageIntelligence.chooseTypes(this,\'' + types[i].value + '\')">' + types[i].label + '</a></span>');
						}
						$("#questionTD").html(typeshtml.join(""));
					}
					//难度
					var levels = t.data.levels;
					var levelshtml = [];
					if(typeof(levelshtml) != "undefined") {
						levelshtml.push('<span><a name="levelstype" class="active" onclick="magorpageIntelligence.chooseLevelTypes(this,\'\')">不限</a></span>');
						for(i = 0; i < levels.length; i++) {
							levelshtml.push('<span><a name="levelstype" onclick="magorpageIntelligence.chooseLevelTypes(this,\'' + levels[i].value + '\')">' + levels[i].label + '</a></span>');
						}
						$("#levelTD").html(levelshtml.join(""));
					}
				}
			}
		});
	},
	//针对练习
	practice: function(lthis) {
		var practice = document.getElementsByName("practice");
		for(var i = 0; i < practice.length; i++) {
			$(practice[i]).removeClass("active");
		}
		$(lthis).addClass("active");
		$("#practicetype").val();
	},
	//组卷内容
	choosePaperType: function(lthis, id) {
		var paper = document.getElementsByName("papertype");
		for(var i = 0; i < paper.length; i++) {
			$(paper[i]).removeClass("active");
		}
		$(lthis).addClass("active");
		$("#papertype").val(id);
	},
	//科目
	chooseSubjectType: function(athis, id) {
		var subjectType = document.getElementsByName("subjecttype");
		for(var i = 0; i < subjectType.length; i++) {
			$(subjectType[i]).removeClass("active");
		}
		$(athis).addClass("active");
		$("#subjecttype").val(id);
	},

	//知识点
	chooseTopicType: function(athis, id) {
		var topicType = document.getElementsByName("topictype");
		for(var i = 0; i < topicType.length; i++) {
			$(topicType[i]).removeClass("active");
		}
		$(athis).addClass("active");
		$("#topictype").val(id);
	},
	//点击题型
	chooseTypes: function(athis, id) {
		var questionType = document.getElementsByName("typestype");
		for(var i = 0; i < questionType.length; i++) {
			$(questionType[i]).removeClass("active");
		}
		$(athis).addClass("active");
		$("#questiontype").val(id);
	},
	//点击难度
	chooseLevelTypes: function(athis, id) {
		var levelType = document.getElementsByName("levelstype");
		for(var i = 0; i < levelType.length; i++) {
			$(levelType[i]).removeClass("active");
		}
		$(athis).addClass("active");
		$("#leveltype").val(id);
	},
	//创建试卷
	creatPaper: function() {
		var p_name = $("#txtPaperName").val();
		var p_duration = $("#lbltime").html();
		var p_section_names = "";
		var p_section_remarks = "";
		var p_dbids = "9ef3867b-be99-459e-ad4a-79d1eabaa0ec";
		var p_contents = $("#papertype").val();
		var p_subjects = $("#subjecttype").val();
		var p_topics = $("#topictype").val();
		var p_qtypes = $("#questiontype").val();
		var p_levels = $("#leveltype").val();
		var p_qnums = $("#lblnums").html();
		var p_scores = $("#lblScore").html();
		if(p_name == ''){
			layer.msg(
				'试卷名称不能为空',
				{
					icon:5,
					time:3000,
					skin: 'layui-layer-molv'
					// title:'系统提示',
				}
			);
			return;
		}
		$.ajax({
			url: urlpath + '/user/practice/startPractice.jhtml',
			type: "POST",
			data: {
				ptype: 2,
				p_name: p_name,
				p_duration: p_duration,
				p_section_names: p_section_names,
				p_section_remarks: p_section_remarks,
				p_dbids: '',
				p_contents: p_contents,
				p_subjects: p_subjects,
				p_topics:p_topics,
				p_qtypes: p_qtypes,
				p_levels: p_levels,
				p_qnums: p_qnums,
				p_scores: p_scores
			},
			success: function(t) {
				console.log(t);
				if(t.success) {
					window.location.href = "simulation_test.html";
				} else {
					alert(t.msg)
				}
			}
		});
	},
	//跳转
	skip: function(type) {
		if(type == 0) {
			window.location.href = "majorpage.html";
		} else if(type == 1) {
			window.location.href = "magorpageIntelligence.html";
		} else if(type == 2) {
			window.location.href = "majorpageQuestion.html";
		} else if(type == 3){
			window.location.href = "auto_creat_practice_paper.html";
		}
	},
	//题目数量
	change2: function(o, e) {
		var e = e ? e : window.event;
		if(!window.event) {
			e.preventDefault();
		}
		var tX = o.offsetLeft,
			dx = e.clientX;
		document.onmousemove = function(e) {
			var e = e ? e : window.event;
			var len = tX + e.clientX - dx;
			if(len >= 0 && len <= 890) {
				o.style.left = len - 8 + "px";
				//alert(1 + Math.round(len / 10))
				document.getElementById('lblnums').innerHTML = 1 + Math.round(len / 10);
			}
		}
		document.onmouseup = function() {
			document.onmousemove = null;
			document.onmouseup = null;
		}
	},
	//推荐时间
	change3: function(o, e) {
		var e = e ? e : window.event;
		if(!window.event) {
			e.preventDefault();
		}
		var tX = o.offsetLeft,
			dx = e.clientX;
		document.onmousemove = function(e) {
			var e = e ? e : window.event;
			var len = tX + e.clientX - dx;
			if(len >= 0 && len <= 890) {
				o.style.left = len - 8 + "px";
				document.getElementById('lbltime').innerHTML = 1 + Math.round(len / 10);
			}
		}
		document.onmouseup = function() {
			document.onmousemove = null;
			document.onmouseup = null;
		}
	},
	//每题分数
	changeScore: function(o, e) {
		var e = e ? e : window.event;
		if(!window.event) {
			e.preventDefault();
		}
		var tX = o.offsetLeft,
			dx = e.clientX;
		document.onmousemove = function(e) {
			var e = e ? e : window.event;
			var len = tX + e.clientX - dx;
			if(len >= 0 && len <= 190) {
				o.style.left = len - 8 + "px";
				document.getElementById('lblScore').innerHTML = 1 + Math.round(len / 10);
			}
		}
		document.onmouseup = function() {
			document.onmousemove = null;
			document.onmouseup = null;
		}
	},
	//画圆
	range: function() {
		/*上面画圆*/
		var c = document.getElementById("myCanvas");
		var cxt = c.getContext("2d");
		cxt.beginPath();
		cxt.strokeStyle = "#F49600";
		cxt.arc(10, 13, 1.5, 0, Math.PI * 2, true);
		cxt.lineWidth = 2;
		cxt.stroke(); //画空心圆  
		cxt.strokeStyle = "#zzzzzz";
		cxt.fillText("1", 7, 45);
		cxt.closePath();
		cxt.beginPath();
		cxt.strokeStyle = "#F49600";
		cxt.arc(110, 13, 1.5, 0, Math.PI * 2, true);
		cxt.strokeStyle = "#zzzzzz";
		cxt.fillText("10", 107, 45);
		cxt.lineWidth = 2;
		cxt.stroke(); //画空心圆  
		cxt.closePath();
		cxt.beginPath();
		cxt.strokeStyle = "#F49600";
		cxt.arc(210, 13, 1.5, 0, Math.PI * 2, true);
		cxt.strokeStyle = "#zzzzzz";
		cxt.fillText("20", 207, 45);
		cxt.lineWidth = 2;
		cxt.stroke(); //画空心圆  
		cxt.closePath();
		cxt.beginPath();
		cxt.arc(610, 13, 1.5, 0, Math.PI * 2, true);
		cxt.lineWidth = 2;
		cxt.strokeStyle = "#F49600";
		cxt.stroke(); //画空心圆  
		cxt.strokeStyle = "#zzzzzz";
		cxt.fillText("60", 607, 45);
		cxt.closePath();
		cxt.beginPath();
		cxt.arc(910, 13, 1.5, 0, Math.PI * 2, true);
		cxt.lineWidth = 2;
		cxt.strokeStyle = "#F49600";
		cxt.stroke(); //画空心圆  
		cxt.strokeStyle = "#zzzzzz";
		cxt.fillText("90", 907, 45);
		cxt.closePath();
		/*下面画圆*/
		var c = document.getElementById("myCanvas1");
		var cxt = c.getContext("2d");
		cxt.beginPath();
		cxt.strokeStyle = "#F49600";
		cxt.arc(10, 13, 1.5, 0, Math.PI * 2, true);
		cxt.lineWidth = 2;
		cxt.stroke(); //画空心圆  
		cxt.strokeStyle = "#zzzzzz";
		cxt.fillText("1", 7, 45);
		cxt.closePath();
		cxt.beginPath();
		cxt.strokeStyle = "#F49600";
		cxt.arc(310, 13, 1.5, 0, Math.PI * 2, true);
		cxt.strokeStyle = "#zzzzzz";
		cxt.fillText("30", 307, 45);
		cxt.lineWidth = 2;
		cxt.stroke(); //画空心圆  
		cxt.closePath();
		cxt.beginPath();
		cxt.arc(610, 13, 1.5, 0, Math.PI * 2, true);
		cxt.lineWidth = 2;
		cxt.strokeStyle = "#F49600";
		cxt.stroke(); //画空心圆  
		cxt.strokeStyle = "#zzzzzz";
		cxt.fillText("60", 607, 45);
		cxt.closePath();
		cxt.beginPath();
		cxt.arc(910, 13, 1.5, 0, Math.PI * 2, true);
		cxt.lineWidth = 2;
		cxt.strokeStyle = "#F49600";
		cxt.stroke(); //画空心圆  
		cxt.strokeStyle = "#zzzzzz";
		cxt.fillText("90", 907, 45);
		cxt.closePath();

		/*每题分值画圆*/
		var c = document.getElementById("myCanvasScores");
		var cxt = c.getContext("2d");
		cxt.beginPath();
		cxt.strokeStyle = "#F49600";
		cxt.arc(10, 13, 1.5, 0, Math.PI * 2, true);
		cxt.lineWidth = 2;
		cxt.stroke(); //画空心圆  
		cxt.strokeStyle = "#zzzzzz";
		cxt.fillText("1", 7, 45);
		cxt.closePath();
		cxt.beginPath();
		cxt.strokeStyle = "#F49600";
		cxt.arc(110, 13, 1.5, 0, Math.PI * 2, true);
		cxt.strokeStyle = "#zzzzzz";
		cxt.fillText("10", 107, 45);
		cxt.lineWidth = 2;
		cxt.stroke(); //画空心圆  
		cxt.closePath();
		cxt.beginPath();
		cxt.strokeStyle = "#F49600";
		cxt.arc(210, 13, 1.5, 0, Math.PI * 2, true);
		cxt.strokeStyle = "#zzzzzz";
		cxt.fillText("20", 207, 45);
		cxt.lineWidth = 2;
		cxt.stroke(); //画空心圆  
		cxt.closePath();
	}
}