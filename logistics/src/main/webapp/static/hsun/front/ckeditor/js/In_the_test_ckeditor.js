
    // 全部变量，公式图片与xml映射
    var xml_data = "";
    var FormulaImgHash = {
        index: xml_data ? xml_data.index : 0, // 索引自增
        data: xml_data ? xml_data.answer_xml : {}, // 图片与xml映射内容
        answers: null, // 主观填空类图片答案
        getHash: function() {
            // 获取需要的图片与答案xml映射
            var ids = [];
            var _filter = function(str) {
                var reg = /data-kfformula-index="(\d+)"/g;
                var m;
                while (m = reg.exec(str)) {
                    ids.push(m[1]);
                }
            };
            _.each(this.answers, function(item, i) {
                if (typeof item === 'string') {
                    _filter(item);
                } else if (item != null && _.size(item) > 0) {
                    _.each(item, function(v, k) {
                        if (typeof v === 'string') _filter(v);
                    })
                }
            });
            var res = {};
            _.each(this.data, function(v, k) {
                k = k.toString();
                if (_.indexOf(ids, k) > -1) {
                    res[k] = v;
                }
            });
            return {
                answer_xml: res,
                index: this.index
            };
        }
    }
    // 公式编辑器

//				CKEDITOR.config.customConfig = 'config-custom.js';
        var current_editor = null;
        $('.fill-edit').each(function() {
            var _editor = CKEDITOR.inline(this);

            var self = this;
            _editor.on('change', function(evt) {
                var txt = _editor.getData();
                $(self).trigger('fillblank', txt);
            });
            $(this).on('dblclick', function(evt){
                if (typeof formulaShow === 'function') formulaShow();
                current_editor = _editor;
            });
            _editor.on('focus', function(evt) {
                current_editor = _editor;
            });

            $(this).parent('.edit-wrap2').find('.edit-show').on('click',function(){
                alert('ok');
                $(self).trigger('dblclick');
            });
        });

        if (document.body.addEventListener) {
            var $FeditorContainer = $('#formula-wrap');
            var formulaEditor_visible = false;
            var url = 'editor.html';
            $FeditorContainer.find('iframe').attr({
                'src': url
            });

            var formulaShow = function(state) {
                if (state === false) {
                    formulaEditor_visible = false;
                    $FeditorContainer.animate({
                        'right': '-800px'
                    }, 'slow');
                    return false;
                }
                if (formulaEditor_visible) return false;
                formulaEditor_visible = true;
                $FeditorContainer.animate({
                    'right': 0
                }, 'slow');
            };

            // formulaShow();
            $('#J_FormulaClose').click(function() {
                formulaShow(false);
            });

            $FeditorContainer.draggable({
                handle: '.formula-tit',
                axis: "y",
                containment: 'window'
            });

            window.formulaReady = function(feditor) {
                $('#J_FormulaOk').click(function() {

                    feditor.execCommand('get.image.data', function(data) {
                        var latex = feditor.execCommand('get.source');
                        var mathml = TeXZilla.toMathMLString(latex, false, false, true);
                        // var html = '<img class="kfformula" src="'+ data.img +'" data-mathexpression="' + encodeURI(mathml) + '" />';
                        var html = '<img class="kfformula" data-kfformula-index="' + FormulaImgHash.index + '" src="' + data.img + '" />';
                        FormulaImgHash.data[FormulaImgHash.index] = mathml; // 全部变量，公式图片与xml映射
                        FormulaImgHash.index += 1;
                        if (current_editor) current_editor.insertHtml(html);
                    });
                });

            }
        }

        //把编辑器的文本复制到相应的textarea
        $('.fill-edit').each(function(){
            $(this).off('blur').on('blur',function(){
                var this_html = $(this).html();
                $(this).parent('.four1').find('textarea').val(this_html);
            });
        });

