$(function(){
    //优化click事件
    FastClick.attach(document.body);

    var practiceRecordFun = function(){
        var that = this;
        var pageNo = 1;
        var pageTotalNum;

        this.shade = $('.shade');

        this.record_list = $('.record_list ul');   //列表容器
        this.list_model  = $('#list_model').html(); //模板

        this.page_btnl = $('.page_btnl');       //上一页
        this.page_btnlr = $('.page_btnr');      //下一页
        this.now_page_num = $('.now_page_num');     //当前页码
        this.page_btnnum  = $('.page_btnnum');   //跳转页码
        this.total_page_num = $('.total_page_num'); //总页码
        this.page_num_list = $('.page_num_list');
        this.page_num      = $('.page_num');

        this.del_item = $('.del_item');   //删除面板容器
        this.del_item_panel = $('.del_item_panel');  //删除面板
        this.delobj_id;

        this.loadData = function(){
            publicFun.loading($('body'));

            $.ajax({
                url: urlpath + '/user/practice/history.jhtml',
                type: "GET",
                data: {
                    pageNo: pageNo,
                    pageSize: 10
                    // keyword: keyword,
                },
                success:function(t){
                    //console.log(t);
                    var datas = t.data;
                    if(t.success && datas.list && datas.list.length>0){
                        var items = datas.list;

                        var domString = ' ';
                        for (var i = 0; i < items.length; i++) {
                            var dictionary = items[i];
                            domString += publicFun.comPile(that.list_model,dictionary);
                        }
                        that.record_list.html(domString);
                        // that.hammerDelFun();
                        that.showDelFun();
                    }else{
                        publicFun.noData(that.record_list);
                    }

                    if(datas.totalPageCount > 1){
                        $('.page').show();
                    }else{
                        $('.page').hide();
                    }
                    that.total_page_num.html(datas.totalPageCount);
                    that.now_page_num.html(datas.pageNo);

                    $('.loading').remove();
                    that.loadPage(datas.totalPageCount);

                    that.exam_infor = $('.exam_infor');
                    that.exam_infor.off('touchstart').on('touchstart',that.goNext);
                }
            });
        };

        this.hammerDelFun = function(){
            var aLi = document.getElementsByTagName("li");
            for(var i=0;i<aLi.length;i++) {
                (function(i){
                    var hammerLi = new Hammer(aLi[i]);
                    hammerLi.on("pan", function(e){
                        console.log(e.deltaX);
                        // var posX = $('#test').css('transform').replace(/[^0-9\-,]/g,'').split(',')[4];
                        if(Math.abs(e.deltaX)>Math.abs(e.deltaY)) {
                            if(e.deltaX<-10){
                                $('li').eq(i).css('transform','translateX(-18vw)');

                            }else if(e.deltaX>0){
                                $('li').eq(i).css('transform','translateX(0)');
                            }
                        }


                    });

                })(i);
            }
        };

        this.showDelFun = function(){
            var expansion = null; //是否存在展开的list
            var container = document.querySelectorAll('.record_list ul li');

            for(var i = 0; i < container.length; i++){
                var x, y, X, Y, swipeX, swipeY;
                container[i].addEventListener('touchstart', function(event) {
                    x = event.changedTouches[0].pageX;
                    y = event.changedTouches[0].pageY;
                    swipeX = true;
                });
                container[i].addEventListener('touchmove', function(event){


                    X = event.changedTouches[0].pageX;
                    Y = event.changedTouches[0].pageY;
                    // 左右滑动
                    if(swipeX && Math.abs(X - x) - Math.abs(Y - y) > 0){
                        // 阻止事件冒泡
                        event.stopPropagation();
                        if(X - x > 10){   //右滑
                            event.preventDefault();

                            this.style.transform = 'translateX(0)'; //右滑收起
                        }
                        if(x - X > 10){   //左滑
                            event.preventDefault();
                            this.style.transform = 'translateX(-14%)'; //左滑展开
                            if(expansion && expansion != this){
                                expansion.style.transform = 'translateX(0)';
                            }
                            expansion = this;
                        }
                    }else {
                        swipeX = false;
                    }

                });
            }
        };

        //加载分页
        this.loadPage = function(totalnum){
            if(pageTotalNum == totalnum){
                return;
            }
            pageTotalNum = totalnum;
            var pages = totalnum;
            var pagearr = [];
            for (var i = 0; i < pages; i++) {
                pagearr.push('<li data-num="'+(i+1)+'">第'+(i+1)+'页</li>');
            }
            that.page_num_list.html(pagearr.join(""));

            that.page_num_item = that.page_num_list.find('li');
            that.page_num_item.off('click').on('click',that.goPage);

        };

        this.showPagePanel = function(){

            that.page_num_item.removeClass('bg_success');
            that.page_num_item.eq(pageNo-1).addClass('bg_success');
            that.page_num.css('height','5rem');
            $('.shade').fadeIn();
        };
        this.hidePagePanel = function(){
            that.page_num.css('height',0);
            $('.shade').fadeOut();
        };
        // 跳转
        this.goPage = function(){
            var num = $(this).data('num');
            pageNo = num;
            publicFun.backgroundClick($(this));
            that.loadData();
            that.hidePagePanel();
        };
        //上一页
        this.prevPageFun = function(){
            if(pageNo <= 1){
                publicFun.alertBox('已经到第一页了');
                return;
            }
            pageNo = pageNo -1;
            that.loadData();
        };
        //下一页
        this.nextPageFun = function(){
            var totalnum = Number(that.total_page_num.html());
            if(pageNo >= totalnum){
                publicFun.alertBox('已经到最后一页了');
                return;
            }
            pageNo = pageNo + 1;
            that.loadData();
        };

        //显示删除面板
        showDel = function(is,id){
            console.log(id);
            that.del_item.fadeIn();
            that.del_item_panel.css('bottom','0');
            that.delobj_id = id;
        };

        //隐藏删除面板
        this.hideDel = function(){
            that.del_item_panel.css('bottom','-2.68rem');
            that.del_item.fadeOut();
        };

        //删除记录
        this.delItem  = function(event){
            event.preventDefault();
            event.stopPropagation();
            var isdel = $(this).data('del');
            console.log(isdel);
            if(isdel){
                that.delItemAjax();
            }
            that.hideDel();
        };
        this.delItemAjax = function(id){
            $.ajax({
                url: urlpath + '/user/practice/delete.jhtml?id='+that.delobj_id,
                type: "GET",
                success:function(ret){
                    //console.log(ret);
                    if(ret.success){
                        that.loadData();
                        publicFun.alertBox(ret.msg)
                    }else{
                        publicFun.alertBox(ret.msg,1)
                    }
                }
            })
        };

        this.goNext = function(e){
            var x,y,x1,y1;
            var move = true;

            var isid = $(this).data('id');
            var touch = e.originalEvent.targetTouches[0];

            x = touch.pageX;
            y = touch.pageY;

            $(this).off('touchend').on('touchend',function(e) {

                var touch2 = e.originalEvent.changedTouches[0];

                x1 = touch2.pageX;
                y1 = touch2.pageY;

                if(x == x1 && y == y1){
                    if(!publicFun.validateUser()){
                        publicFun.jumpLoginPage2();
                        return;
                    }
                    window.location.href = "practiceContent.html?id="+isid;
                }

            });

        };

        this.init = function(){
            this.loadData();
            // 分页
            this.page_btnl.off('click').on('click',this.prevPageFun);
            this.page_btnlr.off('click').on('click',this.nextPageFun);
            this.page_btnnum.off('click').on('click',this.showPagePanel);
            this.shade.off('click').on('click',this.hidePagePanel);

            //删除面板
            this.del_item.off('click').on('click',this.hideDel);
            this.del_item_panel.find('div').off('click').on('click',this.delItem);
        }
    };

    var practiceRecord = new practiceRecordFun;
    practiceRecord.init();

});