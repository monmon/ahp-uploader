var UploaderTable = (function(href){
	return {
		cgi: href.replace(/^https:\/\/homepage/, 'http://hpcgi') + 'index.cgi',
		cgiPathForUpdate: '/list/update',
		fileListId:       'fileList',
		loadingId:        'loading',
		hiddenClass:      'hidden'
	};
})(location.href);

// テーブル作成
UploaderTable.make = function(fileOf) {
	var self = this;  // UploaderTable
	var hiddenClass = self.hiddenClass;

	// ファイルがアップロードされていなければ抜ける
	if ($.isEmptyObject(fileOf)) return;

	var $table = $('<table/>');
	var files = $.each(fileOf, function(id, file){
	var pass = file.pass;
	var label = file.label || file.file;

	var $label = $('<td/>')
                .append('<a/>')
                .find(':last')
                    .attr('target', '_blank')
                    .attr('href', self.cgi + '/dl?id=' + id)
                    .text(label)
                .end()
                .append('<input type="text"/>')
                .find(':last')
                    .addClass(hiddenClass)
                    .val(label)
                .end()
                .children()
                    .addClass('label')
                .end();

	var $pass = $('<td/>')
                .append('<span/>')
                .find(':last')
                    .text(pass || 'input pass')
                .end()
                .append('<input type="text"/>')
                .find(':last')
                    .addClass(hiddenClass)
                    .val(pass || '')
                .end()
                .children()
                    .addClass('pass')
                .end();

	$table
	        .append('<tr/>')
	        .find(':last')
	            .attr('id', id)
	            .append($label)
	            .append($pass)
	        .end();
	});


	// 描画 + クリックイベント
	$('#' + self.fileListId)
	.empty()
	.append($table)
	.find('> table')
	    .find('tr:odd')
	        .addClass('odd')
	    .end()
	    .prepend('<tr/>')
	    .find('tr:first')
	        .append('<th/>')
	        .find(':last')
	            .text('ファイル名（ダウンロード用リンク）')
	        .end()
	        .append('<th/>')
	        .find(':last')
	            .text('ダウンロード用パスワード')
	        .end()
	    .end()
	    .find('td')
	        .click(function(e){
	            var targetNodeName = $(e.target).get(0).nodeName;
	            if (! /^(?:A|INPUT)$/.test(targetNodeName)) { // AとINPUTの時は何もしない
	                self.toggleField(this);
	            }
	        })
	        .find('input')
	            .keyup(function(e){
	                if (e.keyCode === 13) {  // Enter
	                    self.updateField(this);
	                }
	            });

}
// テーブル内フィールドをinputにする、戻す
UploaderTable.toggleField = function(elem) {
	var self = this;
	var hiddenClass = this.hiddenClass;

	$(elem).children().toggleClass(hiddenClass);
}

// テーブル内データの更新
UploaderTable.redrawField = function(dataOf) {
	var self = this;
	var hiddenClass = this.hiddenClass;

	$.each(dataOf, function(id, file){
	    $.each(file, function(key, val){
	        $('#' + id + ' .' + key).each(function(i, elem){
	            var $inputOrNotElem = $(elem);
	            if ($inputOrNotElem.get(0).nodeName === 'INPUT') {
	                $inputOrNotElem.val(val);
	            }
	            else {
	                $inputOrNotElem.text(val);
	            }
	        }).toggleClass(hiddenClass);
	    });
	});
}

// テーブル内フィールド編集でcreate script
UploaderTable.updateField = function(elem) {
	var self = this; // UploaderTable

	var $input = $(elem);
	var requestData = {
	    id: $input.parents('tr').attr('id')
	};
	requestData[$input.attr('class')] = $input.val();

	var $loadingImg = $('#' + self.loadingId);
    $loadingImg.insertAfter($input).show();
	$.getJSON(self.cgi + self.cgiPathForUpdate + '?cb=?', requestData, function(data){
	    $loadingImg.hide();
	    self.redrawField(data);
	});
}
